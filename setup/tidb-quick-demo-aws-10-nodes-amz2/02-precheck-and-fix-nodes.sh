#!/bin/bash
~/.tiup/bin/tiup cluster check ten-nodes.yaml --apply && \
~/.tiup/bin/tiup cluster check ten-nodes.yaml

echo "############################################################################################"
echo "## It's safe to ignore disk and cpu-governor check failures in this classroom environment. #"
echo "############################################################################################"