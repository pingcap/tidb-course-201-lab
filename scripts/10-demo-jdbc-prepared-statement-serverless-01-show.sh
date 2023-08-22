#!/bin/bash

# Run ./10-demo-jdbc-prepared-statement-01-show.sh <user_name> <password>

rm -f DemoJdbcPreparedStatementServerless.class
javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcPreparedStatementServerless.java
sleep 1
java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcPreparedStatementServerless $*
