#!/bin/bash
~/.tiup/bin/tiup cluster start tidb-test
sleep 3;
./check-cluster.sh