#!/bin/bash

# Run ./09-demo-jdbc-tx-pessimistic-01-show.sh 

rm -f DemoJdbcTxPessimisticLock.class
javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcTxPessimisticLock.java
sleep 1
java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcTxPessimisticLock $*
