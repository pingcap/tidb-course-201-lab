#!/bin/bash

# Run ./09-demo-jdbc-connection-serverless-01-show.sh <user_name> <password>

rm -f DemoJdbcConnectionServerless.class

# Up2date driver
javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcConnectionServerless.java
sleep 1
java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcConnectionServerless $*
