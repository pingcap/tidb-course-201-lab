#!/bin/bash
~/.tiup/bin/tiup cluster start tidb-demo
sleep 3;
./check-cluster.sh