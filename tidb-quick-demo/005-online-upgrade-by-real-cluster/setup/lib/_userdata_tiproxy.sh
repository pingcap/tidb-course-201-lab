#!/bin/bash
cd ~ec2-user
yum -y update
yum -y install git numactl awscli
git clone https://github.com/pingcap/TiProxy.git
git clone https://github.com/pingcap/tidb-course-201-lab.git
REGION_CODE=`curl http://169.254.169.254/latest/meta-data/placement/region`
echo export REGION_CODE=${REGION_CODE} > ~ec2-user/cloud-env.sh
alias cp='cp'
cp -R tidb-course-201-lab/setup/tidb-quick-demo-aws-9-nodes-amz2/* ~ec2-user/
cp -R tidb-course-201-lab/scripts/ ~ec2-user/
chown -R ec2-user:ec2-user ~ec2-user/*
cd ~
wget https://pingcap-edu.s3.us-west-2.amazonaws.com/go1.20.4.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~ec2-user/.bashrc
su - ec2-user -c "pip3 install boto3"
su - ec2-user -c "cd TiProxy/; make;"