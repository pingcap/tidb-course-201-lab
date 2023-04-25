#!/bin/bash

# Run ./02-demo-jdbc-endless-insert-dummy.sh

rm -f DemoJdbcEndlessInsertDummyV3.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEndlessInsertDummyV3.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEndlessInsertDummyV3 $*
