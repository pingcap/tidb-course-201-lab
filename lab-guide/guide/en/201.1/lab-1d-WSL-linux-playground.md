# Exercise 201.1.1d: Installing the Windows Subsystem for Linux on a Single-instance Windows and Launching a TiDB Playground

## Purpose of the Exercise
Deploy a TiDB cluster for testing purposes as a basis for practice in this course

## Prerequisites
+ Internet connection.
+ Windows system versions require 2004 and later (build 19041 and later).
+ Preinstalled database client `mycli`, `mysql`, or `MySQL Workbench`:
  + [mycli](https://www.mycli.net/) (recommended)
  + [mysql client](https://cn.bing.com/search?q=MacOS+mysql+client+%E5%AE%89%E8%A3%85)
  + [MySQL Workbench - Note Select version: 6.3.10, the page defaults to the latest version](https://downloads.mysql.com/archives/workbench/)


## Steps

-----------------------------------------------
#### 1. Open the Administrator PowerShell or Windows Command Prompt to install WSL:
```
> wsl --install
```

-----------------------------------------------
#### 2. Follow the instructions if reboot is required. Back to the Powershell or Windows Command Prompt, start the Linux subsystem with user root and enter `cd` to switch into the root user's home:
```
> wsl --user root
> cd
```

-----------------------------------------------
#### 3. Download and install mysql-client (this step is to install mysql-client on Linux, you can skip this step if you plan to use the database clients on your Windows only):
```
$ apt install mysql-client-core-8.0
```

-----------------------------------------------
#### 4. To download and install the TiUP tool:
```
$ curl --proto '=https' --tlsv1.2 -sSf https://tiup-mirrors.pingcap.com/install.sh | sh
$ export PATH=~/.tiup/bin:$PATH
```

-----------------------------------------------
#### 5. Export global environment variables (one time operation):
```
$ source ~/.bashrc
```

-----------------------------------------------
#### 6. To launch a cluster (specify the version and number of instances of each component):
```
$ tiup playground v6.0.0 --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
```

------------------------------------------------------
#### 7. Open another terminal (on Linux or Windows, both), execute the following command to access the TiDB database using the MySQL database client, and the `"mysql> "` prompt appears
```
$ mysql -h 127.0.0.1 -P 4000 -uroot
```

+ Alternatively, you can use `mycli`:
  ```
  mycli mysql://root@<tidb_cloud_server_dns_name>:4000
  ```

------------------------------------------------------
#### 8. Get the database version, random number, and current time:
```sql
select connection_id(), version(), rand(), now();
```

------------------------------------------------------
#### 9. Quit the session (if necessary)
```sql
exit
```
