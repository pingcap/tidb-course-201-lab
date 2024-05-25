#!/bin/bash
REGION_NAME=${1}

# Fast forward E6-1
./ff6-1.sh ${REGION_NAME}
source .bash_profile
source ./hosts-env.sh

tiup cluster scale-in tidb-test --node ${HOST_MONITOR1_PRIVATE_IP}:20160 --yes
sleep 10;
tiup cluster display tidb-test
sleep 10;
tiup cluster prune tidb-test --yes
sleep 10;
tiup cluster display tidb-test
