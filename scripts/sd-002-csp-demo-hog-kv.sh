#!/bin/bash

for i in $(seq 1 3);
do
  for kv in `~/.tiup/bin/tiup cluster display tidb-demo | grep ':20160' | sed 's/:.*//'`;
  do
    echo hog ${kv}
    ./sd-002-csp-demo-hog-cpu-worker.sh ${kv} &
  done;
done;

