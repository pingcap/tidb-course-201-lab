import boto3, subprocess, re, time


region = "us-west-2"


def check_queue():
    cluster_status = subprocess.check_output(
        ["/home/ec2-user/.tiup/bin/tiup", "cluster", "display", "tidb-demo"]
    ).decode("utf-8")
    print(cluster_status)
    for line in cluster_status:
        print("X", line)


check_queue()
