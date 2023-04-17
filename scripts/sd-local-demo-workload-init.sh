#!/bin/bash

mysql -h 127.0.0.1 -P 4000 -uroot << EOF
SET CONFIG PD replication.max-replicas=3;
DROP TABLE IF EXISTS test.dummy; 
CREATE TABLE test.dummy (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(80), event JSON);
EOF

./02-demo-jdbc-endless-insert-dummy.sh
