#!/bin/bash

# Fast forward E1
./destroy-all.sh
./01-precheck-and-fix-nodes.sh
~/.tiup/bin/tiup cluster deploy tidb-test 6.5.0 ./solution-topology-ten-nodes.yaml --yes
~/.tiup/bin/tiup cluster start tidb-test
