#!/bin/bash

source .bash_profile
source ./hosts-env.sh

./fff3.sh

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << EOF
DROP USER IF EXISTS 'jack'@'${HOST_CM_PRIVATE_IP}';
CREATE USER 'jack'@'${HOST_CM_PRIVATE_IP}' IDENTIFIED BY 'pingcap';
CREATE ROLE r_manager, r_staff;
ALTER USER 'jack'@'${HOST_CM_PRIVATE_IP}' IDENTIFIED BY 'tidb';
EOF

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << EOF
DROP ROLE r_staff;
DROP ROLE r_manager;
DROP USER 'jack'@'${HOST_CM_PRIVATE_IP}';
EOF

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << EOF
USE test;
CREATE TABLE emp(id INT, name VARCHAR(20));
INSERT INTO emp VALUES(1,'tom');
INSERT INTO emp VALUES(2,'jack');
CREATE USER 'jack'@'${HOST_CM_PRIVATE_IP}' IDENTIFIED BY 'pingcap';
CREATE ROLE r_mgr, r_emp;
GRANT SELECT ON test.emp TO r_emp;
GRANT INSERT, UPDATE, DELETE ON test.* TO r_mgr;
GRANT r_emp TO r_mgr, 'jack'@'${HOST_CM_PRIVATE_IP}';
EOF

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << EOF
USE test;
CREATE TABLE dept(id INT, dname VARCHAR(20));
INSERT INTO dept VALUES(1, 'dev');
INSERT INTO dept VALUES(2, 'sales');
GRANT SELECT ON test.dept TO 'jack'@'${HOST_CM_PRIVATE_IP}';
EOF

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -ujack -ppingcap << EOF
USE test;
SET ROLE ALL;
DELETE FROM emp WHERE id=1;
EOF
