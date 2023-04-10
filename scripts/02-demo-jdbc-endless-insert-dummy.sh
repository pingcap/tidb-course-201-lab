#!/bin/bash

# Run ./02-demo-jdbc-endless-insert-dummy.sh <tidb_server_port_number>

rm -f DemoJdbcEndlessInsertDummy.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEndlessInsertDummy.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEndlessInsertDummy $*
