#!/bin/bash

# Run ./21-demo-jdbc-universe-dummy-workload.sh

rm -f DemoJdbcUniverseWorkload.class
javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcUniverseWorkload.java
sleep 1

# high IO priority?
java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcUniverseWorkload
