#!/bin/bash

# Kill TiDB server instance that serves port 4000.

TIDB_SERVER_1_PID=`lsof -PiTCP -sTCP:LISTEN | grep ':4000' | awk -F" " '{print $2}'`
kill -9 ${TIDB_SERVER_1_PID}

~/.tiup/bin/tiup playground display
