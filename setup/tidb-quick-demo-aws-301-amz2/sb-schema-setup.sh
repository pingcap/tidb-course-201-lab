#!/bin/bash

source ./hosts-env.sh

mysql -h ${HOST_DB1_PRIVATE_IP} -uroot -P4000 --verbose << 'EOFX'
CREATE DATABASE sbtest;
CREATE USER 'userA'@'%' IDENTIFIED BY 'tidb';
CREATE USER 'userB'@'%' IDENTIFIED BY 'tidb';
GRANT ALL PRIVILEGES ON *.*  TO 'userA'@'%';
GRANT ALL PRIVILEGES ON *.*  TO 'userB'@'%';
EOFX

sysbench '/usr/local/share/sysbench/oltp_read_only.lua' \
--mysql-host=${HOST_DB1_PRIVATE_IP} \
--mysql-port=4000 \
--mysql-user=root \
--mysql-db=sbtest \
--percentile=99 \
--threads=10 \
--tables=32 \
--table-size=100000 \
--report-interval=2 \
--db-driver=mysql prepare
