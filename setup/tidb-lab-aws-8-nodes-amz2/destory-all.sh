#!/bin/bash
~/.tiup/bin/tiup cluster clean tidb-test --all --yes
~/.tiup/bin/tiup cluster destroy tidb-test --yes
