import boto3, subprocess, re, time


region = "us-west-2"
sqs = boto3.client("sqs", region_name=region)
ec2 = boto3.client("ec2", region_name=region)
sts = boto3.client("sts", region_name=region)
aws_account_id = sts.get_caller_identity()["Account"]
queue_url = "https://sqs." + region + ".amazonaws.com/" + aws_account_id + "/demo-queue"
res = sqs.receive_message(QueueUrl=queue_url)


def check_queue():
    if "Messages" in res:
        for m in res["Messages"]:
            r_handle = m["ReceiptHandle"]
            m_body = m["Body"]
            node_type = m_body.split("::")[0]
            node_action = m_body.split("::")[1]
            node_address = m_body.split("::")[2]
            cluster_status = subprocess.check_output(
                ["/home/ec2-user/.tiup/bin/tiup", "cluster", "display", "tidb-demo"]
            ).decode("utf-8")
            print(cluster_status)
            if node_action == "scale-out":
                for line in cluster_status:
                    if re.match(node_address, line):
                        print("Node already joined cluster.")
                        sqs.delete_message(QueueUrl=queue_url, ReceiptHandle=r_handle)
                        return
                print("Adding node to cluster.")
            elif node_action == "scale-in":
                for line in cluster_status:
                    if re.match(node_address, line):
                        print("Removing node from cluster.")
                        sqs.delete_message(QueueUrl=queue_url, ReceiptHandle=r_handle)
                        return
                print("Node already left cluster.")
            sqs.delete_message(QueueUrl=queue_url, ReceiptHandle=r_handle)


while True:
    check_queue()
    time.sleep(10)
