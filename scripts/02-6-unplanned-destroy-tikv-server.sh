#!/bin/bash

# Kill one TiKV server instance.

TIKV_SERVER_1_PID=`~/.tiup/bin/tiup playground display 2>/dev/null | grep -i tikv | sort -g | head -n 1 | awk -F" " '{print $1}'`
kill -9 ${TIKV_SERVER_1_PID}

~/.tiup/bin/tiup playground display
