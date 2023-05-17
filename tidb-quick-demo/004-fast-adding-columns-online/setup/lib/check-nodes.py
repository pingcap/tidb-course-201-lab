import boto3, sys, datetime


def _get_boto_session(profile_name: str) -> boto3.Session:
    """
    Get the boto3 session. Works with profile configured in runtime.

    :param profile_name: The configured AWS profile name. Pass in None to use default credentials chain.
    :returns: The Boto session.
    """
    if profile_name == None:
        session = boto3.Session(region_name="us-west-2")
        return session
    else:
        session = boto3.Session(profile_name=profile_name)
        return session


def _check(
    session: boto3.Session,
    trainer_name: str,
):
    c5_xlarge_instance_minute_price = 0.0028333333333333335
    ebs_gp2_100gb_minute_price = 0.00023148148148148146
    c5_xlarge_minute_price = (
        c5_xlarge_instance_minute_price + ebs_gp2_100gb_minute_price
    )
    ec2_client = session.client("ec2")
    response = None
    if trainer_name == "all":
        response = ec2_client.describe_instances(
            Filters=[
                {
                    "Name": "instance-state-name",
                    "Values": [
                        "running",
                    ],
                },
            ],
            DryRun=False,
            MaxResults=200,
        )
    else:
        response = ec2_client.describe_instances(
            Filters=[
                {
                    "Name": "instance-state-name",
                    "Values": [
                        "running",
                    ],
                },
                {
                    "Name": "tag:trainer",
                    "Values": [
                        trainer_name,
                    ],
                },
            ],
            DryRun=False,
            MaxResults=200,
        )
    sum_cost = 0.0
    instances_dict = {}
    for reservation in response["Reservations"]:
        for instances in reservation["Instances"]:
            up_time = round(
                (
                    datetime.datetime.now(datetime.timezone.utc)
                    - instances["UsageOperationUpdateTime"]
                ).seconds
                / 60
            )
            name = None
            trainer = None
            student = None
            node_role = None
            for tag in instances["Tags"]:
                if tag["Key"] == "Name":
                    name = tag["Value"]
                if tag["Key"] == "trainer":
                    trainer = tag["Value"]
                if tag["Key"] == "student":
                    student = tag["Value"]
                if tag["Key"] == "role":
                    node_role = tag["Value"]
            if (
                name == None or trainer == None or student == None or node_role == None
            ) and (name != "pe-service-01"):
                print(
                    "\n* Note: Setup in progress for",
                    instances["InstanceId"] + ".",
                )
                print(
                    "* Note:",
                    instances["InstanceId"],
                    "might need to be adding two tags with keys: `role` and `student` manually.",
                )
            cost = 0.0
            cost = round(up_time * c5_xlarge_minute_price, 2)
            if name != "pe-service-01":
                sum_cost += cost
                instances_dict.update(
                    {
                        (trainer if trainer != None else " ")
                        + ":"
                        + (student if student != None else " ")
                        + ":"
                        + (node_role if node_role != None else " ")
                        + ":"
                        + instances["InstanceId"]: "| "
                        + instances["InstanceId"].rjust(19, " ")
                        + " | "
                        + instances["PublicIpAddress"].ljust(16, " ")
                        + " | "
                        + instances["PrivateIpAddress"].ljust(16, " ")
                        + " | "
                        + (name.ljust(13, " ") if name != None else " ")
                        + " | "
                        + (trainer.ljust(10, " ") if trainer != None else " ")
                        + " | "
                        + (student.ljust(7, " ") if student != None else " ")
                        + " | "
                        + (node_role.ljust(9, " ") if node_role != None else " ")
                        + " | "
                        + str(up_time).ljust(14, " ")
                        + " | "
                    }
                )
            else:
                cost = str(cost) + " (covered by RI)"

    print("\n# Running Nodes for All Trainers.\n")

    trainer_name_cache = "NONE"
    student_name_cache = "NONE"
    for key in sorted([*instances_dict]):
        trainer_name = key.split(":")[0]
        student_name = key.split(":")[1]
        if trainer_name != trainer_name_cache or student_name != student_name_cache:
            print(
                "\n| Instance ID         | Public IP        | Private IP       | Name          | Instructor | Student | Role      | Up Time (mins) |"
            )
            print(
                "| :------------------ | :--------------- | :----------------| :------------ | :--------- | :------ | :-------- |:-------------- |"
            )
            trainer_name_cache = trainer_name
            student_name_cache = student_name
        print(instances_dict[key])

    print("\n# Class Total Cost: " + str(sum_cost) + " (USD)")
    print(
        "\n# Reporting End - " + str(datetime.datetime.now()),
        "with",
        str(len([*instances_dict])),
        "nodes.",
    )


if __name__ == "__main__":
    trainer_name = sys.argv[1]
    session = _get_boto_session(None)
    _check(session, trainer_name)
