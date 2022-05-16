#!/bin/bash

# Run ./11-demo-jdbc-prepared-statement-online-ddl-01-show.sh 

rm -f DemoJdbcPreparedStatementOnlineDDL.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcPreparedStatementOnlineDDL.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcPreparedStatementOnlineDDL
