#!/bin/bash

./02-precheck-and-fix-node.sh

VERSION=${1}
# Creating the TiDB cluster named tidb-test, version ${VERSION}
~/.tiup/bin/tiup cluster deploy tidb-test ${VERSION} ./solution-topology-single-node.yaml --yes

sleep 3;

./start-cluster.sh
