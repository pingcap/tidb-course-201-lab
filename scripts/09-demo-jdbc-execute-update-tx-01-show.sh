#!/bin/bash

# Run ./09-demo-jdbc-execute-update-tx-01-show.sh 

# With TX control

rm -f DemoJdbcExecuteUpdateTransactionControl.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcExecuteUpdateTransactionControl.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcExecuteUpdateTransactionControl
