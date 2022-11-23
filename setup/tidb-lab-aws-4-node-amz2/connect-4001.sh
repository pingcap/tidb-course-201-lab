#!/bin/bash

source ./hosts-env.sh

# For cluster
export MYSQL_PS1="tidb:4001> "
mysql -h ${HOST_DB2_PRIVATE_IP} -P 4001 -u root
