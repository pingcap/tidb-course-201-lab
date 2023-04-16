#!/bin/bash

# Scale-out one TiKV server

~/.tiup/bin/tiup playground scale-out --kv 1

~/.tiup/bin/tiup playground display
