#!/bin/bash
~/.tiup/bin/tiup playground v6.5.1 \
  --tag classroom-tiflash \
  --db 1 \
  --pd 3 \
  --kv 3 \
  --tiflash 2
