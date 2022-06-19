# Exercise 201.1.1c: Starting TiDB in a Container as a Practice Environment in a Single-instance (macOS/Windows/Linux) Environment

## Purpose of the Exercise
Deploy a TiDB cluster for testing purposes as a basis for practices in this course.

## Prerequisites
+ Internet connection.
+ Preinstalled database client `mycli`, `mysql`, or `MySQL Workbench`:
  + [mycli](https://www.mycli.net/) (recommended)
  + [mysql client](https://cn.bing.com/search?q=MacOS+mysql+client+%E5%AE%89%E8%A3%85)
  + [MySQL Workbench - Note Select version: 6.3.10, the page defaults to the latest version](https://downloads.mysql.com/archives/workbench/)

## Steps

-----------------------------------------------
#### 1. Start the TiDB test cluster
+ Open a terminal (Windows is `CMD`) and a prompt appears. The common ones are `$ `, `% ` (on Windows it is like `C:\> `)
+ Start the container using the `pingcap/tidb` image:
  ```
  $ docker run --name classroom -p 127.0.0.1:4000:4000 pingcap/tidb:latest
  ```

-----------------------------------------------
#### 2. Open another terminal and execute the following command to access the TiDB database using the database client. The `"mysql> "` prompt appears:
```
$ mysql -h 127.0.0.1 -P 4000 -uroot
```

+ Alternatively, you can use `mycli`:
  ```
  mycli mysql://root@<tidb_cloud_server_dns_name>:4000
  ```

-----------------------------------------------
#### 3. Get the database version, random number, and current time:
```sql
select connection_id(), version(), rand(), now();
```

-----------------------------------------------
#### 4. Log out of the database session (if necessary)
```sql
exit
```

-----------------------------------------------
#### 5. To stop a test cluster:
```
$ docker stop classroom
```

-----------------------------------------------
#### 6. To start the cluster again:
```
$ docker start classroom
```
