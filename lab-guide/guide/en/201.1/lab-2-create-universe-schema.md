# Exercise 201.1.2: Creating the universe Database in the TiDB Cluster

## Purpose of the Exercise
+ Create the `universe` database as data for the exercises in this course.

## Prerequisites
+ [git](https://git-scm.com/) is already installed on the operating system.
+ One of pre-installed database clients `mycli`, `mysql`, or `MySQL Workbench`:
  + [mycli](https://www.mycli.net/)
  + [mysql client](https://cn.bing.com/search?q=MacOS+mysql+client+%E5%AE%89%E8%A3%85)
  + [MySQL Workbench - Note Select version: 6.3.10, the page defaults to the latest version](https://downloads.mysql.com/archives/workbench/)

## Steps

-----------------------------------------------
#### 1. Clone example scripts repo to local:
```
$ git clone https://github.com/pingcap/tidb-course-201-lab
```

-----------------------------------------------
#### 2. Change the working directory to `tidb-course-201-lab`:
```
$ cd tidb-course-201-lab/
```

-----------------------------------------------
#### 3. Open a new session from the terminal to access the TiDB test database (local or TiDB Cloud):
+ a. Local TiDB (created by exercises 1b, 1c, 1d, or 1e): Log in directly
  + Using mycli:
    ```
    $ mycli http://root@localhost:4000
    ``` 
  + Or using mysql-client:
    ```
    $ mysql -h 127.0.0.1 -P 4000 -uroot
    ```  
+ b. TiDB Cloud (created by Exercise 1a): Log in with password
  + Click `Connect` on the TiDB Cloud Cluster page
  + On the `Connect to TiDB` page, in `Standard Connection`, click `Add Your Current IP Address`
  + Copy the command listed under `Step 2: Connect with a SQL client` and execute
    + Using mycli:
      ```
      mycli mysql://root@<tidb_cloud_server_dns_name>:4000
      ```
    + Or using mysql-client:
      ```
      mysql --connect-timeout 15 -uroot -h <tidb_cloud_server_dns_name> -P 4000 -p
      ```

-----------------------------------------------
#### 4. Import the example universe schema:
```sql
source scripts/universe.sql
```

-----------------------------------------------
#### 5. Check result `show databases`
```sql
show databases;
```

#### 6. Checks all tables in the universe schema
```sql
show tables from universe;
```

#### 7. Check for column with `comment`
```sql
source scripts/show-universe-comments.sql;
```

-----------------------------------------------
## Sample Output

-----------------------------------------------
#### Step 5 Output Reference
```sql
show databases;
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

-----------------------------------------------
#### Step 6 Output Reference
```sql
show tables from universe;
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

-----------------------------------------------
#### Step 7 Output References
```sql
source scripts/show-universe-comments.sql
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
