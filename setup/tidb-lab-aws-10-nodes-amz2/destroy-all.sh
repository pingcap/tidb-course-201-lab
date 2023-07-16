#!/bin/bash
~/.tiup/bin/tiup dm destroy dm-test --yes
~/.tiup/bin/tiup cluster destroy tidb-test --yes
~/.tiup/bin/tiup cluster clean tidb-test --all --yes