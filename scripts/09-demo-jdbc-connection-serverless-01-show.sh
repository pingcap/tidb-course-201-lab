#!/bin/bash

# Run ./09-demo-jdbc-connection-serverless-01-show.sh <host_name> <user_name> <password>
# e.g. ./09-demo-jdbc-connection-serverless-01-show.sh gateway01.ap-southeast-1.prod.aws.tidbcloud.com 3hB7dXAzvejd5sc.root f0rRmzNqljdueyJr

rm -f DemoJdbcConnectionServerless.class

# Up2date driver
javac -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcConnectionServerless.java
sleep 1
java -cp .:misc/mysql-connector-java-8.0.27.jar DemoJdbcConnectionServerless $*
