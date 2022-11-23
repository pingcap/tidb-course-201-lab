#!/bin/bash
~/.tiup/bin/tiup cluster clean test-asi --all --yes
~/.tiup/bin/tiup cluster destroy test-asi --yes
