#!/bin/bash

./playground-clean-classroom-geo.sh

tiup playground v6.2.0 --tag classroom-geo --db 2 --pd 3 --kv 1 --tiflash 1 --kv.config ./misc/label-geo-shanghai-ssd.toml
