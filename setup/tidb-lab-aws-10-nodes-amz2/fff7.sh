#!/bin/bash

source .bash_profile
source ./hosts-env.sh

./destroy-all.sh
./01-precheck-and-fix-nodes.sh
~/.tiup/bin/tiup cluster deploy tidb-test 6.5.1 ./solution-topology-ten-nodes-fff3.yaml --yes
~/.tiup/bin/tiup cluster start tidb-test

sleep 25;

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << 'EOFX'
DROP DATABASE IF EXISTS tidb;
CREATE DATABASE tidb;
USE tidb;
CREATE TABLE `tab_tidb` (
`id` INT(11) NOT NULL AUTO_INCREMENT,
`name` VARCHAR(20) NOT NULL DEFAULT '',
`age` INT(11) NOT NULL DEFAULT 0,
`version` VARCHAR(20) NOT NULL DEFAULT '',
PRIMARY KEY (`id`),
KEY `idx_age` (`age`));
INSERT INTO `tab_tidb` VALUES (1,'TiDB',6,'TiDB-v6.1.0');
EOFX

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << 'EOFX'
USE test;
CREATE TABLE t1 (a INT PRIMARY KEY AUTO_INCREMENT);
INSERT INTO t1 VALUES ();
INSERT INTO t1 VALUES ();
SET auto_increment_increment = 10;
INSERT INTO t1 VALUES ();
INSERT INTO t1 VALUES ();
EOFX

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << 'EOFX'
USE test;
INSERT INTO t1 VALUES ();
INSERT INTO t1 VALUES ();
EOFX

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << 'EOFX'
USE test;
INSERT INTO t1 VALUES ();
INSERT INTO t1 VALUES ();
SET GLOBAL auto_increment_increment=10;
EOFX

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << 'EOFX'
USE test;
INSERT INTO t1 VALUES ();
INSERT INTO t1 VALUES ();
EOFX

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
