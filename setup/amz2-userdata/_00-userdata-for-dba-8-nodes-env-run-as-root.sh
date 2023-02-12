#!/bin/bash

# This script is for Amazon Linux 2.
# Run this script as root user on an EC2 instance, or configure it as the USER_DATA to initialize an EC2 instance.  

# Setup ENV
echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment

# Install
mkdir ~ec2-user/stage/
cd ~ec2-user/stage/
rm -rf tidb-course-201-lab/
yum -y update
yum -y install git numactl awscli postfix
#rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
wget https://pingcap-edu.s3.us-west-2.amazonaws.com/mysql-5.7.41-1.el7.x86_64.rpm-bundle.tar
tar xvf mysql-5.7.41-1.el7.x86_64.rpm-bundle.tar
rpm -ivh mysql-community-server-5.7.41-1.el7.x86_64.rpm mysql-community-client-5.7.41-1.el7.x86_64.rpm
#wget https://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm
#yum -y install mysql57-community-release-el7-10.noarch.rpm
#yum -y install mysql-community-client
wget https://pingcap-edu.s3.us-west-2.amazonaws.com/tidb-admin-dataset.zip
git clone https://github.com/pingcap/tidb-course-201-lab.git

# Service
# systemctl restart ntpd.service

# Setup Cloud ENV
REGION_CODE=`curl http://169.254.169.254/latest/meta-data/placement/region`
echo export REGION_CODE=${REGION_CODE} > ~ec2-user/cloud-env.sh

# Copy required files
alias cp='cp'
cp -R tidb-course-201-lab/setup/tidb-lab-aws-8-nodes-amz2/* ~ec2-user/

# Conslusion
cd ~
chown -R ec2-user:ec2-user ~ec2-user/*
chmod +x ~ec2-user/*.sh
