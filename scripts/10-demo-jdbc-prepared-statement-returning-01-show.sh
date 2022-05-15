#!/bin/bash

# Run ./10-demo-jdbc-prepared-statement-returning-01-show.sh 

rm -f DemoJdbcPreparedStatementWithReturning.class
javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcPreparedStatementWithReturning.java
sleep 1
java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcPreparedStatementWithReturning
