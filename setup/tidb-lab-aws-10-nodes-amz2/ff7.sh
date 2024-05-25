#!/bin/bash
REGION_NAME=${1}

# Fast forward E7
./destroy-all.sh
./create-cluster-v651.sh ${REGION_NAME}
