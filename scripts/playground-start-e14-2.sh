#!/bin/bash
~/.tiup/bin/tiup playground v6.6.0 --tag classroom-e14 --db 1 --pd 3 --kv 1 --tiflash 1 \
--kv.config ./misc/tikv-e14.toml
