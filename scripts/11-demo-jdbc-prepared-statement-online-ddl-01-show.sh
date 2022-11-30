#!/bin/bash

# Run ./11-demo-jdbc-prepared-statement-online-ddl-01-show.sh cloud|local [<error-code-to-handle-once>]

rm -f DemoJdbcPreparedStatement8028.class
javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcPreparedStatement8028.java
sleep 1
java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcPreparedStatement8028 $*
