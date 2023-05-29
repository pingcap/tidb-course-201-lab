#!/bin/bash

# Run ./10-demo-jdbc-batch-insert-01-show.sh local | cloud

rm -f DemoJdbcBatchInsert.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcBatchInsertTest.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcBatchInsertTest $*
