#!/bin/bash

# Fast forward E6-2
./ff6-2.sh
source .bash_profile
source ./hosts-env.sh

tiup cluster rename tidb-test tidb-prod --yes
tiup cluster display tidb-prod
tiup cluster rename tidb-prod tidb-test --yes
tiup cluster display tidb-test
