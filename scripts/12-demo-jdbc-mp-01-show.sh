#!/bin/bash

# Run ./12-demo-jdbc-mp-01-show.sh 

rm -f DemoJdbcMaxPerformance.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcMaxPerformance.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcMaxPerformance
