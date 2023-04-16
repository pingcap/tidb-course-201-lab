#!/bin/bash

# Kill one TiDB server instance.

TIDB_SERVER_1_PID=`~/.tiup/bin/tiup playground display 2>/dev/null | grep -i tidb | sort -g -r | head -n 1 | awk -F" " '{print $1}'`
kill -9 ${TIDB_SERVER_1_PID}

~/.tiup/bin/tiup playground display
