#!/bin/bash

# Run ./09-demo-jdbc-null-handling-01-show.sh 

rm -f DemoJdbcNullHandling.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcNullHandling.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcNullHandling
