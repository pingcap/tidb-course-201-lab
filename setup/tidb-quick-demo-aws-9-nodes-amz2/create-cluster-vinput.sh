#!/bin/bash

./01-precheck-and-fix-nodes.sh

VERSION=${1}
# Creating the TiDB cluster named tidb-test, version ${VERSION}
~/.tiup/bin/tiup cluster deploy tidb-test ${VERSION} ./nine-nodes.yaml --yes

sleep 3;

./start-cluster.sh
