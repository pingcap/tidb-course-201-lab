#!/bin/bash

curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh

~/.tiup/bin/tiup cluster check solution-topology-ten-nodes.yaml --apply && \
~/.tiup/bin/tiup cluster check solution-topology-ten-nodes.yaml

echo "############################################################################################"
echo "## It's safe to ignore disk and cpu-governor check failures in this classroom environment. #"
echo "############################################################################################"