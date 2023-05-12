#!/bin/bash

# Run ./quick-demo-005-jdbc-endless-insert-dummy.sh <LB_NAME>

rm -f DemoJdbcEndlessInsertDummyCSPWithLBLongConn.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEndlessInsertDummyCSPWithLBLongConn.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEndlessInsertDummyCSPWithLBLongConn ${1}
