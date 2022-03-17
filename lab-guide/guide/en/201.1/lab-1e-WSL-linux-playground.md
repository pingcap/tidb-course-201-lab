# Lab 201.1.1e: Install WSL (Ubuntu) on Windows and Launch TiDB Sandbox Playground from It

## Objective
Deploy a sandbox TiDB cluster for the labs in this course.

## Prerequisites
+ Internet connection.
+ Windows 10 or later.
+ Database client installed:
  + Recommand: [MySQL client](https://google.com/search?q=MacOS+mysql+client+install)
  + Alternative: [MySQL Workbench (be noted, the version should be: 6.3.10, landing page might show the latest version instead)](https://downloads.mysql.com/archives/workbench/)

## Steps

------------------------------------------------------
#### 1. Open Administrator PowerShell or Windows Command Prompt to install WSL:
```
> wsl --install
```

------------------------------------------------------
#### 2. Follow the instructions to restart after the installation is complete, and you will automatically enter the Ubuntu command line after booting, set up for your Ubuntu user:
<img src="../../../diagram/WSL-settings.png" width="70%" align="top"/>

------------------------------------------------------
#### 3. Download and install `mysql-client` in Ubuntu, if needed:
```
$ apt install mysql-client-core-8.0
```

------------------------------------------------------
#### 4. Download and install the `TiUP`
```
$ curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
```

------------------------------------------------------
#### 5. Export environment variables: 
```
$ source ~/.bashrc
```

------------------------------------------------------
#### 6. Launch the cluster (specify the number of instance of each component):
```
$ tiup playground --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
```

------------------------------------------------------
#### 7. Open another terminal (in Ubuntu or in Windows, both works), execute the following command to access the TiDB database using the MySQL database client, and the `"mysql> "` prompt appears, in the example shows as `"tidb> "`:
```
$ mysql -h 127.0.0.1 -P 4000 -uroot
```

------------------------------------------------------
#### 8. Check the database version:
```sql
tidb> select version();
```

------------------------------------------------------
#### 9. Exit ther datbase session (if needed)
```
exit
```

------------------------------------------------------
### Output Samples

------------------------------------------------------
#### Reference output for Step 6:
```
$ tiup playground --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
tiup is checking updates for component playground ...
A new version of playground is available:
   The latest version:         v1.9.0
   Local installed version:
   Update current component:   tiup update playground
   Update all components:      tiup update --all

The component `playground` version  is not installed; downloading from repository.
download https://tiup-mirrors.pingcap.com/playground-v1.9.0-linux-amd64.tar.gz 6.91 MiB / 6.91 MiB 100.00% 13.10 MiB/s
Starting component `playground`: /root/.tiup/components/playground/v1.9.0/tiup-playground /root/.tiup/components/playground/v1.9.0/tiup-playground --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
Playground Bootstrapping...
Start pd instance:v5.3.0
The component `pd` version v5.3.0 is not installed; downloading from repository.
download https://tiup-mirrors.pingcap.com/pd-v5.3.0-linux-amd64.tar.gz 41.25 MiB / 41.25 MiB 100.00% 9.90 MiB/s
Start pd instance:v5.3.0
Start pd instance:v5.3.0
Start tikv instance:v5.3.0
The component `tikv` version v5.3.0 is not installed; downloading from repository.
download https://tiup-mirrors.pingcap.com/tikv-v5.3.0-linux-amd64.tar.gz 167.92 MiB / 167.92 MiB 100.00% 9.45 MiB/s
Start tikv instance:v5.3.0
Start tikv instance:v5.3.0
Start tidb instance:v5.3.0
The component `tidb` version v5.3.0 is not installed; downloading from repository.
download https://tiup-mirrors.pingcap.com/tidb-v5.3.0-linux-amd64.tar.gz 47.67 MiB / 47.67 MiB 100.00% 6.65 MiB/s
Start tidb instance:v5.3.0
Waiting for tidb instances ready
127.0.0.1:4000 ... Done
127.0.0.1:4001 ... Done
The component `prometheus` version v5.3.0 is not installed; downloading from repository.
download https://tiup-mirrors.pingcap.com/prometheus-v5.3.0-linux-amd64.tar.gz 87.08 MiB / 87.08 MiB 100.00% 9.66 MiB/s
download https://tiup-mirrors.pingcap.com/grafana-v5.3.0-linux-amd64.tar.gz 50.00 MiB / 50.00 MiB 100.00% 9.20 MiB/s
Start tiflash instance:v5.3.0
The component `tiflash` version v5.3.0 is not installed; downloading from repository.
download https://tiup-mirrors.pingcap.com/tiflash-v5.3.0-linux-amd64.tar.gz 412.72 MiB / 412.72 MiB 100.00% 8.27 MiB/s
Waiting for tiflash instances ready
127.0.0.1:3930 ... Done
CLUSTER START SUCCESSFULLY, Enjoy it ^-^
To connect TiDB: mysql --comments --host 127.0.0.1 --port 4001 -u root -p (no password)
To connect TiDB: mysql --comments --host 127.0.0.1 --port 4000 -u root -p (no password)
To view the dashboard: http://127.0.0.1:2379/dashboard
PD client endpoints: [127.0.0.1:2379 127.0.0.1:2382 127.0.0.1:2384]
To view the Prometheus: http://127.0.0.1:9090
To view the Grafana: http://127.0.0.1:3000
```