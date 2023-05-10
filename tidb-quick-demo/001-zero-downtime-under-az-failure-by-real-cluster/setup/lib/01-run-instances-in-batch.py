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


def _run_nodes(
    session: boto3.Session,
    trainer_name: str,
    student_count: int,
    node_type: str,
    min_nodes_per_student: int,
    max_nodes_per_student: int,
    desired_nodes_per_student: int,
):
    min_nodes_count_target = min_nodes_per_student * student_count
    max_nodes_count_target = max_nodes_per_student * student_count
    desired_nodes_count_target = desired_nodes_per_student * student_count
    asg_client = session.client("autoscaling")
    asg_name = node_type
    asg_client.update_auto_scaling_group(
        AutoScalingGroupName=asg_name,
        MinSize=min_nodes_count_target,
        MaxSize=max_nodes_count_target,
        DesiredCapacity=desired_nodes_count_target,
    )


def _run_monitor_nodes(session: boto3.Session, trainer_name: str, student_count: int):
    _run_nodes(session, trainer_name, student_count, "Monitor", 1, 1, 1)


def _run_pd_nodes(session: boto3.Session, trainer_name: str, student_count: int):
    _run_nodes(session, trainer_name, student_count, "PD", 3, 3, 3)


def _run_kv_nodes(session: boto3.Session, trainer_name: str, student_count: int):
    _run_nodes(session, trainer_name, student_count, "TiKV", 3, 5, 3)


def _run_db_nodes(session: boto3.Session, trainer_name: str, student_count: int):
    _run_nodes(session, trainer_name, student_count, "TiDB", 2, 4, 2)


if __name__ == "__main__":
    student_count = 1
    trainer_name = sys.argv[1]
    session = _get_boto_session(None)
    _run_monitor_nodes(session, trainer_name, student_count)
    _run_pd_nodes(session, trainer_name, student_count)
    _run_kv_nodes(session, trainer_name, student_count)
    _run_db_nodes(session, trainer_name, student_count)
