#!/bin/bash

# Run ./09-demo-jdbc-tx-optimistic-01-show.sh 

rm -f DemoJdbcTxOptimisticLock.class
javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcTxOptimisticLock.java
sleep 1
java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcTxOptimisticLock $*
