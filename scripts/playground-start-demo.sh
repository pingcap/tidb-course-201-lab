#!/bin/bash

~/.tiup/bin/tiup playground v6.5.1 \
  --tag demo \
  --db 2 \
  --pd 3 \
  --kv 3 \
  --tiflash 1 \
  --pd.port 5379
