import boto3


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


def _terminate_nodes(session: boto3.Session, node_type: str):
    asg_client = session.client("autoscaling")
    asg_name = node_type
    asg_client.update_auto_scaling_group(
        AutoScalingGroupName=asg_name,
        MinSize=0,
        MaxSize=0,
        DesiredCapacity=0,
    )


def _terminate_monitor_nodes(session: boto3.Session):
    _terminate_nodes(session, "Monitor")


def _terminate_pd_nodes(session: boto3.Session):
    _terminate_nodes(session, "PD")


def _terminate_kv_nodes(session: boto3.Session):
    _terminate_nodes(session, "TiKV")


def _terminate_db_nodes(session: boto3.Session):
    _terminate_nodes(session, "TiDB")


if __name__ == "__main__":
    session = _get_boto_session(None)
    _terminate_db_nodes(session)
    _terminate_kv_nodes(session)
    _terminate_pd_nodes(session)
    _terminate_monitor_nodes(session)
