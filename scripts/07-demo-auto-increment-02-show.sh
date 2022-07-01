#!/bin/bash

# ./07-demo-auto-increment-02-show.sh

echo INSERT via TiDB server 4000
mysql -h 127.0.0.1 -P 4000 -u root < 07-demo-auto-increment-02-show.sql
