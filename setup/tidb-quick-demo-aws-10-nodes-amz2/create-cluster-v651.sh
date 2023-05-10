#!/bin/bash

./01-precheck-and-fix-nodes.sh

# Creating the TiDB cluster named tidb-demo, version 6.5.1
~/.tiup/bin/tiup cluster deploy tidb-demo 6.5.1 ./ten-nodes.yaml --yes

sleep 20;

./start-cluster.sh
