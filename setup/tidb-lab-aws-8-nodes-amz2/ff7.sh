#!/bin/bash

# Fast forward E7
./01-install-tiup.sh
./02-precheck-and-fix-nodes.sh
./create-cluster-v611.sh
./start-cluster.sh
sleep 10
./check-cluster.sh
