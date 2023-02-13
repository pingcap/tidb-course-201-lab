#!/bin/bash

# Fast forward E13-1
./ff13-1.sh
source .bash_profile
source ./hosts-env.sh

# Fast forward E13-2
sudo service mysqld start
X=`sudo grep 'temporary password' /var/log/mysqld.log | sed 's/.*: //'`
mysql -h localhost -P 3306 -uroot -p$X --connect-expired-password << EOF
ALTER USER root@'localhost' identified by 'q1w2e3R4_';
CREATE USER cdc_user@'%' identified by 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO cdc_user@'%';
DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
CREATE TABLE test.T1(id INT PRIMARY KEY, name VARCHAR(20));
SELECT * FROM test.T1;
EOF

mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql -pq1w2e3R4_

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << EOF
CREATE TABLE test.T1(id INT PRIMARY KEY, name VARCHAR(20));
SELECT * FROM test.T1;
EOF

tiup cdc:v6.1.0 cli changefeed create --pd=http://${HOST_PD1_PRIVATE_IP}:2379 \
--sink-uri="mysql://cdc_user:q1w2e3R4_@${HOST_PD1_PRIVATE_IP}:3306/" \
--changefeed-id="replication-task-1" --sort-engine="unified"

tiup cdc:v6.1.0 cli changefeed list --pd=http://${HOST_PD1_PRIVATE_IP}:2379

tiup cdc:v6.1.0 cli changefeed query --pd=http://${HOST_PD3_PRIVATE_IP}:2379 --changefeed-id=replication-task-1 

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot -p << EOF
SELECT * FROM test.T1;
INSERT INTO test.T1 VALUES(1, 'Tom');
SELECT * FROM test.T1;
EOF

mysql -u cdc_user -h ${HOST_PD1_PRIVATE_IP} -P 3306 -pq1w2e3R4_ << EOF
SELECT * FROM test.T1;
EOF
