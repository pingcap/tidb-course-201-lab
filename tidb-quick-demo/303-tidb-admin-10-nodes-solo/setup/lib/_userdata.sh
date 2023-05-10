#!/bin/bash
echo LANG=en_US.utf-8 >> /etc/environment
echo LC_ALL=en_US.utf-8 >> /etc/environment
mkdir ~ec2-user/stage/
cd ~ec2-user/stage/
rm -rf tidb-course-201-lab/
yum -y update
yum -y install git numactl awscli
rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
#wget https://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm
#yum -y install mysql57-community-release-el7-10.noarch.rpm
#yum -y install mysql-community-client
#wget https://pingcap-edu.s3.us-west-2.amazonaws.com/mysql-community-server-5.7.41-1.el7.x86_64.rpm
wget https://pingcap-edu.s3.us-west-2.amazonaws.com/mysql-5.7.41-1.el7.x86_64.rpm-bundle.tar
tar xvf mysql-5.7.41-1.el7.x86_64.rpm-bundle.tar
rpm -ivh mysql-community-common-5.7.41-1.el7.x86_64.rpm mysql-community-client-5.7.41-1.el7.x86_64.rpm mysql-community-server-5.7.41-1.el7.x86_64.rpm
wget https://pingcap-edu.s3.us-west-2.amazonaws.com/tidb-admin-dataset.zip
git clone https://github.com/pingcap/tidb-course-201-lab.git
REGION_CODE=`curl http://169.254.169.254/latest/meta-data/placement/region`
echo export REGION_CODE=${REGION_CODE} > ~ec2-user/cloud-env.sh
alias cp='cp'
cp -R tidb-course-201-lab/setup/tidb-quick-demo-aws-10-nodes-amz2/* ~ec2-user/
cp -R tidb-course-201-lab/setup/tidb-lab-mysql-init-amz2/show-mysql-password.sh ~ec2-user/
cd ~
chown -R ec2-user:ec2-user ~ec2-user/*
chmod +x ~ec2-user/*.sh
echo "if [ -f /home/ec2-user/hosts-env.sh ]; then" >> ~ec2-user/.bashrc
echo "    source /home/ec2-user/hosts-env.sh" >> ~ec2-user/.bashrc
echo "fi;" >> ~ec2-user/.bashrc
su ec2-user -c "pip3 install boto3"
