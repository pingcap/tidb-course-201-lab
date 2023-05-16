import boto3, sys


def _get_boto_session(profile_name: str) -> boto3.Session:
    """
    Get the boto3 session. Works with profile configured in runtime.

    :param profile_name: The configured AWS profile name.
    :returns: The Boto session.
    """
    if profile_name == None:
        session = boto3.Session(region_name="us-west-2")
        return session
    else:
        session = boto3.Session(profile_name=profile_name)
        return session


def _get_node_instance_ids(
    session: boto3.Session,
    trainer_name: str,
    student_count: int,
    node_role: str,
    nodes_per_student: int,
) -> list:
    node_count_target = nodes_per_student * student_count
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
    node_count_actual = 0
    for reservation in response["Reservations"]:
        node_count_actual += len(reservation["Instances"])
    print(
        str(student_count)
        + " students with "
        + str(node_count_actual)
        + " "
        + node_role
        + " node(s)."
    )
    if node_count_actual != node_count_target:
        print(
            "ERROR: Total available "
            + node_role
            + " nodes count is "
            + str(node_count_actual)
            + " instead of "
            + str(node_count_target)
            + "."
        )
        print("SOLUTION: Please wait and retry later or contact PE team.")
        exit(1)
    node_instance_ids = []
    for reservation in response["Reservations"]:
        for i in reservation["Instances"]:
            node_instance_ids += [i["InstanceId"]]
    return node_instance_ids


def _assign_nodes_to_students(
    session: boto3.Session,
    instance_ids: list,
    node_role: str,
    nodes_per_student: int,
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
    student_idx = 1
    student_node_idx = 1
    for node_instance_id in instance_ids:
        print(
            "Tagging "
            + node_instance_id
            + " with class-user"
            + str(student_idx)
            + ":"
            + node_role
            + str(student_node_idx)
        )
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
                    "Value": "user" + str(student_idx),
                },
            ],
        )
        student_node_idx += 1
        if student_node_idx > nodes_per_student:
            student_node_idx = 1
            student_idx += 1
    print("Tagging " + node_role + " nodes completed.")


def _get_monitor_instance_ids(
    session: boto3.Session, trainer_name: str, student_count: int
) -> list:
    return _get_node_instance_ids(session, trainer_name, student_count, "monitor", 1)


def _get_pd_instance_ids(
    session: boto3.Session, trainer_name: str, student_count: int
) -> list:
    return _get_node_instance_ids(session, trainer_name, student_count, "pd", 3)


def _get_kv_instance_ids(
    session: boto3.Session, trainer_name: str, student_count: int
) -> list:
    return _get_node_instance_ids(session, trainer_name, student_count, "kv", 3)


def _get_db_instance_ids(
    session: boto3.Session, trainer_name: str, student_count: int
) -> list:
    return _get_node_instance_ids(session, trainer_name, student_count, "db", 2)


def _get_tiproxy_instance_ids(
    session: boto3.Session, trainer_name: str, student_count: int
) -> list:
    return _get_node_instance_ids(session, trainer_name, student_count, "tiproxy", 2)


def _assign_pd_to_students(session: boto3.Session, instance_ids: list):
    _assign_nodes_to_students(session, instance_ids, "pd", 3)


def _assign_kv_to_students(session: boto3.Session, instance_ids: list):
    _assign_nodes_to_students(session, instance_ids, "kv", 3)


def _assign_db_to_students(session: boto3.Session, instance_ids: list):
    _assign_nodes_to_students(session, instance_ids, "db", 2)


def _assign_monitor_to_students(session: boto3.Session, instance_ids: list):
    _assign_nodes_to_students(session, instance_ids, "monitor", 1)


def _assign_tiproxy_to_students(session: boto3.Session, instance_ids: list):
    _assign_nodes_to_students(session, instance_ids, "tiproxy", 2)


if __name__ == "__main__":
    student_count = 1
    trainer_name = sys.argv[1]
    session = _get_boto_session(None)
    monitor_instance_ids = _get_monitor_instance_ids(
        session, trainer_name, int(student_count)
    )
    pd_instance_ids = _get_pd_instance_ids(session, trainer_name, int(student_count))
    kv_instance_ids = _get_kv_instance_ids(session, trainer_name, int(student_count))
    db_instance_ids = _get_db_instance_ids(session, trainer_name, int(student_count))
    tiproxy_instance_ids = _get_tiproxy_instance_ids(
        session, trainer_name, int(student_count)
    )

    _assign_monitor_to_students(session, monitor_instance_ids)
    _assign_pd_to_students(session, pd_instance_ids)
    _assign_kv_to_students(session, kv_instance_ids)
    _assign_db_to_students(session, db_instance_ids)
    _assign_tiproxy_to_students(session, tiproxy_instance_ids)
