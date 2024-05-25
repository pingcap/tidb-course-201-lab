#!/bin/bash

# curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh

~/.tiup/bin/tiup cluster check ten-nodes.yaml --user ec2-user -i /home/ec2-user/.ssh/pe-class-key-${REGION_NAME}.pem --apply

echo "############################################################################################"
echo "## It's safe to ignore disk and cpu-governor check failures in this classroom environment. #"
echo "############################################################################################"