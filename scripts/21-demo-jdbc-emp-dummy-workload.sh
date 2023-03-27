#!/bin/bash

# Run ./21-demo-jdbc-emp-dummy-workload.sh

rm -f DemoJdbcEMPWorkload.class
javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcEMPWorkload.java
sleep 1

# high IO priority?
java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcEMPWorkload
