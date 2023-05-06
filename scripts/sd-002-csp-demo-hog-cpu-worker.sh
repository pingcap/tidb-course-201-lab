#!/bin/bash

DB=${1}

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -A ec2-user@${DB} "while true; do continue; done"
