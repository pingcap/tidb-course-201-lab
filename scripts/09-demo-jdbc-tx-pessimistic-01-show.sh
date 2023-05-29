#!/bin/bash

# Run ./09-demo-jdbc-tx-pessimistic-01-show.sh cloud|local

rm -f DemoJdbcTxPessimisticLock.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcTxPessimisticLock.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcTxPessimisticLock $*
