#!/bin/bash
VERSION=${1}
REGION_NAME=${2}

~/.tiup/bin/tiup mirror set tidb-community-server-${VERSION}-linux-amd64
./01-precheck-and-fix-nodes.sh ${REGION_NAME}

# Creating the TiDB cluster named tidb-demo, version ${VERSION}
~/.tiup/bin/tiup cluster deploy tidb-demo ${VERSION} ./nine-nodes.yaml --user ec2-user -i /home/ec2-user/.ssh/pe-class-key-${REGION_NAME}.pem --yes

sleep 3;

./start-cluster.sh
