#!/bin/bash
tiup playground v6.2.0 --tag classroom-high-cap --db 3 --pd 3 --kv 3 --tiflash 1 \
--kv.config ./misc/tikv-txn.toml \
--db.config ./misc/tidb-txn.toml
