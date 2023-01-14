#!/bin/bash

~/.tiup/bin/tiup clean classroom81 --all

# Higher cost storage TiKV node + 1
~/.tiup/bin/tiup playground v6.1.1 --tag classroom81 \
--db 1 \
--pd 1 \
--kv 1 \
--tiflash 1 \
--kv.config ./misc/label-storage-higher-cost.toml
