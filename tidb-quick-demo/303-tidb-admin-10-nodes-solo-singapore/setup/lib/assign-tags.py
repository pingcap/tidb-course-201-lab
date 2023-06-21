import boto3, sys


def _get_boto_session(profile_name: str) -> boto3.Session:
    """
    Get the boto3 session. Works with profile configured in runtime.

    :param profile_name: The configured AWS profile name.
    :returns: The Boto session.
    """
    if profile_name == None:
        session = boto3.Session(region_name="ap-southeast-1")
        return session
    else:
        session = boto3.Session(profile_name=profile_name)
        return session


def _get_node_instance_ids(
    session: boto3.Session,
    trainer_name: str,
    node_role: str,
    node_count: int,
) -> list:
    ec2_client = session.client("ec2")
    response = ec2_client.describe_instances(
        Filters=[
            {
                "Name": "tag:Name",
                "Values": [
                    node_role,
                ],
            },
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
    node_instance_ids = []
    for reservation in response["Reservations"]:
        for i in reservation["Instances"]:
            if i["Tags"] is not None and "student" not in [t["Key"] for t in i["Tags"]]:
                node_instance_ids += [i["InstanceId"]]
    if node_count > len(node_instance_ids):
        print(
            "Insufficient nodes count for node type",
            node_role + ". Needs",
            str(node_count) + ", but only",
            str(len(node_instance_ids)),
            "available.",
        )
        print("Normally, you should wait for a few minutes, and try again.")
        exit(1)
    return node_instance_ids


def _assign_nodes_to_student(
    session: boto3.Session,
    instance_ids: list,
    node_role: str,
    nodes_per_student: int,
    student_name: str,
):
    """
    Nodes are tagged with `Name:{node_role}` by ASG and Launch Template.
    This routine will find all {node_role} nodes and then add new tag `role` to
        `role:{node_role}1`,
        `role:{node_role}2`,
        `role:{node_role}3` respectively based on student count.
    And, it depends on `nodes_per_student`.
    """
    ec2_client = session.client("ec2")
    student_node_idx = 1
    for node_instance_id in instance_ids:
        print("Tagging " + node_instance_id + " with student" + ":" + student_name)
        ec2_client.create_tags(
            DryRun=False,
            Resources=[
                node_instance_id,
            ],
            Tags=[
                {
                    "Key": "role",
                    "Value": node_role + str(student_node_idx),
                },
                {
                    "Key": "student",
                    "Value": student_name,
                },
            ],
        )
        if student_node_idx == nodes_per_student:
            break
        student_node_idx += 1

    print("Tagging " + node_role + " nodes completed.")


def _get_pd_instance_ids(
    session: boto3.Session,
    trainer_name: str,
) -> list:
    return _get_node_instance_ids(session, trainer_name, "pd", 3)


def _get_kv_instance_ids(
    session: boto3.Session,
    trainer_name: str,
) -> list:
    return _get_node_instance_ids(session, trainer_name, "kv", 3)


def _get_db_instance_ids(
    session: boto3.Session,
    trainer_name: str,
) -> list:
    return _get_node_instance_ids(session, trainer_name, "db", 1)


def _get_tiflash_instance_ids(
    session: boto3.Session,
    trainer_name: str,
) -> list:
    return _get_node_instance_ids(session, trainer_name, "tiflash", 1)


def _get_monitor_instance_ids(
    session: boto3.Session,
    trainer_name: str,
) -> list:
    return _get_node_instance_ids(session, trainer_name, "monitor", 3)


def _assign_pd_to_student(
    session: boto3.Session,
    instance_ids: list,
    student_name: str,
):
    _assign_nodes_to_student(session, instance_ids, "pd", 3, student_name)


def _assign_kv_to_student(
    session: boto3.Session,
    instance_ids: list,
    student_name: str,
):
    _assign_nodes_to_student(session, instance_ids, "kv", 3, student_name)


def _assign_db_to_student(
    session: boto3.Session,
    instance_ids: list,
    student_name: str,
):
    _assign_nodes_to_student(session, instance_ids, "db", 1, student_name)


def _assign_tiflash_to_student(
    session: boto3.Session,
    instance_ids: list,
    student_name: str,
):
    _assign_nodes_to_student(session, instance_ids, "tiflash", 1, student_name)


def _assign_monitor_to_student(
    session: boto3.Session,
    instance_ids: list,
    student_name: str,
):
    _assign_nodes_to_student(session, instance_ids, "monitor", 1, student_name)


if __name__ == "__main__":
    """
    Parameter 1: Student name tag.
    Parameter 2: Trainer name tag.
    """
    student_name = sys.argv[1]
    trainer_name = sys.argv[2]
    session = _get_boto_session(None)

    pd_instance_ids = _get_pd_instance_ids(session, trainer_name)
    kv_instance_ids = _get_kv_instance_ids(session, trainer_name)
    db_instance_ids = _get_db_instance_ids(session, trainer_name)
    tiflash_instance_ids = _get_tiflash_instance_ids(session, trainer_name)
    monitor_instance_ids = _get_monitor_instance_ids(session, trainer_name)

    _assign_pd_to_student(session, pd_instance_ids, student_name)
    _assign_kv_to_student(session, kv_instance_ids, student_name)
    _assign_db_to_student(session, db_instance_ids, student_name)
    _assign_tiflash_to_student(session, tiflash_instance_ids, student_name)
    _assign_monitor_to_student(session, monitor_instance_ids, student_name)
