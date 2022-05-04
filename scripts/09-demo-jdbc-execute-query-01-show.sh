#!/bin/bash

# Run ./09-demo-jdbc-execute-query-01-show.sh 

rm -f DemoJdbcExecuteQuery.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcExecuteQuery.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcExecuteQuery
