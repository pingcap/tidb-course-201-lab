#!/bin/bash

source ./hosts-env.sh

# For cluster
mysql -h ${HOST_DB2_PRIVATE_IP} -P 4001 -u root
