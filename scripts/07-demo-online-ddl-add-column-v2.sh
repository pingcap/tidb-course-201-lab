#!/bin/bash

mysql -h 127.0.0.1 -P 4000 -uroot 2>/dev/null << EOF
SET GLOBAL tidb_enable_metadata_lock = OFF;
SET GLOBAL autocommit = OFF;
DROP DATABASE IF EXISTS demo;
CREATE DATABASE demo;
USE demo;
CREATE TABLE IF NOT EXISTS t1 (
       id BIGINT NOT NULL PRIMARY KEY auto_increment,
       num INT
       );
INSERT INTO t1(num) VALUES (1);
INSERT INTO t1(num) VALUES (2);
EOF


rm -f DemoJdbcPreparedStatement8028v2.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcPreparedStatement8028v2.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcPreparedStatement8028v2 127.0.0.1 4000 root
