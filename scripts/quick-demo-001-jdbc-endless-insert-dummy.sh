#!/bin/bash

# Run ./quick-demo-001-jdbc-endless-insert-dummy.sh

rm -f DemoJdbcEndlessInsertDummyCSP.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEndlessInsertDummyCSP.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEndlessInsertDummyCSP $*
