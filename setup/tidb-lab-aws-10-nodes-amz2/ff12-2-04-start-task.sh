#!/bin/bash

# Fast forward E12-2-03
./ff12-2-03-source-and-task-config.sh
source .bash_profile
source ./hosts-env.sh

tiup dmctl:v6.5.1 --master-addr=${HOST_PD1_PRIVATE_IP}:8261 start-task dm-task.yaml
tiup dmctl:v6.5.1 --master-addr=${HOST_PD1_PRIVATE_IP}:8261 query-status dm-task.yaml
