#!/bin/bash
REGION_NAME=${1}

# Fast forward E1
./ff3-3.sh ${REGION_NAME}
source .bash_profile
source ./hosts-env.sh

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << EOF
CREATE USER 'jack'@'${HOST_CM_PRIVATE_IP}' IDENTIFIED BY 'pingcap';
CREATE ROLE r_manager, r_staff;
SELECT user, host, authentication_string FROM mysql.user\G
SELECT * FROM mysql.user WHERE user='r_staff'\G
ALTER USER 'jack'@'${HOST_CM_PRIVATE_IP}' IDENTIFIED BY 'tidb';
EOF

mysql -h ${HOST_DB1_PRIVATE_IP} -P 4000 -ujack -ptidb << EOF
SELECT TIDB_VERSION()\G
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
SELECT CURRENT_ROLE();
SHOW GRANTS;
SET ROLE ALL;
SELECT CURRENT_ROLE();
SHOW GRANTS;
SELECT * FROM emp LIMIT 1;
DELETE FROM emp WHERE id=1;
EOF
