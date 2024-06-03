#!/bin/bash

rm -f JdbcConnect.class
javac -cp .:mysql-connector-java-5.1.36-bin.jar JdbcConnect.java
sleep 1
java -cp .:mysql-connector-java-5.1.36-bin.jar JdbcConnect