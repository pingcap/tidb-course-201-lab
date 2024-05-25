#!/bin/bash
REGION_NAME=${1}

# Fast forward E4
./ff4.sh ${REGION_NAME}
source .bash_profile
source ./hosts-env.sh
