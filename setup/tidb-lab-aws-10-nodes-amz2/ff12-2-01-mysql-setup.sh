#!/bin/bash
REGION_NAME=${1}

# Fast forward E12-1
./ff12-1.sh ${REGION_NAME}
source .bash_profile
source ./hosts-env.sh

# Fast forward E12-2-mysql-setup
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD1_PRIVATE_IP} << 'EOFX'
echo "Operating on `hostname`"
sudo service mysqld start
X=q1w2e3R4_
mysql -h localhost -P 3306 -uroot -p$X --connect-expired-password << 'EOF'
DROP USER IF EXISTS dm_user@'%';
CREATE USER dm_user@'%' identified by 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO dm_user@'%';
SET @@global.show_compatibility_56=ON;
EOF
exit
EOFX

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD2_PRIVATE_IP} << 'EOFX'
echo "Operating on `hostname`"
sudo service mysqld start
X=q1w2e3R4_
mysql -h localhost -P 3306 -uroot -p$X --connect-expired-password << 'EOF'
DROP USER IF EXISTS dm_user@'%';
CREATE USER dm_user@'%' identified by 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO dm_user@'%';
SET @@global.show_compatibility_56=ON;
EOF
exit
EOFX

cd ./stage/
unzip tidb-admin-dataset.zip 1>/dev/null 2>&1
cd -
mysql -udm_user -pq1w2e3R4_ -h ${HOST_PD1_PRIVATE_IP} -P3306 < stage/TiDB-Administration-exercise-data/exercise-12/3306db.sql
mysql -udm_user -pq1w2e3R4_ -h ${HOST_PD2_PRIVATE_IP} -P3306 < stage/TiDB-Administration-exercise-data/exercise-12/3307db.sql 

