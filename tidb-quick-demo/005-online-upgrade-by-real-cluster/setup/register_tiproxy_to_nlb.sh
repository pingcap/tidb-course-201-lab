#!/bin/bash

TRAINER=${1}
REGION_CODE=${2}

# Register 2 TiProxy nodes to NLB
VPC_ID=`aws ec2 describe-vpcs --filters "Name=tag:Name,Values=${TRAINER}" --query "Vpcs[0].VpcId" --output text --region ${REGION_CODE}`

DEMO_TG_ARN=`aws elbv2 describe-target-groups \
  --names demo-target-group \
  --query "TargetGroups[0].TargetGroupArn" \
  --output text \
  --region ${REGION_CODE}`

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

aws elbv2 register-targets \
  --target-group-arn ${DEMO_TG_ARN} \
  --targets "Id=${HOST_TIPROXY1_PRIVATE_IP},Port=6000" "Id=${HOST_TIPROXY2_PRIVATE_IP},Port=6000"\
  --region ${REGION_CODE}

echo TiProxy instances registered to NLB target group ${DEMO_TG_ARN}
