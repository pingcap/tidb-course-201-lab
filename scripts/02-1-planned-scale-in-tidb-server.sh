#!/bin/bash

# Scale-in the first TiDB server (its port should be 4000)

TIDB_SERVER_1_PID=`~/.tiup/bin/tiup playground display 2>/dev/null | grep -i tidb | sort -g | head -n 1 | awk -F" " '{print $1}'`
~/.tiup/bin/tiup playground scale-in --pid ${TIDB_SERVER_1_PID}

~/.tiup/bin/tiup playground display
