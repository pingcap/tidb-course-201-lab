# **Lab 3:Using mycli to Connect the TiDB cluster and finish simple query in the `universe` database**

## **Objective**
+ mycli is a MYSQL command line tool. Compared with other MYSQL command line tools, mycli has two characteristics: one is to prompt and automatically complete SQL statements, and the other is syntax highlighting. For students who are not proficient in SQL statements, the user experience and learning speed can be greatly improved.

## **Applicable scenario**
+ The TiDB cluster has been started and `lab-2-create-universe-schema` has been completed.
+ Have internet connection.

## **Steps**
****************************
#### 1. Install mycli 
+ a. Install mycli from the terminal
  ```
  $ sudo apt install mycli
  ``` 
+ b. Install mycli from the pip (Requires installation of python)
    ```
    sudo pip install mycli
    ```

****************************
#### 2. Open a new session from the terminal and use mycli to access the TiDB test database
  ```
  $ mycli mysql://root@localhost:4000
  ``` 

****************************
#### 3. Using the characteristics of mycli, complete the SQL statement
+ a.Import example schema - universe (If you have completed Lab 2, you can skip this step):
```sql
tidb> source universe.sql
```

+ b.Check results - databases
```sql
tidb> show databases;
```

+ c.use `universe` database
```sql
tidb> use universe;
```

+ d.Querying the `mass, diameter, gravity` of `Earth`
```sql
tidb> SELECT name,mass,diameter,gravity FROM planets WHERE name='Earth';
```
****************************
## Sample output

****************************
#### Step 3.b Output Reference
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
****************************
#### Step 3.d Output Reference
```sql
tidb> SELECT name,mass,diameter,gravity FROM planets WHERE name='Earth';
```
```
+--------+--------+------------+-----------+
| name   |   mass |   diameter |   gravity |
|--------+--------+------------+-----------|
| Earth  |   5.97 |      12756 |       9.8 |
+--------+--------+------------+-----------+
1 row in set
```