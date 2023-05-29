#!/bin/bash

# Run ./21-demo-jdbc-emp-dummy-workload.sh

rm -f DemoJdbcEMPWorkload.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEMPWorkload.java
sleep 1

# high IO priority?
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcEMPWorkload
