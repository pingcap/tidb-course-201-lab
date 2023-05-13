#!/bin/bash

TIPROXY=${1}

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ec2-user@${TIPROXY} "TiProxy/bin/tiproxy --config=tiproxy.toml 1>/dev/null 2>&1"
