#!/bin/bash

mysql -h HOST_DB1_PRIVATE_IP -P 4000 -uroot 2>/dev/null << EOF
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


rm -f DemoJdbcPreparedStatement8028Sales.class
javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcPreparedStatement8028Sales.java
sleep 1
java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcPreparedStatement8028Sales ${HOST_DB1_PRIVATE_IP} 4000 root
