#!/bin/bash

# Fast forward E12-1
./ff12-1.sh
source .bash_profile
source ./hosts-env.sh

# Fast forward E12-2-mysql-setup
echo "Operating on `hostname`"
sudo service mysqld start
X=`sudo grep 'temporary password' /var/log/mysqld.log | sed 's/.*: //'`
mysql -h localhost -P 3306 -uroot -p$X --connect-expired-password << EOF
ALTER USER root@'localhost' identified by 'q1w2e3R4_';
CREATE USER dm_user@'%' identified by 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO dm_user@'%';
EOF

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD2_PRIVATE_IP} << 'EOFX'
echo "Operating on `hostname`"
sudo service mysqld start
X=`sudo grep 'temporary password' /var/log/mysqld.log | sed 's/.*: //'`
mysql -h localhost -P 3306 -uroot -p$X --connect-expired-password << 'EOF'
ALTER USER root@'localhost' identified by 'q1w2e3R4_';
CREATE USER dm_user@'%' identified by 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO dm_user@'%';
EOF
exit
EOFX

cd ./stage/
unzip tidb-admin-dataset.zip 1>/dev/null 2>&1
cd -
mysql -udm_user -pq1w2e3R4_ -h ${HOST_PD1_PRIVATE_IP} -P3306 < stage/TiDB-Administration-exercise-data/exercise-12/3306db.sql
mysql -udm_user -pq1w2e3R4_ -h ${HOST_PD2_PRIVATE_IP} -P3306 < stage/TiDB-Administration-exercise-data/exercise-12/3307db.sql 

