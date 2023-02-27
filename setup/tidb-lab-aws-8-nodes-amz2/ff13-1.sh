#!/bin/bash

# Fast forward E7
./ff7.sh
source .bash_profile
source ./hosts-env.sh

# Fast forward E13-1
tiup cluster scale-out tidb-test three-nodes-scale-out-ticdc.yaml --yes
tiup cluster display tidb-test
tiup ctl:v6.1.1 cdc:v6.1.1 capture list --pd=http://${HOST_PD1_PRIVATE_IP}:2379
