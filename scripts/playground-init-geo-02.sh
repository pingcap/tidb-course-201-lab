#!/bin/bash
./add-geo-tikv-seattle-hdd.sh
sleep 10;
./add-geo-tikv-seattle-ssd.sh
sleep 10;
./add-geo-tikv-shanghai-hdd.sh
sleep 10;
./add-geo-tikv-shanghai-ssd.sh
