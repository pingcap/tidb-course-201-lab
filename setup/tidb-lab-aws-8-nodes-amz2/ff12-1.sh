#!/bin/bash

# Fast forward E1
./ff1.sh
source .bash_profile
source ./hosts-env.sh

# Fast forward E12-1
tiup install dm dmctl
tiup update --self && tiup update dm && tiup update dm
tiup dm deploy dm-test v6.1.0 ./six-nodes-dm-hybrid.yaml --yes
tiup dm start dm-test
sleep 10
tiup dm display dm-test
