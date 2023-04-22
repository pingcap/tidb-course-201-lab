#!/bin/bash

~/.tiup/bin/tiup clean classroom-pr
sleep 1;
# Higher cost storage TiKV node + 3
~/.tiup/bin/tiup playground v6.5.2 --tag classroom-pr \
--db 1 \
--pd 1 \
--kv 3 \
--tiflash 0 \
--kv.config ./misc/label-storage-higher-cost.toml
