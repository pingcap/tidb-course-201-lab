#!/bin/bash

# Run ./09-demo-jdbc-tx-optimistic-01-show.sh cloud|local no-retry|retry

rm -f DemoJdbcTxOptimisticLock.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcTxOptimisticLock.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcTxOptimisticLock $*
