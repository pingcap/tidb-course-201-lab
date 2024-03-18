#!/bin/bash

source .bash_profile
source ./hosts-env.sh

./fff12.sh

# 13-1
~/.tiup/bin/tiup cluster scale-out tidb-test solution-three-nodes-scale-out-ticdc.yaml --yes
~/.tiup/bin/tiup cluster display tidb-test
~/.tiup/bin/tiup ctl:v6.5.1 cdc capture list --pd=http://${HOST_PD1_PRIVATE_IP}:2379

# 13-2
ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD1_PRIVATE_IP} << 'EOFX'
sudo service mysqld start
X=q1w2e3R4_
mysql -h localhost -P 3306 -uroot -p$X --connect-expired-password << EOF
DROP USER IF EXISTS cdc_user@'%';
CREATE USER cdc_user@'%' identified by 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO cdc_user@'%';
DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
CREATE TABLE test.T1(id INT PRIMARY KEY, name VARCHAR(20));
EOF
exit
EOFX

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD1_PRIVATE_IP} << EOF
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql -pq1w2e3R4_
EOF

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << EOF
CREATE TABLE test.T1(id INT PRIMARY KEY, name VARCHAR(20));
EOF

~/.tiup/bin/tiup cdc:v6.5.1 cli changefeed create --pd=http://${HOST_PD1_PRIVATE_IP}:2379 \
--sink-uri="mysql://cdc_user:q1w2e3R4_@${HOST_PD1_PRIVATE_IP}:3306/" \
--changefeed-id="replication-task-1" --sort-engine="unified"

~/.tiup/bin/tiup cdc:v6.5.1 cli changefeed list --pd=http://${HOST_PD1_PRIVATE_IP}:2379

~/.tiup/bin/tiup cdc:v6.5.1 cli changefeed query --pd=http://${HOST_PD3_PRIVATE_IP}:2379 --changefeed-id=replication-task-1 

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << EOF
INSERT INTO test.T1 VALUES(1, 'Tom');
EOF

# 13-3
#~/.tiup/bin/tiup cdc:v6.5.1 cli changefeed pause --pd=http://${HOST_PD1_PRIVATE_IP}:2379  --changefeed-id replication-task-1
#~/.tiup/bin/tiup cdc:v6.5.1 cli changefeed remove --pd=http://${HOST_PD1_PRIVATE_IP}:2379 --changefeed-id replication-task-1
#~/.tiup/bin/tiup cdc:v6.5.1 cli changefeed list --pd=http://${HOST_PD3_PRIVATE_IP}:2379
#~/.tiup/bin/tiup cluster scale-in tidb-test --node ${HOST_PD1_PRIVATE_IP}:8300 --node ${HOST_PD2_PRIVATE_IP}:8300 --node ${HOST_PD3_PRIVATE_IP}:8300 --yes