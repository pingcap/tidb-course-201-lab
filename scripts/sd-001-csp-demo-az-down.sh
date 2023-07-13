#!/bin/bash

SUBNET_NAME=$1
TRAINER_NAME=$2
REGION_CODE=$3

VPC_ID=`aws ec2 describe-vpcs --filters "Name=tag:Name,Values=${TRAINER_NAME}" --query "Vpcs[0].VpcId" --output text --region ${REGION_CODE}`

SUBNET_ID=`aws ec2 describe-subnets --filters "Name=vpc-id,Values=${VPC_ID}" "Name=tag:Name,Values=${SUBNET_NAME}" --query "Subnets[0].SubnetId" --output text --region ${REGION_CODE}`

CAGE_NACL_ID=`aws ec2 describe-network-acls --filters "Name=vpc-id,Values=${VPC_ID}" "Name=default,Values=false" "Name=tag:Name,Values=cage" --query "NetworkAcls[0].NetworkAclId" --output text --region ${REGION_CODE}`

ASSOC_ID=`aws ec2 describe-network-acls --filters "Name=vpc-id,Values=${VPC_ID}" "Name=default,Values=true" --query "NetworkAcls[0].Associations" --output text --region ${REGION_CODE} | grep ${SUBNET_ID} | awk -F" " '{print $1}'`

aws ec2 replace-network-acl-association --association-id ${ASSOC_ID} --network-acl-id ${CAGE_NACL_ID} --region ${REGION_CODE}
