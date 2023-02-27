#!/bin/bash

# Fast forward E13-2
./ff13-2.sh
source .bash_profile
source ./hosts-env.sh

# Fast forward E13-3
tiup cdc:v6.1.1 cli changefeed pause --pd=http://${HOST_PD1_PRIVATE_IP}:2379  --changefeed-id replication-task-1
tiup cdc:v6.1.1 cli changefeed remove --pd=http://${HOST_PD1_PRIVATE_IP}:2379 --changefeed-id replication-task-1
tiup cdc:v6.1.1 cli changefeed list --pd=http://${HOST_PD3_PRIVATE_IP}:2379
tiup cluster scale-in tidb-test --node ${HOST_PD1_PRIVATE_IP}:8300 --node ${HOST_PD2_PRIVATE_IP}:8300 --node ${HOST_PD3_PRIVATE_IP}:8300 --yes
tiup cluster display tidb-test
