#!/bin/bash

REGION_CODE=us-west-2
TRAINER=${1}
STUDENTS_COUNT=1

for IDX in $(seq 1 ${STUDENTS_COUNT});
do
    HOST_MONITOR_PUBLIC_IP=`aws ec2 describe-instances \
      --filter "Name=instance-state-name,Values=running" "Name=tag:student,Values=user${IDX}" "Name=tag:role,Values=monitor1" "Name=tag:trainer,Values=${TRAINER}" \
      --query "Reservations[0].Instances[0].PublicIpAddress" \
      --output text \
      --region ${REGION_CODE}`
    
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ec2-user@${HOST_MONITOR_PUBLIC_IP} ./00-prepare-node-roles-for-user.sh user${IDX} ${TRAINER}
    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ec2-user@${HOST_MONITOR_PUBLIC_IP} cat ./hosts-env.sh

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

VPC_ID=`aws ec2 describe-vpcs --filters "Name=tag:Name,Values=demo-vpc" --query "Vpcs[0].VpcId" --output text --region us-west-2`

DEMO_TG_ARN=`aws elbv2 describe-target-groups \
  --names demo-target-group \
  --query "TargetGroups[0].TargetGroupArn" \
  --output text \
  --region us-west-2`

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

aws elbv2 register-targets \
  --target-group-arn ${DEMO_TG_ARN} \
  --targets "Id=${HOST_DB1_PRIVATE_IP},Port=4000" "Id=${HOST_DB2_PRIVATE_IP},Port=4000" \
  --region us-west-2

echo TiDB instances registered to NLB target group ${DEMO_TG_ARN}

./check_nodes.sh
