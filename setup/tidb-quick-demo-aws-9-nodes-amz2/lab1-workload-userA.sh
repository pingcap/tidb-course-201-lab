#!/bin/bash

source ./hosts-env.sh

sysbench '/usr/local/share/sysbench/oltp_read_only.lua' \
--mysql-host=${HOST_DB1_PRIVATE_IP} \
--mysql-port=4000 \
--mysql-user=userA \
--mysql-db=sbtest \
--percentile=99 \
--mysql-password=tidb \
--time=300 \
--threads=10 \
--tables=32 \
--table-size=100000 \
--report-interval=2 run
