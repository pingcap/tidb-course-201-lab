#!/bin/bash
source ~/cloud-env.sh

URL=`~/.tiup/bin/tiup cluster display tidb-test | grep 'Dashboard URL:' | awk -F": " '{print $2}' | xargs`

echo ${URL}