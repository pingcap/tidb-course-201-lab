# **Lab 201.1.1a: Deploying a Sandbox Cluster as a Lab Environment on MacOS/Linux**

## **Objectives**
Deploy a sandbox TiDB cluster for the labs in this course.

## **Prerequisites**
+ Database client installed:
  + Recommand: [MySQL client](https://google.com/search?q=MacOS+mysql+client+install)
  + Spare: [MySQL Workbench (be noted, the version should be: 6.3.10, landing page might show the latest version instead)](https://downloads.mysql.com/archives/workbench/)
+ Internet connection.

## **Steps**

****************************
#### 1. Download and install `TiUP`:
+ **Open the Terminal**
  + `Linux`: Open `Terminal`
  + `MacOS`: Run `Terminal.app`
+ **Execute the following command to download and install `TiUP` utility. Note that `$` is a terminal prompt, another common one may also be `%`**:
  ```
  $ curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
  $ export PATH=~/.tiup/bin:$PATH
  ```

****************************
#### 2. Launch a sandbox database cluster (specify the number of instances of each component), keep the session window open:
```
$ tiup playground --tag classroom --db 3 --pd 3 --kv 3 --tiflash 1
```

****************************
#### 3. Open another terminal, execute the following command to access the TiDB database using the MySQL database client, and the `"mysql> "` prompt appears, in the example shows as `"tidb> "`:
```
$ mysql -h 127.0.0.1 -P 4000 -uroot
```

****************************
#### 4. Check the database version:
```sql
tidb> select version();
```

****************************
#### 5. Exit ther datbase session (if needed)
```
exit
```

****************************
#### 6. Stop the sandbox database cluster:
+ **Go back to the first terminal and press `ctrl+c` to stop the sandbox cluster (do not press `ctrl+c` continuously, just once is enough, please wait patiently for the terminal prompt, such as `$` or `%`)**
  ```
  ctrl + c
  ```

****************************
#### 7. Start the sandbox cluster again:
```
$ tiup playground --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
```

****************************
## **Output Samples**

****************************
#### **Reference output for Step 2:**
```
$ tiup playground --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
Starting component `playground`: ~/.tiup/components/playground/v1.8.2/tiup-playground v5.3.0 --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
Playground Bootstrapping...
Start pd instance
Start pd instance
Start pd instance
Start tikv instance
Start tikv instance
Start tikv instance
Start tidb instance
Start tidb instance
Waiting for tidb instances ready
127.0.0.1:4000 ... Done
127.0.0.1:4001 ... Done
Start tiflash instance
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

****************************
#### Reference output for Step 4:
```sql
tidb> select version();
```
```
+--------------------+
| version()          |
+--------------------+
| 5.7.25-TiDB-v5.3.0 |
+--------------------+
1 row in set (0.00 sec)
```

#### Reference output for Step 6:
```
^CPlayground receive signal:  interrupt
Got signal interrupt (Component: playground ; PID: 7497)
Wait tiflash(7514) to quit...
Grafana quit
prometheus quit
pd quit
pd quit
ng-monitoring quit
tiflash quit
Wait tidb(7505) to quit...
pd quit
tidb quit
Wait tidb(7504) to quit...
tidb quit
Wait tikv(7503) to quit...
tikv quit
Wait tikv(7502) to quit...
tikv quit
Wait tikv(7501) to quit...
tikv quit
Wait pd(7500) to quit...
Wait pd(7499) to quit...
Wait pd(7498) to quit...
$
```