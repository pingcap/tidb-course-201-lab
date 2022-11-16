#!/bin/bash

# Run ./10-demo-jdbc-batch-insert-01-show.sh 

rm -f DemoJdbcBatchInsert.class
javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcBatchInsert.java
sleep 1
java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcBatchInsert $*
