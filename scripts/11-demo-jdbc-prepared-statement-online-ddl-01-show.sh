#!/bin/bash

# Run ./11-demo-jdbc-prepared-statement-online-ddl-01-show.sh cloud|local [<error-code-to-handle-once>]

mysql -h 127.0.0.1 -P 4000 -uroot 2>/dev/null << EOF
SET GLOBAL tidb_enable_metadata_lock = OFF;
EOF


rm -f DemoJdbcPreparedStatement8028.class
javac -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcPreparedStatement8028.java
sleep 1
java -cp .:misc/mysql-connector-java-5.1.36-bin.jar DemoJdbcPreparedStatement8028 $*
