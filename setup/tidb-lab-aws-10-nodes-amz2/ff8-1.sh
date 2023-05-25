#!/bin/bash

# Fast forward E7
./ff7.sh
source .bash_profile
source ./hosts-env.sh

# Fast forward E8-1
mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
CREATE USER ltask@'%' IDENTIFIED BY 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO ltask@'%';
EOF

tiup install tidb-lightning:v6.5.1

unzip -u stage/tidb-admin-dataset.zip -d stage/

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
DROP DATABASE IF EXISTS emp;
CREATE DATABASE emp;
CREATE TABLE emp.`sal` (`emp_no` INT(11) NOT NULL, `salary` INT(11) NOT NULL, `from_date` DATE NOT NULL, `to_date` DATE NOT NULL, PRIMARY KEY (`emp_no`,`from_date`));
SELECT COUNT(*) FROM emp.sal;
EOF

tiup tidb-lightning:v6.5.1 -config solution-lightning-csv.toml

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOF'
SELECT COUNT(*) FROM emp.sal;
EOF



