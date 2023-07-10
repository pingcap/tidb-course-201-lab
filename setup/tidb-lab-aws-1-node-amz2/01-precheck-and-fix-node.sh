#!/bin/bash
curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
~/.tiup/bin/tiup update --all

~/.tiup/bin/tiup cluster check solution-topology-single-node.yaml --apply && \
~/.tiup/bin/tiup cluster check solution-topology-single-node.yaml

echo "############################################################################################"
echo "## It's safe to ignore disk and cpu-governor check failures in this classroom environment. #"
echo "############################################################################################"