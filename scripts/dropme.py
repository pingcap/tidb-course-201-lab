import boto3, subprocess, re, time


region = "us-west-2"


def check_queue():
    cluster_status = subprocess.check_output(
        ["/home/ec2-user/.tiup/bin/tiup", "cluster", "display", "tidb-demo"]
    ).decode("utf-8")
    print(cluster_status)
    for line in cluster_status.split("\n"):
        print("X", line)
        if re.match("10.90.1.144", line):
            print("YYYYYYYY")
            return


check_queue()
