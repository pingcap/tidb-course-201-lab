#!/bin/bash

# Run ./09-demo-jdbc-execute-01-show.sh 

rm -f DemoJdbcExecute.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcExecute.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcExecute
