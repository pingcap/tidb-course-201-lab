#!/bin/bash

# This script is for TiDB Quick Demo 005 - Online Upgrade.

source ./hosts-env.sh

# Place X509 to TiDB nodes.
openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes -keyout key.pem -out cert.pem -subj "/CN=example.com"

scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no key.pem ec2-user@${HOST_DB1_PRIVATE_IP}:/home/ec2-user/
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cert.pem ec2-user@${HOST_DB1_PRIVATE_IP}:/home/ec2-user/
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no key.pem ec2-user@${HOST_DB2_PRIVATE_IP}:/home/ec2-user/
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no cert.pem ec2-user@${HOST_DB2_PRIVATE_IP}:/home/ec2-user/

# Place TiProxy configuration to TiProxy nodes.
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no tiproxy.toml ec2-user@${HOST_TIPROXY1_PRIVATE_IP}:/home/ec2-user/
scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no tiproxy.toml ec2-user@${HOST_TIPROXY2_PRIVATE_IP}:/home/ec2-user/

# Start TiProxy layer
./sd-005-start-tiproxy.sh ${HOST_TIPROXY1_PRIVATE_IP} &
./sd-005-start-tiproxy.sh ${HOST_TIPROXY2_PRIVATE_IP} &

# Reload the TiDB cluster
cp .tiup/storage/cluster/clusters/tidb-demo/meta.yaml .tiup/storage/cluster/clusters/tidb-demo/meta.yaml.bak
cp ./meta.yaml .tiup/storage/cluster/clusters/tidb-demo/meta.yaml
~/.tiup/bin/tiup cluster reload tidb-demo --yes
