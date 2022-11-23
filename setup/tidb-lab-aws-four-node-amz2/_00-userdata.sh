#!/bin/bash

# Run this script as root user.

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

# Conslusion
cd -
chown -R ec2-user:ec2-user ~ec2-user/stage/
chmod +x ~ec2-user/*.sh
chmod +x ~ec2-user/stage/tidb-course-201-lab/setup/tidb-lab-aws-single-node-amz2/*.sh
