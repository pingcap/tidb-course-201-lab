#!/bin/bash

# Run ./09-demo-jdbc-connection-01-incorrect.sh

rm -f DemoJdbcConnection.class

# Up2date driver
#javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcConnection.java
#sleep 1
#java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcConnection

# Recommended driver for MySQL 5.7
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcConnectionIncorrect.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcConnectionIncorrect
