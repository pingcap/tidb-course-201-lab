#!/bin/bash
tiup playground v6.0.0 --tag classroom --db 3 --pd 3 --kv 3 --tiflash 1 \
--kv.config ./misc/tikv.toml \
--db.config ./misc/tidb.toml
