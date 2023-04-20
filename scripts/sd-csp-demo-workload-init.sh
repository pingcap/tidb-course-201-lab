#!/bin/bash

mysql -h ${HOST_DB1_PRIVATE_IP} -P 4000 -uroot << EOF
SET CONFIG PD replication.max-replicas=3;
DROP TABLE IF EXISTS test.dummy; 
CREATE TABLE test.dummy (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(80), event JSON);
EOF

./quick-demo-jdbc-endless-insert-dummy.sh
