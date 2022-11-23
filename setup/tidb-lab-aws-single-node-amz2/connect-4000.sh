#!/bin/bash

source ./hosts-env.sh

# For cluster
mysql -h ${HOST_DB1_PRIVATE_IP} -P 4000 -u root
