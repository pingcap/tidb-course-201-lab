#!/bin/bash

TIPROXY=${1}
REGION_NAME=${2}

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i ~/.ssh/pe-class-key-${REGION_NAME}.pem ec2-user@${TIPROXY} "TiProxy/bin/tiproxy --config=tiproxy.toml"
