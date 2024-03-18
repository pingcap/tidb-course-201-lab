#!/bin/bash

source .bash_profile
source ./hosts-env.sh

./fff7.sh

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
DROP USER IF EXISTS ltask@'%';
CREATE USER ltask@'%' IDENTIFIED BY 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO ltask@'%';
EOF

~/.tiup/bin/tiup install tidb-lightning:v6.5.1

unzip -u stage/tidb-admin-dataset.zip -d stage/

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
DROP DATABASE IF EXISTS emp;
CREATE DATABASE emp;
CREATE TABLE emp.`sal` (`emp_no` INT(11) NOT NULL, `salary` INT(11) NOT NULL, `from_date` DATE NOT NULL, `to_date` DATE NOT NULL, PRIMARY KEY (`emp_no`,`from_date`));
EOF

rm -rf /tmp/tidb_lightning_checkpoint.pb

~/.tiup/bin/tiup tidb-lightning:v6.5.1 -config solution-lightning-csv.toml

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
DROP DATABASE IF EXISTS my_db;
EOF

rm -rf /tmp/tidb_lightning_checkpoint.pb

nohup ~/.tiup/bin/tiup tidb-lightning:v6.5.1 -config solution-lightning-p1.toml > nohup.out & 
sleep 10
~/.tiup/bin/tiup tidb-lightning:v6.5.1 -config solution-lightning-p2.toml

rm -rf /tmp/tidb_lightning_checkpoint.pb
