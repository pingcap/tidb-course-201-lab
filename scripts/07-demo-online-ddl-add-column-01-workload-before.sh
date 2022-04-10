#!/bin/bash

# ./07-demo-online-ddl-add-column-01-workload-before.sh

mysql -h 127.0.0.1 -P 4000 -u root < 07-demo-online-ddl-add-column-01-setup.sql

sleep 10;

for i in $(seq 1 200); do
  mysql -h 127.0.0.1 -P 4000 -u root < 07-demo-online-ddl-add-column-01-workload-before.sql
done;
