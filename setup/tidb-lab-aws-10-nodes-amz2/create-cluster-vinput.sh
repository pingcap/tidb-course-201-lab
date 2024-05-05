#!/bin/bash
VERSION=${1}

./01-precheck-and-fix-nodes.sh
./destroy-all.sh

# Creating the TiDB cluster named tidb-test, version ${VERSION}
~/.tiup/bin/tiup mirror set tidb-community-server-${VERSION}-linux-amd64
~/.tiup/bin/tiup cluster deploy tidb-test ${VERSION} ./nine-nodes.yaml --yes
sleep 3;

~/.tiup/bin/tiup cluster start tidb-test
