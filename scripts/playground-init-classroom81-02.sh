#!/bin/bash

# Lower cost storage TiKV node + 2 
for i in {1..2}; do
  sleep 10
  ~/.tiup/bin/tiup playground scale-out --kv 1 --kv.config ./misc/label-storage-lower-cost.toml
done;

~/.tiup/bin/tiup playground display
