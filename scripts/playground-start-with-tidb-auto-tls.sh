#!/bin/bash
~/.tiup/bin/tiup playground v6.5.1 --tag classroom-651-tls --db 2 --pd 3 --kv 3 --tiflash 0 --db.config ./misc/tidb-auto-tls.toml
