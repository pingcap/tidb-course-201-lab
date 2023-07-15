#!/bin/bash

# Fast forward E5
./ff5.sh
source .bash_profile
source ./hosts-env.sh

tiup cluster scale-out tidb-test solution-scale-out-tikv.yaml --yes
sleep 10;
tiup cluster display tidb-test
