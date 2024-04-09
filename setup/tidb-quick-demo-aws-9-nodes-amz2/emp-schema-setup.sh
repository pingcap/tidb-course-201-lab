#!/bin/bash

source ./hosts-env.sh

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 << 'EOFX'
CREATE USER ltask@'%' IDENTIFIED BY 'q1w2e3R4_';
GRANT ALL PRIVILEGES ON *.* TO ltask@'%';
DROP DATABASE IF EXISTS emp;
CREATE DATABASE emp;
USE emp;
CREATE TABLE `sal` ( `emp_no` INT(11) NOT NULL, `salary` INT(11) NOT NULL, `from_date` DATE NOT NULL, `to_date` DATE NOT NULL, PRIMARY KEY (`emp_no`,`from_date`));
EOFX

~/.tiup/bin/tiup install tidb-lightning:v7.1.0

~/.tiup/bin/tiup tidb-lightning:v7.1.0 -config solution-lightning-csv.toml
