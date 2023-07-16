#!/bin/bash
VERSION=${1}

./01-precheck-and-fix-nodes.sh
./destroy-all.sh

# Creating the TiDB cluster named tidb-test, version ${VERSION}
~/.tiup/bin/tiup cluster deploy tidb-test ${VERSION} ./solution-topology-ten-nodes.yaml --yes

sleep 3;

~/.tiup/bin/tiup cluster start tidb-test
