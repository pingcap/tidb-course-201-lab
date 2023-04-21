#!/bin/bash

# Lower cost storage TiKV node + 3
~/.tiup/bin/tiup playground scale-out --kv 3 --kv.config ./misc/label-storage-lower-cost.toml

~/.tiup/bin/tiup playground display
