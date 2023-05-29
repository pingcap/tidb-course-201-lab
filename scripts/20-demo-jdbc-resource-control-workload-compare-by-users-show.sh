#!/bin/bash

# Run ./20-demo-jdbc-resource-control-workload-compare-by-users-show.sh <username1> <username2>

rm -f DemoJdbcDDLDMLWorkloadByUser.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcDDLDMLWorkloadByUser.java
sleep 1

# high IO priority?
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcDDLDMLWorkloadByUser ${1} &

# low IO priority?
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcDDLDMLWorkloadByUser ${2} &

echo "# Workloads for database users ${1} and ${2} started."

echo "# UPDATE will begin after populating the sample data, please wait a few seconds."
