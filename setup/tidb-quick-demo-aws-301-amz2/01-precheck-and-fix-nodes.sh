#!/bin/bash
REGION_NAME=${1}

~/.tiup/bin/tiup cluster check nine-nodes.yaml --user ec2-user -i /home/ec2-user/.ssh/pe-class-key-${REGION_NAME}.pem --apply

echo "#######################################################################################"
echo "## It's safe to ignore disk and cpu-governor check failures in this lab environment. ##"
echo "#######################################################################################"