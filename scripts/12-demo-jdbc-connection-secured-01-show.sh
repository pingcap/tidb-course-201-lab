#!/bin/bash

# Run ./09-demo-jdbc-connection-secured-01-show.sh

rm -f DemoJdbcConnectionSecured.class

javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcConnectionSecured.java
sleep 1
java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcConnectionSecured
