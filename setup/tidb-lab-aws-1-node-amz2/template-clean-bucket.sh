BUCKET_NAME=${1}
aws s3 rm --recursive s3://${BUCKET_NAME}/<TRAINER>/<USER>/