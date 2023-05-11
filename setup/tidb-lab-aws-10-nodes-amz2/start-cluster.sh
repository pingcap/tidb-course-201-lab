#!/bin/bash
~/.tiup/bin/tiup cluster start tidb-test
sleep 30;
./check-cluster.sh