#!/bin/bash
tiup playground v6.1.1 --tag classroom-lock --db 1 --pd 1 --kv 1 --tiflash 1 \
--db.config ./misc/tidb-lock.toml
