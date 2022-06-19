# Exercise 201.1.1b: Deploying a Test Cluster in a Single-instance (macOS/Linux) Environment as a Practice Environment

## Purpose of the Exercise
Deploy the TiDB cluster for testing purposes as the basis for the exercises in this course.

## Prerequisites
+ Internet connection.
+ Preinstalled database client `mycli`, `mysql`, or `MySQL Workbench`:
  + [mycli](https://www.mycli.net/) (recommended)
  + [mysql client](https://cn.bing.com/search?q=MacOS+mysql+client+%E5%AE%89%E8%A3%85)
  + [MySQL Workbench - Note Select version: 6.3.10, the page defaults to the latest version](https://downloads.mysql.com/archives/workbench/)

## Steps

-----------------------------------------------
#### 1. To download and install the TiUP tool:
+ Open the terminal
  + Linux: Go to Terminal
  + macOS: Open Terminal.app
+ Download and install the `tiup` tool by executing the following command. Note that `$` is the terminal prompt, and the common one may be `%`:
  ```
  $ curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
  $ export PATH=~/.tiup/bin:$PATH
  ```

-----------------------------------------------
#### 2. Start the cluster (specify the number of instances for each component) and keep the session window open:
```
$ tiup playground v6.0.0 --tag classroom --db 3 --pd 3 --kv 3 --tiflash 1
```

-----------------------------------------------
#### 3. Open another terminal and execute the following command to access the TiDB database using the database client. The `"mysql> "` prompt appears:
```
$ mysql -h 127.0.0.1 -P 4000 -uroot
```

-----------------------------------------------
#### 4. View database version, random number, and current time:
```sql
select connection_id(), version(), rand(), now();
```

-----------------------------------------------
#### 5. Log out of the database session (if necessary)
```sql
exit
```

-----------------------------------------------
#### 6. To stop a test cluster:
+ Go back to the first terminal and press the `ctrl-c` key to stop the test cluster (do not press `ctrl-c` continuously, once is enough, wait patiently for the terminal prompt to appear, such as `$` or `%`)

-----------------------------------------------
#### 7. Start the cluster again
```
$ tiup playground --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
```
