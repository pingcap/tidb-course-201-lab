#!/bin/bash

# Fast forward E1
./01-install-tiup.sh
./02-precheck-and-fix-nodes.sh
./create-cluster-v650.sh
./start-cluster.sh
sleep 20
./check-cluster.sh
