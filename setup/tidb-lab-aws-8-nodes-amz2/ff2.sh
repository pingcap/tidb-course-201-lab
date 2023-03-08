#!/bin/bash

# Fast forward E1
./ff1.sh
source .bash_profile
source ./hosts-env.sh

mysql -h${HOST_DB1_PRIVATE_IP} -P4000 -uroot << EOF
SELECT tidb_version()\G
SHOW DATABASES;
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
SELECT * FROM tab_tidb;
SHOW PROCESSLIST;
EOF
