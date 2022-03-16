# Lab 201.1.2: Creating the "Universe" Database in a TiDB Cluster

## Objectives
+ Create a `universe` database as the dataset for the labs in this course.

## Prerequisites
+ Completed one of the following labs and keeps the TiDB database cluster running: 
  + [Lab 201.1.1a](lab-1a-native-playground.md)  
  + [Lab 201.1.1b](lab-1b-container-tidb.md)
  + [Lab 201.1.1d](lab-1d-tidb-cloud-dev-tier.md)
  + [Lab 201.1.1e](lab-1e-WSL-linux-playground.md)
+ Database client installed:
  + Recommand: [MySQL client](https://google.com/search?q=MacOS+mysql+client+install)
  + Alternative: [MySQL Workbench (be noted, the version should be: 6.3.10, landing page might show the latest version instead)](https://downloads.mysql.com/archives/workbench/)

## Steps

****************************
#### 1. Clone the lab repository to local:
```
$ git clone https://github.com/pingcap/tidb-course-201-lab
```

****************************
#### 2. Switch the working directory to `tidb-course-201-lab`:
```
$ cd tidb-course-201-lab/
```

****************************
#### 3. Open a new session from the terminal to access the TiDB sandbox database (local or in TiDB Cloud):
+ a. Steps for local TiDB (created by lab 1a, 1b, 1c, or 1e) - Login without password:
  ```
  $ mysql -h 127.0.0.1 -P 4000 -uroot
  ``` 
+ b. Steps for TiDB Cloud (created by Experiment 1d) - Login with password:
  + Click `Connect` on the TiDB Cloud Cluster page
  + On the `Connect to TiDB` page, in the `Standard Connection`, click `Add Your Current IP Address`
  + Copy the command listed under `Step 2: Connect with a SQL client` and execute it locally
    ```
    mysql --connect-timeout 15 -uroot -h <tidb_cloud_server_dns_name> -P 4000 -p
    ```

****************************
#### 4. Import universe schema/databse:
```sql
tidb> source scripts/universe.sql
```

****************************
#### 5. Check the result - database:
```sql
tidb> show databases;
```

#### 6. Check the result - tables:
```sql
tidb> show tables from universe;
```

#### 7. Checking for columns with comment:
```sql
tidb> source scripts/show-universe-comments.sql;
```

****************************
## Output Samples

****************************
#### Reference output for Step 5:
```sql
tidb> show databases;
```
```
+--------------------+
| Database           |
+--------------------+
| INFORMATION_SCHEMA |
| METRICS_SCHEMA     |
| PERFORMANCE_SCHEMA |
| mysql              |
| test               |
| universe           |
+--------------------+
6 rows in set (0.00 sec)
```

*******************************
#### #### Reference output for Step 6:
```sql
tidb> show tables from universe;
```
```
+--------------------+
| Tables_in_universe |
+--------------------+
| moons              |
| planet_categories  |
| planets            |
| stars              |
+--------------------+
4 rows in set (0.00 sec)
```

*******************************
#### #### Reference output for Step 7:
```sql
tidb> source scripts/show-universe-comments.sql
```
```
+----------------------+----------------+
| Stars Columns        | column_comment |
+----------------------+----------------+
| mass                 | 10**24 kg      |
| density              | kg/m**3        |
| gravity              | m/s**2         |
| escape_velocity      | km/s           |
| mass_conversion_rate | 10**6 kg/s     |
+----------------------+----------------+
5 rows in set (0.01 sec)

+---------------------+----------------+
| Planets Columns     | column_comment |
+---------------------+----------------+
| mass                | 10**24 kg      |
| diameter            | km             |
| density             | kg/m**3        |
| gravity             | m/s**2         |
| escape_velocity     | km/s           |
| rotation_period     | hours          |
| length_of_day       | hours          |
| distance_from_sun   | 10**6 km       |
| perihelion          | 10**6 km       |
| aphelion            | 10**6 km       |
| orbital_period      | days           |
| orbital_velocity    | km/s           |
| orbital_inclination | degrees        |
| obliquity_to_orbit  | degrees        |
| mean_temperature    | C              |
| surface_pressure    | bars           |
+---------------------+----------------+
16 rows in set (0.02 sec)

Empty set (0.02 sec)

+---------------+----------------+
| Moons Columns | column_comment |
+---------------+----------------+
| mass          | 10**24 kg      |
| diameter      | km             |
+---------------+----------------+
2 rows in set (0.02 sec)
```