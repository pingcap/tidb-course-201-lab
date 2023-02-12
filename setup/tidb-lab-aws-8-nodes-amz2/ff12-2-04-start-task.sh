#!/bin/bash
# author:guanglei.bao@pingcap.com

# Fast forward E12-2-03
./ff12-2-03-source-and-task-config.sh
source .bash_profile
source ./hosts-env.sh

tiup dmctl --master-addr=${HOST_PD1_PRIVATE_IP}:8261 check-task ./dm-task.yaml
