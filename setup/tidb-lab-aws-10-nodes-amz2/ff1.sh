#!/bin/bash
REGION_NAME=${1}

# Fast forward E1
# nohup ./create-cluster-v650.sh > nohup-tiup.log &
# tail -f nohup-tiup.log &
./destroy-all.sh
./create-cluster-v650.sh ${REGION_NAME}
