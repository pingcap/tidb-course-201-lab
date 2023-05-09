#!/bin/bash

# Fast forward E7
./01-precheck-and-fix-nodes.sh
./create-cluster-v651.sh
./start-cluster.sh
sleep 20
./check-cluster.sh
