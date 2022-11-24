#!/bin/bash

# Setup ENV
source ~/cloud-env.sh

# Enter the classroom username such as "user01" assigned by the instructor. 
export USER=${1}

# Setup PD1 as all node roles (1 ASG for PD)
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

echo export HOST_PD1_PRIVATE_IP=${HOST_PD1_PRIVATE_IP} > ./hosts-env.sh
echo export HOST_PD1_PUBLIC_IP=${HOST_PD1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_DB1_PRIVATE_IP=${HOST_PD1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_DB1_PUBLIC_IP=${HOST_PD1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_DB2_PRIVATE_IP=${HOST_PD1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_DB2_PUBLIC_IP=${HOST_PD1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_KV1_PRIVATE_IP=${HOST_PD1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_KV1_PUBLIC_IP=${HOST_PD1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_TIFLASH1_PRIVATE_IP=${HOST_PD1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_TIFLASH1_PUBLIC_IP=${HOST_PD1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_MONITOR_PRIVATE_IP=${HOST_PD1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_MONITOR_PUBLIC_IP=${HOST_PD1_PUBLIC_IP} >> ./hosts-env.sh
echo export DASHBOARD_URL=http://${HOST_PD1_PUBLIC_IP}:2379/dashboard >> ./hosts-env.sh
echo export GRAFANA_URL=http://${HOST_PD1_PUBLIC_IP}:3000/ >> ./hosts-env.sh

source ./hosts-env.sh

echo ssh -A ${HOST_PD1_PRIVATE_IP} > ./ssh-to-pd1.sh
echo ssh -A ${HOST_DB1_PRIVATE_IP} > ./ssh-to-db1.sh
echo ssh -A ${HOST_DB2_PRIVATE_IP} > ./ssh-to-db2.sh
echo ssh -A ${HOST_KV1_PRIVATE_IP} > ./ssh-to-kv1.sh
echo ssh -A ${HOST_TIFLASH1_PRIVATE_IP} > ./ssh-to-tiflash1.sh
echo ssh -A ${HOST_MONITOR_PRIVATE_IP} > ./ssh-to-monitor.sh
chmod +x ./*.sh

# Setup Single Node TiDB Topology
cp ./template-single-node-hybrid.yaml ./single-node-hybrid.yaml
sed -i '' -e "s/<HOST_PD1_PRIVATE_IP>/${HOST_PD1_PRIVATE_IP}/g" ./single-node-hybrid.yaml 2>/dev/null

echo Topology config file for single node cluster prepared.
