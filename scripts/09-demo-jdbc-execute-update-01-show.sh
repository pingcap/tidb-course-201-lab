#!/bin/bash

# Run ./09-demo-jdbc-execute-update-01-show.sh 

rm -f DemoJdbcExecuteUpdate.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcExecuteUpdate.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcExecuteUpdate
