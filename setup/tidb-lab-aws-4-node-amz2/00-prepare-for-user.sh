#!/bin/bash

# Setup ENV
source ~/cloud-env.sh

# Enter the classroom username such as "user01" assigned by the instructor. 
export USER=${1}

# Setup PD1,2,3 as all node roles
# Node 1
HOST_PD1_PRIVATE_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=tag:class-${USER},Values=pd1" \
--query "Reservations[0].Instances[0].PrivateIpAddress" \
--output text \
--region ${REGION_CODE}`

HOST_PD1_PUBLIC_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=tag:class-${USER},Values=pd1" \
--query "Reservations[0].Instances[0].PublicIpAddress" \
--output text \
--region ${REGION_CODE}`

# Node 2
HOST_PD2_PRIVATE_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=tag:class-${USER},Values=pd2" \
--query "Reservations[0].Instances[0].PrivateIpAddress" \
--output text \
--region ${REGION_CODE}`

HOST_PD2_PUBLIC_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=tag:class-${USER},Values=pd2" \
--query "Reservations[0].Instances[0].PublicIpAddress" \
--output text \
--region ${REGION_CODE}`

# Node 3
HOST_PD3_PRIVATE_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=tag:class-${USER},Values=pd3" \
--query "Reservations[0].Instances[0].PrivateIpAddress" \
--output text \
--region ${REGION_CODE}`

HOST_PD3_PUBLIC_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=tag:class-${USER},Values=pd3" \
--query "Reservations[0].Instances[0].PublicIpAddress" \
--output text \
--region ${REGION_CODE}`

# Node 4
HOST_TIFLASH1_PRIVATE_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=tag:class-${USER},Values=tiflash1" \
--query "Reservations[0].Instances[0].PrivateIpAddress" \
--output text \
--region ${REGION_CODE}`

HOST_TIFLASH1_PUBLIC_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=tag:class-${USER},Values=tiflash1" \
--query "Reservations[0].Instances[0].PublicIpAddress" \
--output text \
--region ${REGION_CODE}`

echo export HOST_PD1_PRIVATE_IP=${HOST_PD1_PRIVATE_IP} > ./hosts-env.sh
echo export HOST_PD1_PUBLIC_IP=${HOST_PD1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_PD2_PRIVATE_IP=${HOST_PD2_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_PD2_PUBLIC_IP=${HOST_PD2_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_PD3_PRIVATE_IP=${HOST_PD3_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_PD3_PUBLIC_IP=${HOST_PD3_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_DB1_PRIVATE_IP=${HOST_PD1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_DB1_PUBLIC_IP=${HOST_PD1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_DB2_PRIVATE_IP=${HOST_PD2_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_DB2_PUBLIC_IP=${HOST_PD2_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_KV1_PRIVATE_IP=${HOST_PD1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_KV1_PUBLIC_IP=${HOST_PD1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_KV2_PRIVATE_IP=${HOST_PD2_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_KV2_PUBLIC_IP=${HOST_PD2_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_KV3_PRIVATE_IP=${HOST_PD3_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_KV3_PUBLIC_IP=${HOST_PD3_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_TIFLASH1_PRIVATE_IP=${HOST_TIFLASH1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_TIFLASH1_PUBLIC_IP=${HOST_TIFLASH1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_MONITOR_PRIVATE_IP=${HOST_PD3_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_MONITOR_PUBLIC_IP=${HOST_PD3_PUBLIC_IP} >> ./hosts-env.sh
echo ssh -A ${HOST_PD1_PRIVATE_IP} > ./ssh-to-pd1.sh
echo ssh -A ${HOST_PD2_PRIVATE_IP} > ./ssh-to-pd2.sh
echo ssh -A ${HOST_PD3_PRIVATE_IP} > ./ssh-to-pd3.sh
echo ssh -A ${HOST_DB1_PRIVATE_IP} > ./ssh-to-db1.sh
echo ssh -A ${HOST_DB2_PRIVATE_IP} > ./ssh-to-db2.sh
echo ssh -A ${HOST_MONITOR_PRIVATE_IP} > ./ssh-to-monitor.sh
echo ssh -A ${HOST_KV1_PRIVATE_IP} > ./ssh-to-kv1.sh
echo ssh -A ${HOST_KV2_PRIVATE_IP} > ./ssh-to-kv2.sh
echo ssh -A ${HOST_KV3_PRIVATE_IP} > ./ssh-to-kv3.sh
echo ssh -A ${HOST_TIFLASH1_PRIVATE_IP} > ./ssh-to-tiflash1.sh

# Setup Four Nodes TiDB Topology
cp ./template-four-nodes-hybrid.yaml ./four-nodes-hybrid.yaml
sed -i '' \
  -e "s/<HOST_PD1_PRIVATE_IP>/${HOST_PD1_PRIVATE_IP}/g" \
  -e "s/<HOST_PD2_PRIVATE_IP>/${HOST_PD2_PRIVATE_IP}/g" \
  -e "s/<HOST_PD3_PRIVATE_IP>/${HOST_PD3_PRIVATE_IP}/g" \
  -e "s/<HOST_TIFLASH1_PRIVATE_IP>/${HOST_TIFLASH1_PRIVATE_IP}/g" \
  ./four-nodes-hybrid.yaml 2>/dev/null

echo Topology config file for four nodes cluster prepared.
