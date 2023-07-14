#!/bin/bash

./01-precheck-and-fix-nodes.sh

VERSION=${1}
# Creating the TiDB cluster named tidb-demo, version ${VERSION}
~/.tiup/bin/tiup cluster deploy tidb-demo ${VERSION} ./nine-nodes.yaml --yes

sleep 3;

./start-cluster.sh
