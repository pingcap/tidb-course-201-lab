#!/bin/bash

# Install
mkdir ~ec2-user/stage/
cd ~ec2-user/stage/
yum -y update
yum -y install git numactl ntp awscli
rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
wget https://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm
yum -y install mysql57-community-release-el7-10.noarch.rpm
yum -y install mysql-community-server
wget https://pingcap-edu.s3.us-west-2.amazonaws.com/tidb-admin-dataset.zip
git clone https://github.com/pingcap/tidb-course-201-lab.git
# Setup Region
REGION_CODE=`curl http://169.254.169.254/latest/meta-data/placement/region`
echo export REGION_CODE=${REGION_CODE} > ~ec2-user/cloud-env.sh

# Setup PE Service Host Info
HOST_PD1_PRIVATE_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=tag:Name,Values=pe-service-01" \
--query "Reservations[0].Instances[0].PrivateIpAddress" \
--output text \
--region ${REGION_CODE}`
HOST_PD1_PUBLIC_IP=`aws ec2 describe-instances \
--filter "Name=instance-state-name,Values=running" "Name=tag:Name,Values=pe-service-01" \
--query "Reservations[0].Instances[0].PublicIpAddress" \
--output text \
--region ${REGION_CODE}`

echo export HOST_PD1_PRIVATE_IP=${HOST_PD1_PRIVATE_IP} > ~ec2-user/host-pd1-env.sh
echo export HOST_PD1_PUBLIC_IP=${HOST_PD1_PUBLIC_IP} >> ~ec2-user/host-pd1-env.sh
echo ssh -A ${HOST_PD1_PRIVATE_IP} > ~ec2-user/ssh-to-pd1.sh

# Setup TiDB hybrid.yaml
cd ~ec2-user
cp ./stage/tidb-course-201-lab/setup/tidb-lab-aws-single-node-amz2/template-single-node-hybrid.yaml ./single-node-hybrid.yaml
sed -i '' -e "s/<HOST_PD1_PRIVATE_IP>/${HOST_PD1_PRIVATE_IP}/g" ./single-node-hybrid.yaml 2>/dev/null
echo Topology config file for single node cluster prepared.

# Conslusion
cd -
chown -R ec2-user:ec2-user ~ec2-user/stage/
chmod +x ~ec2-user/*.sh
chmod +x ~ec2-user/stage/tidb-course-201-lab/setup/tidb-lab-aws-single-node-amz2/*.sh
