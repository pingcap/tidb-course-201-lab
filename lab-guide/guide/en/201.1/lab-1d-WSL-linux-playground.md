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
$ tiup playground v6.0.0 --tag classroom --db 2 --pd 3 --kv 3 --tiflash 1
```

------------------------------------------------------
#### 7. Open another terminal (in Ubuntu or in Windows, both works), execute the following command to access the TiDB database using the MySQL database client, and the `"mysql> "` prompt appears:
```
$ mysql -h 127.0.0.1 -P 4000 -uroot
```

------------------------------------------------------
#### 8. Check the database version:
```sql
select version();
```

------------------------------------------------------
#### 9. Exit ther datbase session (if needed)
```sql
exit
```
