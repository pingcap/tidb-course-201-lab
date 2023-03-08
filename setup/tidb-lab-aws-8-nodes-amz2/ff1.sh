#!/bin/bash

# Fast forward E1
./01-install-tiup.sh
./02-precheck-and-fix-nodes.sh
./03-create-cluster.sh
./start-cluster.sh
sleep 20
./check-cluster.sh
