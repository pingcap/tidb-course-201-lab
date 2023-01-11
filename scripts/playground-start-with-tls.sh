#!/bin/bash
~/.tiup/bin/tiup playground v6.2.0 --tag classroom-tls --db 3 --pd 3 --kv 3 --tiflash 1 --db.config ./misc/tls.toml
