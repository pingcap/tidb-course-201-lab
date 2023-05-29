#!/bin/bash

# Run ./21-demo-jdbc-mydb-dummy-workload.sh

rm -f DemoJdbcMyDBWorkload.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcMyDBWorkload.java
sleep 1

# high IO priority?
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcMyDBWorkload
