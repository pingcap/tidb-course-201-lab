#!/bin/bash

# ./07-demo-99-clean.sh

mysql -h 127.0.0.1 -P 4000 -u root < 07-demo-online-ddl-add-column-03-clean.sql

mysql -h 127.0.0.1 -P 4000 -u root < 07-demo-cluster-index-03-clean.sql

mysql -h 127.0.0.1 -P 4000 -u root < clean-test-t.sql

