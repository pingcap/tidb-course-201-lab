#!/bin/bash

source .bash_profile
source ./hosts-env.sh

# Fast forward E1
./destroy-all.sh
./01-precheck-and-fix-nodes.sh
~/.tiup/bin/tiup cluster deploy tidb-test 6.5.0 ./solution-topology-ten-nodes.yaml --yes
~/.tiup/bin/tiup cluster start tidb-test

sleep 5;

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
