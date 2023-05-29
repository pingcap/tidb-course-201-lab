#!/bin/bash

# Run ./10-demo-jdbc-prepared-statement-01-show.sh 

rm -f DemoJdbcPreparedStatement.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcPreparedStatement.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcPreparedStatement
