#!/bin/bash

HOST_DB1_PRIVATE_IP=`aws ec2 describe-instances \
  --filter "Name=instance-state-name,Values=running" "Name=tag:student,Values=user1" "Name=tag:role,Values=db1" "Name=tag:trainer,Values=${TRAINER}" \
  --query "Reservations[0].Instances[0].PrivateIpAddress" \
  --output text \
  --region ${REGION_CODE}`

HOST_DB2_PRIVATE_IP=`aws ec2 describe-instances \
  --filter "Name=instance-state-name,Values=running" "Name=tag:student,Values=user1" "Name=tag:role,Values=db2" "Name=tag:trainer,Values=${TRAINER}" \
  --query "Reservations[0].Instances[0].PrivateIpAddress" \
  --output text \
  --region ${REGION_CODE}`

openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout key.pem -out cert.pem -subj "/CN=example.com"

scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no key.pem ec2-user@${HOST_DB1_PRIVATE_IP}:/home/ec2-user/
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cert.pem ec2-user@${HOST_DB1_PRIVATE_IP}:/home/ec2-user/
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no key.pem ec2-user@${HOST_DB2_PRIVATE_IP}:/home/ec2-user/
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cert.pem ec2-user@${HOST_DB2_PRIVATE_IP}:/home/ec2-user/

HOST_TIPROXY1_PRIVATE_IP=`aws ec2 describe-instances \
  --filter "Name=instance-state-name,Values=running" "Name=tag:student,Values=user1" "Name=tag:role,Values=tiproxy1" "Name=tag:trainer,Values=${TRAINER}" \
  --query "Reservations[0].Instances[0].PrivateIpAddress" \
  --output text \
  --region ${REGION_CODE}`

HOST_TIPROXY2_PRIVATE_IP=`aws ec2 describe-instances \
  --filter "Name=instance-state-name,Values=running" "Name=tag:student,Values=user1" "Name=tag:role,Values=tiproxy2" "Name=tag:trainer,Values=${TRAINER}" \
  --query "Reservations[0].Instances[0].PrivateIpAddress" \
  --output text \
  --region ${REGION_CODE}`

scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no tiproxy.toml ec2-user@${HOST_TIPROXY1_PRIVATE_IP}:/home/ec2-user/
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no tiproxy.toml ec2-user@${HOST_TIPROXY2_PRIVATE_IP}:/home/ec2-user/

./start-tiproxy.sh ${HOST_TIPROXY1_PRIVATE_IP} &
./start-tiproxy.sh ${HOST_TIPROXY2_PRIVATE_IP} &

cp .tiup/storage/cluster/clusters/tidb-demo/meta.yaml .tiup/storage/cluster/clusters/tidb-demo/meta.yaml.bak
cp ./meta.yaml .tiup/storage/cluster/clusters/tidb-demo/meta.yaml

tiup cluster reload tidb-demo --yes
