#!/bin/bash
REGION_NAME=${1}

# This script is for TiDB Quick Demo 005 - Online Upgrade.

source ~/hosts-env.sh

# Start TiProxy layer
./sd-005-tiproxy.sh ${HOST_TIPROXY1_PRIVATE_IP} ${REGION_NAME} &
./sd-005-tiproxy.sh ${HOST_TIPROXY2_PRIVATE_IP} ${REGION_NAME} &

echo TiProxy Starting ...
sleep 3;
echo Done