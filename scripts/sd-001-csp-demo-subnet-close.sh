#!/bin/bash

SUBNET_NAME=$1

VPC_ID=`aws ec2 describe-vpcs --filters "Name=tag:Name,Values=demo-vpc" --query "Vpcs[0].VpcId" --output text --region us-west-2`

SUBNET_ID=`aws ec2 describe-subnets --filters "Name=vpc-id,Values=${VPC_ID}" "Name=tag:Name,Values=${SUBNET_NAME}" --query "Subnets[0].SubnetId" --output text --region us-west-2`

CAGE_NACL_ID=`aws ec2 describe-network-acls --filters "Name=vpc-id,Values=${VPC_ID}" "Name=default,Values=false" "Name=tag:Name,Values=cage" --query "NetworkAcls[0].NetworkAclId" --output text --region us-west-2`

ASSOC_ID=`aws ec2 describe-network-acls --filters "Name=vpc-id,Values=${VPC_ID}" "Name=default,Values=true" --query "NetworkAcls[0].Associations" --output text --region us-west-2 | grep ${SUBNET_ID} | awk -F" " '{print $1}'`

aws ec2 replace-network-acl-association --association-id ${ASSOC_ID} --network-acl-id ${CAGE_NACL_ID} --region us-west-2
