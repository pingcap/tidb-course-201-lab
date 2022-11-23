#!/bin/bash

# Setup Single Node TiDB Topology
cp ./template-single-node-hybrid.yaml ~/single-node-hybrid.yaml
sed -i '' -e "s/<HOST_PD1_PRIVATE_IP>/${HOST_PD1_PRIVATE_IP}/g" ~/single-node-hybrid.yaml 2>/dev/null
echo Topology config file for single node cluster prepared.
