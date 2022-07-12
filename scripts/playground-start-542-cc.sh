#!/bin/bash
tiup playground v5.4.2 --tag classroom-542-cc --db 3 --pd 3 --kv 3 --tiflash 1 --db.config ./misc/new-cc.toml
