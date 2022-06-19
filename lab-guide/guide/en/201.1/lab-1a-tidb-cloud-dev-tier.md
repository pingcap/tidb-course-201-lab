# Exercise 201.1.1a: Register and Use TiDB Cloud Developer Tier as a Practice Environment

## Purpose of the Exercise
Deploy a free test cluster in TiDB Cloud as the basis for the exercises in this course.

## Prerequisites
+ Internet connection.
+ Preinstalled database client `mycli`, `mysql`, or `MySQL Workbench`:
  + [mycli](https://www.mycli.net/) (recommended)
  + [mysql client](https://cn.bing.com/search?q=MacOS+mysql+client+%E5%AE%89%E8%A3%85)
  + [MySQL Workbench - Note Select version: 6.3.10, the page defaults to the latest version](https://downloads.mysql.com/archives/workbench/)

## Steps

-----------------------------------------------
#### 1. Sign Up for TiDB Cloud: Open a browser, visit `https://tidbcloud.com`, click `Sign up` to complete registration and log in
<img src="../../../diagram/tidb-cloud-sign-in.png" width="60%" align="top"/>

-----------------------------------------------
#### 2. Select Free Developer Tier: Click `Get Started for Free`
<img src="../../../diagram/tidb-cloud-tier-selection.png" width="60%" align="top"/>

-----------------------------------------------
#### 3. To create a test cluster: Name the Cluster, set a password, select a cloud provider, select a region, click `Submit` below, observe the creation steps, and wait about 5-15 minutes until `Status` Changed from `Creating` to `Normal`
<img src="../../../diagram/tidb-cloud-cluster-active.png" width="60%" align="top"/>

-----------------------------------------------
#### 4. Click `Connect` on the right, select `Web SQL Shell`, and then click `>_ Open SQL Shell`
<img src="../../../diagram/open-sql-shell.png" width="60%" align="top"/>

-----------------------------------------------
#### 5. Enter the password set in step 3 to log in, view the database version, and keep the session
<img src="../../../diagram/sql-shell-version.png" width="60%" align="top"/>

-----------------------------------------------
#### 6. Open a new session from the local terminal to access TiDB in TiDB Cloud:
+ Click `Connect` on the TiDB Cloud Cluster page
+ On the `Connect to TiDB` page, in `Standard Connection`, click `Add Your Current IP Address`
+ Copy the command listed under `Step 2: Connect with a SQL client` and execute (verify that it <tidb_cloud_server_dns_name>has been replaced with the actual DNS name)
  ```
  mysql --connect-timeout 15 -uroot -h <tidb_cloud_server_dns_name> -P 4000 -p
  ```
+ Alternatively, you can use `mycli`:
  ```
  mycli mysql://root@<tidb_cloud_server_dns_name>:4000
  ```

-----------------------------------------------
#### 7. Get the database version, random number, and current time:
```sql
select connection_id(), version(), rand(), now();
```

-----------------------------------------------
#### 8. Log out of the database session (if necessary)
```sql
exit
```