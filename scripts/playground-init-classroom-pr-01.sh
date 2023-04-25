#!/bin/bash

~/.tiup/bin/tiup clean classroom-pr

# Higher cost storage TiKV node + 3
sleep 1;
~/.tiup/bin/tiup playground v6.5.1 --tag classroom-pr \
--pd 1 \
--kv 3 \
--db 0 \
--tiflash 0 \
--without-monitor \
--kv.config ./misc/label-storage-higher-cost.toml
