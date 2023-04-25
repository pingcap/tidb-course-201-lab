#!/bin/bash

# Adding one TiDB server 
sleep 1;
~/.tiup/bin/tiup playground scale-out --db 1

# Lower cost storage TiKV node + 3
~/.tiup/bin/tiup playground scale-out --kv 3 --kv.config ./misc/label-storage-lower-cost.toml

~/.tiup/bin/tiup playground display
