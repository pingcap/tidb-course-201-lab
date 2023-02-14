#!/bin/bash

# Fast forward E1
./ff1.sh
source .bash_profile
source ./hosts-env.sh

# Fast forward E8-2
unzip -u stage/tidb-admin-dataset.zip -d stage/

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ${HOST_PD2_PRIVATE_IP} unzip -u stage/tidb-admin-dataset.zip -d stage/

