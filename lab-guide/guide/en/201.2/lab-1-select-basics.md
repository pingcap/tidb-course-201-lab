# Lab 201.2.1: SELECT Basics

## Objectives
+ Practice the following **SELECT** basics in the **universe** database:
  + Projection
  + Selection

## Prerequisites
+ Completed [Lab 201.1.2](../201.1/lab-2-create-universe-schema.md)

------------------------------
## Description of the Universe database table schema
<img src="../../../diagram/schema-universe.png" width="70%" align="top"/>

## Practice

------------------------------
#### 1. Complete the conditions in `< >`, find planets whose escape speed is greater than their orbital speed, and practice whether capitalization affects column names and table names
```sql
SELECT name, escape_velocity, orbital_velocity
FROM universe.planets
WHERE < >;
```

------------------------------
#### 2. Complete the conditions in `< >` and find planets with an average temperature of less than 100 degrees (inclusive)
```sql
SELECT name, mean_temperature
FROM universe.planets
WHERE < >;
```

------------------------------
#### 3. Complete the conditions in `< >` and find the names of the planets starting with the letter `P` and their average temperature and gravitational acceleration
```sql
SELECT < >
FROM universe.planets
WHERE < >;
```

------------------------------
#### 4. Complete the conditions in `< >` and find planets with a magnetic field or gravitational acceleration of 5 (inclusive) to 10 (inclusive)
```sql
SELECT name, gravity, global_magnetic_field
FROM universe.planets
WHERE < >;
```

## Practice Solutions
------------------------------
### Tip: Use the `DESC` command to observe the structure and column of the `universe.planets` table

------------------------------
### Tip: Use `source show-universe-comments.sql` to observe the column comments in the `universe.planets` table

------------------------------
#### 1. Complete the conditions in `< >`, find planets whose escape speed is greater than their orbital speed, and practice whether capitalization affects column names and table names
```sql
tidb> SELECT name, escape_velocity, orbital_velocity
   -> FROM universe.planets
   -> WHERE escape_velocity > orbital_velocity;
```
```
+---------+-----------------+------------------+
| name    | escape_velocity | orbital_velocity |
+---------+-----------------+------------------+
| Jupiter |            59.5 |             13.1 |
| Saturn  |            35.5 |              9.7 |
| Uranus  |            21.3 |              6.8 |
| Neptune |            23.5 |              5.4 |
+---------+-----------------+------------------+
4 rows in set (0.01 sec)
```
```sql
tidb> SELECT name, escape_velocity, Orbital_Velocity
   -> FROM universe.PLANETS
   -> WHERE escape_velocity > orbital_velocity;
```
```
+---------+-----------------+------------------+
| name    | escape_velocity | orbital_velocity |
+---------+-----------------+------------------+
| Jupiter |            59.5 |             13.1 |
| Saturn  |            35.5 |              9.7 |
| Uranus  |            21.3 |              6.8 |
| Neptune |            23.5 |              5.4 |
+---------+-----------------+------------------+
4 rows in set (0.01 sec)
```

------------------------------
#### 2. Complete the conditions in `< >` and find planets with an average temperature of less than 100 degrees (inclusive)
```sql
tidb> SELECT name, mean_temperature 
   -> FROM universe.planets 
   -> WHERE mean_temperature < 100;
```
```
+--------------------+------------------+
| name               | mean_temperature |
+--------------------+------------------+
| Earth              |               15 |
| Mars               |              -65 |
| Jupiter            |             -110 |
| Saturn             |             -140 |
| Uranus             |             -195 |
| Neptune            |             -200 |
| Pluto              |             -225 |
| Proxima Centauri b |              -57 |
+--------------------+------------------+
8 rows in set (0.00 sec)
```
------------------------------
#### 3. Complete the conditions in `< >` and find the names of the planets starting with the letter `P` and their average temperature and gravitational acceleration
```sql
tidb> SELECT name, mean_temperature, gravity
    -> FROM universe.planets
    -> WHERE name like 'P%';
```
```
+--------------------+------------------+---------+
| name               | mean_temperature | gravity |
+--------------------+------------------+---------+
| Pluto              |             -225 |     0.7 |
| Proxima Centauri b |              -57 |    11.3 |
+--------------------+------------------+---------+
2 rows in set (0.01 sec)
```

------------------------------
#### 4. Complete the conditions in `< >` and find planets with a magnetic field or gravitational acceleration of 5 (inclusive) to 10 (inclusive)
```sql
tidb> SELECT name, gravity, global_magnetic_field
    -> FROM universe.planets
    -> WHERE global_magnetic_field = 1
    -> OR (gravity BETWEEN 5 AND 10);
```
```
+---------+---------+-----------------------+
| name    | gravity | global_magnetic_field |
+---------+---------+-----------------------+
| Mercury |     3.7 |                     1 |
| Venus   |     8.9 |                     0 |
| Earth   |     9.8 |                     1 |
| Jupiter |    23.1 |                     1 |
| Saturn  |     9.0 |                     1 |
| Uranus  |     8.7 |                     1 |
| Neptune |    11.0 |                     1 |
+---------+---------+-----------------------+
7 rows in set (0.01 sec)
```
