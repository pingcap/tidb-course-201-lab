#!/bin/bash

# Higher cost storage TiKV node + 1 to Seattle
for i in {1..1}; do
  sleep 10
  ~/.tiup/bin/tiup playground scale-out --kv 1 --kv.config ./misc/label-storage-higher-cost-seattle.toml
done;

~/.tiup/bin/tiup playground display
