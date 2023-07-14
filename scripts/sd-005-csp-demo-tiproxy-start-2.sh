#!/bin/bash

# This script is for TiDB Quick Demo 005 - Online Upgrade.

source ~/hosts-env.sh

# Start TiProxy layer
./sd-005-tiproxy.sh ${HOST_TIPROXY1_PRIVATE_IP} &
./sd-005-tiproxy.sh ${HOST_TIPROXY2_PRIVATE_IP} &