#!/bin/bash

# Example: ./00-prepare-node-roles-for-user.sh <user_name_tag_assigned_by_instructor> <instructor_name_tag>

# Setup ENV
source ~/cloud-env.sh

# Enter the classroom username such as "user2" assigned by the instructor. 
export USER=${1}
# The instructor's name tag shared by your instructor.
export TRAINER=${2}

# Setup PD1, KV1, DB1 and TiFlash1 on single node.
# Node 1
HOST_MONITOR1_PRIVATE_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=tag:student,Values=${USER}" "Name=tag:role,Values=monitor1" "Name=tag:trainer,Values=${TRAINER}" \
--query "Reservations[0].Instances[0].PrivateIpAddress" \
--output text \
--region ${REGION_CODE}`

HOST_MONITOR1_PUBLIC_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=tag:student,Values=${USER}" "Name=tag:role,Values=monitor1" "Name=tag:trainer,Values=${TRAINER}" \
--query "Reservations[0].Instances[0].PublicIpAddress" \
--output text \
--region ${REGION_CODE}`

echo export HOST_MONITOR1_PRIVATE_IP=${HOST_MONITOR1_PRIVATE_IP} > ./hosts-env.sh
echo export HOST_MONITOR1_PUBLIC_IP=${HOST_MONITOR1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_CM_PRIVATE_IP=${HOST_MONITOR1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_CM_PUBLIC_IP=${HOST_MONITOR1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_PD1_PRIVATE_IP=${HOST_MONITOR1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_PD1_PUBLIC_IP=${HOST_MONITOR1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_DB1_PRIVATE_IP=${HOST_MONITOR1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_DB1_PUBLIC_IP=${HOST_MONITOR1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_DB2_PRIVATE_IP=${HOST_MONITOR1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_DB2_PUBLIC_IP=${HOST_MONITOR1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_KV1_PRIVATE_IP=${HOST_MONITOR1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_KV1_PUBLIC_IP=${HOST_MONITOR1_PUBLIC_IP} >> ./hosts-env.sh
echo export HOST_TIFLASH1_PRIVATE_IP=${HOST_MONITOR1_PRIVATE_IP} >> ./hosts-env.sh
echo export HOST_TIFLASH1_PUBLIC_IP=${HOST_MONITOR1_PUBLIC_IP} >> ./hosts-env.sh

source ./hosts-env.sh

echo ssh -A ${HOST_CM_PRIVATE_IP} > ./ssh-to-cm.sh
echo ssh -A ${HOST_PD1_PRIVATE_IP} > ./ssh-to-pd1.sh
echo ssh -A ${HOST_DB1_PRIVATE_IP} > ./ssh-to-db1.sh
echo ssh -A ${HOST_DB2_PRIVATE_IP} > ./ssh-to-db2.sh
echo ssh -A ${HOST_MONITOR1_PRIVATE_IP} > ./ssh-to-monitor1.sh
echo ssh -A ${HOST_KV1_PRIVATE_IP} > ./ssh-to-kv1.sh
echo ssh -A ${HOST_TIFLASH1_PRIVATE_IP} > ./ssh-to-tiflash1.sh
chmod +x ./*.sh

# Setup Single Node TiDB Cluster Topology
cp ./template-single-node-hybrid.yaml ./solution-topology-single-node.yaml
sed -i '' \
  -e "s/<HOST_PD1_PRIVATE_IP>/${HOST_PD1_PRIVATE_IP}/g" \
  -e "s/<HOST_TIFLASH1_PRIVATE_IP>/${HOST_TIFLASH1_PRIVATE_IP}/g" \
  -e "s/<HOST_KV1_PRIVATE_IP>/${HOST_KV1_PRIVATE_IP}/g" \
  -e "s/<HOST_DB1_PRIVATE_IP>/${HOST_DB1_PRIVATE_IP}/g" \
  -e "s/<HOST_DB2_PRIVATE_IP>/${HOST_DB2_PRIVATE_IP}/g" \
  -e "s/<HOST_MONITOR1_PRIVATE_IP>/${HOST_MONITOR1_PRIVATE_IP}/g" \
  ./solution-topology-single-node.yaml 2>/dev/null

# Copy hosts-env.sh to user home. It's also a safe operation if the PWD is user home. 
cp ./hosts-env.sh ~/hosts-env.sh 2>>/dev/null

echo
echo "Current node is prepared for user ${USER} and trainer ${TRAINER}."
