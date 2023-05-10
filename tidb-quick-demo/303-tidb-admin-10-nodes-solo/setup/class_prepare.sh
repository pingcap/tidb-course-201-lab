#!/bin/bash

REGION_CODE=us-west-2
TRAINER=${1}
STUDENTS_COUNT=1

for IDX in $(seq 1 ${STUDENTS_COUNT});
do
    HOST_MONITOR1_PUBLIC_IP=`aws ec2 describe-instances \
      --filter "Name=instance-state-name,Values=running" "Name=tag:student,Values=user${IDX}" "Name=tag:role,Values=monitor1" "Name=tag:trainer,Values=${TRAINER}" \
      --query "Reservations[0].Instances[0].PublicIpAddress" \
      --output text \
      --region ${REGION_CODE}`
    
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ec2-user@${HOST_MONITOR1_PUBLIC_IP} ./00-prepare-node-roles-for-user.sh user${IDX} ${TRAINER}
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ec2-user@${HOST_MONITOR1_PUBLIC_IP} cat ./hosts-env.sh

    for PD_IDX in $(seq 1 2);
    do
      HOST_PD_PUBLIC_IP=`aws ec2 describe-instances \
        --filter "Name=instance-state-name,Values=running" "Name=tag:student,Values=user${IDX}" "Name=tag:role,Values=pd${PD_IDX}" "Name=tag:trainer,Values=${TRAINER}" \
        --query "Reservations[0].Instances[0].PublicIpAddress" \
        --output text \
        --region ${REGION_CODE}`

      ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ec2-user@${HOST_PD_PUBLIC_IP} sudo mv -f ~ec2-user/stage/tidb-course-201-lab/setup/tidb-lab-mysql-init-amz2/my-server${PD_IDX}.cnf /etc/my.cnf
      ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ec2-user@${HOST_PD_PUBLIC_IP} sudo chown root:root /etc/my.cnf
      echo "/etc/my.conf prepared on pd${PD_IDX}"
    done;
done; 

./check_nodes.sh
