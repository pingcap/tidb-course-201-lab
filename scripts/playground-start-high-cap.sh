#!/bin/bash
tiup playground v5.4.0 --tag classroom-high-cap --db 1 --pd 1 --kv 1 --tiflash 1 \
--kv.config ./misc/tikv-txn.toml \
--db.config ./misc/tidb-txn.toml
