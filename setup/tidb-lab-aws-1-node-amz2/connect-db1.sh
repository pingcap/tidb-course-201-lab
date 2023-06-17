#!/bin/bash

source ./hosts-env.sh

# For cluster
export MYSQL_PS1="tidb:db1> "
mysql -h ${HOST_DB1_PRIVATE_IP} -P 4000 -u root
