# Create a sandbox Playground TiDB cluster on local machine

## Note:
+ TiUP supports Linux and macOS only.

1. Clone the workshop demo scripts repository to local.
```
$ git clone https://github.com/pingcap/tidb-course-201-lab.git && cd tidb-course-201-lab/scripts
```

2. Launch the Playground TiDB cluster on local machine.
```
$ ./playground-start.sh
```

3. In another terminal, run script `playground-check.sh` under `tidb-course-201-lab/scripts` directory to verify the Playground status. You should see the output similar as below.
```
$ ./playground-check.sh
tiup is checking updates for component playground ...
Starting component `playground`: ...
Pid   Role     Uptime
---   ----     ------
1156  pd       25m13.631986413s
1157  pd       25m13.60729254s
1158  pd       25m13.567111924s
1159  tikv     25m13.523210764s
1160  tikv     25m13.477986663s
1161  tikv     25m13.440549763s
1162  tidb     25m13.401805415s
1163  tidb     25m13.361585913s
1164  tidb     25m13.324499703s
1187  tiflash  24m43.134376246s
```

