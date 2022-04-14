#!/bin/bash

# ./07-demo-auto-increment-02-show.sh

echo INSERT via TiDB server 4000
mysql -h 127.0.0.1 -P 4000 -u root < misc/insert-into-t2-4000-default.sql
echo INSERT via TiDB server 4001
mysql -h 127.0.0.1 -P 4001 -u root < misc/insert-into-t2-4001-default.sql
mysql -h 127.0.0.1 -P 4000 -u root < misc/select-from-t2.sql