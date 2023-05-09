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


def create_tikv_yaml(tikv_address: str):
    template = """
    tikv_servers:
        - host: <IP>
          port: 20160
          status_port: 20180
    """
    f = open("./sd-002-tikv-scale-out.yaml", "w")
    f.writelines(template.replace("<IP>", tikv_address))
    f.close()
    return "./sd-002-tikv-scale-out.yaml"


def add_instance(scale_out_yaml_file: str):
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
        print("Listener: Scaling out skipped.")
        print("Listener: Terminate the new instance.")
        return 1


def remove_tidb_instance(tidb_address: str):
    try:
        cluster_status = subprocess.check_output(
            [
                "/home/ec2-user/.tiup/bin/tiup",
                "cluster",
                "scale-in",
                "tidb-demo",
                "--node",
                tidb_address + ":4000",
                "--force",
                "--yes",
            ]
        ).decode("utf-8")
        print(cluster_status)
    except subprocess.CalledProcessError as ex:
        print("Scaling in TiDB instance skipped.")
        return 1


def remove_tikv_instance(tikv_address: str):
    try:
        cluster_status = subprocess.check_output(
            [
                "/home/ec2-user/.tiup/bin/tiup",
                "cluster",
                "scale-in",
                "tidb-demo",
                "--node",
                tikv_address + ":20160",
                "--yes",
            ]
        ).decode("utf-8")
        print(cluster_status)
        time.sleep(18)
        cluster_status = subprocess.check_output(
            [
                "/home/ec2-user/.tiup/bin/tiup",
                "cluster",
                "prune",
                "tidb-demo",
                "--yes",
            ]
        ).decode("utf-8")
        print(cluster_status)
    except subprocess.CalledProcessError as ex:
        print("Scaling in TiDB instance skipped.")
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


def deregister_tidb_instance_from_nlb(tidb_address: str):
    demo_target_group_name = "demo-target-group"
    response = elbv2.describe_target_groups(Names=[demo_target_group_name])
    target_group_arn = response["TargetGroups"][0]["TargetGroupArn"]
    elbv2.deregister_targets(
        TargetGroupArn=target_group_arn,
        Targets=[
            {"Id": tidb_address},
        ],
    )


def check_queue():
    res = sqs.receive_message(QueueUrl=queue_url)
    if "Messages" in res:
        for m in res["Messages"]:
            r_handle = m["ReceiptHandle"]
            m_body = m["Body"]
            print("\nGot message:", m_body)
            node_type = m_body.split("::")[0]
            node_action = m_body.split("::")[1]
            node_address = m_body.split("::")[2]
            cluster_status = subprocess.check_output(
                ["/home/ec2-user/.tiup/bin/tiup", "cluster", "display", "tidb-demo"]
            ).decode("utf-8")
            # print(cluster_status)
            print("Node action:", node_action)
            if node_action == "scale-out":
                for line in cluster_status.split("\n"):
                    if re.match(node_address, line):
                        print(
                            node_type, "node", node_address, "already joined cluster."
                        )
                        if node_type == "TiDB":
                            register_tidb_instance_to_nlb(node_address)
                            sqs.delete_message(
                                QueueUrl=queue_url, ReceiptHandle=r_handle
                            )
                        return
                print(node_type, "adding node", node_address, "to cluster.")
                if node_type == "TiDB":
                    yaml = create_tidb_yaml(node_address)
                    add_instance(yaml)
                    register_tidb_instance_to_nlb(node_address)
                elif node_type == "TiKV":
                    yaml = create_tikv_yaml(node_address)
                    add_instance(yaml)
            elif node_action == "scale-in":
                for line in cluster_status.split("\n"):
                    if re.match(node_address, line):
                        print(node_type, "removing node", node_address, "from cluster.")
                        if node_type == "TiDB":
                            deregister_tidb_instance_from_nlb(node_address)
                            remove_tidb_instance(node_address)
                            sqs.delete_message(
                                QueueUrl=queue_url, ReceiptHandle=r_handle
                            )
                            return
                        elif node_type == "TiKV":
                            remove_tikv_instance(node_address)
                            sqs.delete_message(
                                QueueUrl=queue_url, ReceiptHandle=r_handle
                            )
                            return
                print(node_type, "node", node_address, "left cluster.")
            sqs.delete_message(QueueUrl=queue_url, ReceiptHandle=r_handle)


while True:
    check_queue()
    time.sleep(10)
