#!/bin/bash

for i in $(seq 1 4);
do
  for db in `~/.tiup/bin/tiup cluster display tidb-demo | grep ':4000' | sed 's/:.*//'`;
  do
    echo hog ${db}
    ./sd-002-csp-demo-hog-cpu-worker.sh ${db} &
  done;
done;

