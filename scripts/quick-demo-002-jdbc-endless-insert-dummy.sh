#!/bin/bash

# Run ./quick-demo-002-jdbc-endless-insert-dummy.sh <LB_NAME>

rm -f DemoJdbcEndlessInsertDummyCSPWithLB.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEndlessInsertDummyCSPWithLB.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEndlessInsertDummyCSPWithLB ${1}
