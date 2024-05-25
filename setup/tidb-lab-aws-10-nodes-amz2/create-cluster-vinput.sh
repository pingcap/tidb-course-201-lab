#!/bin/bash
VERSION=${1}
REGION_NAME=${2}

./01-precheck-and-fix-nodes.sh
./destroy-all.sh

# Creating the TiDB cluster named tidb-test, version ${VERSION}
~/.tiup/bin/tiup mirror set tidb-community-server-${VERSION}-linux-amd64
~/.tiup/bin/tiup cluster deploy tidb-test ${VERSION} ./solution-topology-ten-nodes.yaml --user ec2-user -i /home/ec2-user/.ssh/pe-class-key-${REGION_NAME} --yes
sleep 3;

~/.tiup/bin/tiup cluster start tidb-test
