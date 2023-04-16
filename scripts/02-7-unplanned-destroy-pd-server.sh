#!/bin/bash

# Kill one PD server.

PD_SERVER_1_PID=`~/.tiup/bin/tiup playground display 2>/dev/null | grep -i pd | sort -g | head -n 1 | awk -F" " '{print $1}'`
kill -9 ${PD_SERVER_1_PID}

~/.tiup/bin/tiup playground display
