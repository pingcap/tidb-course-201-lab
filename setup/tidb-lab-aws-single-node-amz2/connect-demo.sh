#!/bin/bash

# For playground
#~/.tiup/bin/tiup client

source ./host-demo-env.sh

# For cluster
mysql -h ${HOST_DEMO_PRIVATE_IP} -P 4000 -u root
