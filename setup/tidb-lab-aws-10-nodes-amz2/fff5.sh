#!/bin/bash
REGION_NAME=${1}

source .bash_profile
source ./hosts-env.sh

./fff4.sh ${REGION_NAME}
