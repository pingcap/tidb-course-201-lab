#!/bin/bash
# author:guanglei.bao@pingcap.com

# Fast forward E1
./01-install-tiup.sh
./02-precheck-and-fix-nodes.sh
./03-create-cluster.sh
./start-cluster.sh
sleep 10
./check-cluster.sh
