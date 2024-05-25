#!/bin/bash
REGION_NAME=${1}

# Fast forward E7
./ff7.sh ${REGION_NAME}
source .bash_profile
source ./hosts-env.sh

# Fast forward E13-1
tiup cluster scale-out tidb-test solution-three-nodes-scale-out-ticdc.yaml --yes
tiup cluster display tidb-test
tiup ctl:v6.5.1 cdc capture list --pd=http://${HOST_PD1_PRIVATE_IP}:2379
