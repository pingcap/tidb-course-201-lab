import boto3, subprocess, re, time


region = "us-west-2"
sqs = boto3.client("sqs", region_name=region)
ec2 = boto3.client("ec2", region_name=region)
sts = boto3.client("sts", region_name=region)
elbv2 = boto3.client("elbv2", region_name=region)
aws_account_id = sts.get_caller_identity()["Account"]
queue_url = "https://sqs." + region + ".amazonaws.com/" + aws_account_id + "/demo-queue"


def create_tidb_yaml(tidb_address: str):
    template = """
    tidb_servers:
        - host: <IP>
          port: 4000
          status_port: 10080
          deploy_dir: /tidb-deploy/tidb-4000
          log_dir: /tidb-deploy/tidb-4000/log
    """
    f = open("./sd-002-tidb-scale-out.yaml", "w")
    f.writelines(template.replace("<IP>", tidb_address))
    f.close()
    return "./sd-002-tidb-scale-out.yaml"


def add_tidb_instance(scale_out_yaml_file: str):
    try:
        fix_status = subprocess.check_output(
            [
                "/home/ec2-user/.tiup/bin/tiup",
                "cluster",
                "check",
                "tidb-demo",
                scale_out_yaml_file,
                "--cluster",
                "--apply",
            ]
        ).decode("utf-8")
        print(fix_status)

        cluster_status = subprocess.check_output(
            [
                "/home/ec2-user/.tiup/bin/tiup",
                "cluster",
                "scale-out",
                "tidb-demo",
                scale_out_yaml_file,
                "--yes",
            ]
        ).decode("utf-8")
        print(cluster_status)
    except subprocess.CalledProcessError as ex:
        print("Scaling out TiDB instance skipped.")
        return 1


def register_tidb_instance_to_nlb(tidb_address: str):
    demo_target_group_name = "demo-target-group"
    response = elbv2.describe_target_groups(Names=[demo_target_group_name])
    target_group_arn = response["TargetGroups"][0]["TargetGroupArn"]
    elbv2.register_targets(
        TargetGroupArn=target_group_arn,
        Targets=[
            {"Id": tidb_address, "Port": 4000},
        ],
    )


def check_queue():
    res = sqs.receive_message(QueueUrl=queue_url)
    if "Messages" in res:
        for m in res["Messages"]:
            r_handle = m["ReceiptHandle"]
            m_body = m["Body"]
            print("Got message:", m_body)
            node_type = m_body.split("::")[0]
            node_action = m_body.split("::")[1]
            node_address = m_body.split("::")[2]
            cluster_status = subprocess.check_output(
                ["/home/ec2-user/.tiup/bin/tiup", "cluster", "display", "tidb-demo"]
            ).decode("utf-8")
            print(cluster_status)
            print("Node action:", node_action)
            if node_action == "scale-out":
                for line in cluster_status.split("\n"):
                    if re.match(node_address, line):
                        print(
                            node_type, "node", node_address, "already joined cluster."
                        )
                        sqs.delete_message(QueueUrl=queue_url, ReceiptHandle=r_handle)
                        return
                print(node_type, "adding node", node_address, "to cluster.")
                if node_type == "TiDB":
                    yaml = create_tidb_yaml(node_address)
                    ret = add_tidb_instance(yaml)
                    if ret != 1:
                        register_tidb_instance_to_nlb(node_address)
            elif node_action == "scale-in":
                for line in cluster_status.split("\n"):
                    if re.match(node_address, line):
                        print(node_type, "removing node", node_address, "from cluster.")
                        sqs.delete_message(QueueUrl=queue_url, ReceiptHandle=r_handle)
                        return
                print(node_type, "node", node_address, "already left cluster.")
            sqs.delete_message(QueueUrl=queue_url, ReceiptHandle=r_handle)


while True:
    check_queue()
    time.sleep(10)
