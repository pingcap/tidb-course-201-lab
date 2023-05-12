#!/bin/bash

# Run ./quick-demo-005-jdbc-endless-insert-dummy.sh <LB_NAME>

rm -f DemoJdbcEndlessInsertDummyCSPWithLBTiProxy.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEndlessInsertDummyCSPWithLBTiProxy.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEndlessInsertDummyCSPWithLBTiProxy ${1}
