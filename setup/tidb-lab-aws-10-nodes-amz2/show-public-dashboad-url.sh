#!/bin/bash
source ~/cloud-env.sh

UI_PRIVATE_IP=`~/.tiup/bin/tiup cluster display tidb-test | grep UI | grep pd | awk -F" " '{print $3}' | xargs`

UI_PUBLIC_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=network-interface.addresses.private-ip-address,Values=${UI_PRIVATE_IP}" \
--query "Reservations[0].Instances[0].PublicIpAddress" \
--output text \
--region ${REGION_CODE}`

echo http://${UI_PUBLIC_IP}:2379/dashboard
