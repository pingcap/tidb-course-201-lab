import boto3, sys
from botocore.exceptions import ClientError


def _get_boto_session(profile_name: str) -> boto3.Session:
    """
    Get the boto3 session. Works with profile configured in runtime.

    :param profile_name: The configured AWS profile name. Pass in None to use default credentials chain.
    :returns: The Boto session.
    """
    if profile_name == None:
        session = boto3.Session(region_name="ap-southeast-1")
        return session
    else:
        session = boto3.Session(profile_name=profile_name)
        return session


def _delete_objects_belongs_to_trainer(
    session: boto3.Session, bucket_name: str, trainer_name: str
):
    s3_client = session.client("s3")
    list_response = s3_client.list_objects(
        Bucket=bucket_name,
        Prefix=trainer_name,
        MaxKeys=1000,
    )
    if "Contents" in list_response:
        for object in list_response["Contents"]:
            key = object["Key"]
            print("Deleting", key)
            s3_client.delete_object(
                Bucket=bucket_name,
                Key=key,
            )


if __name__ == "__main__":
    bucket_name = sys.argv[1]
    trainer_name = sys.argv[2]
    session = _get_boto_session(None)
    _delete_objects_belongs_to_trainer(session, bucket_name, trainer_name)
