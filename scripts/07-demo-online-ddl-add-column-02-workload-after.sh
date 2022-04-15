#!/bin/bash

# ./07-demo-online-ddl-add-column-02-workload-after.sh

sleep 8;

mysql -h 127.0.0.1 -P 4000 -u root < 07-demo-online-ddl-add-column-02.sql

for i in $(seq 1 100); do
  mysql -h 127.0.0.1 -P 4001 -u root < 07-demo-online-ddl-add-column-02-workload-after.sql
done;