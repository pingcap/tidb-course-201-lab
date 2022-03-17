# Lab 201.2.2: Sort and Top-N Analysis

## Objectives
+ Practice the following basic **SELECT** operations in **universe** database:
  + **ORDER BY**
  + **LIMIT**

## Prerequisites
+ Completed [Lab 201.1.2](../201.1/lab-2-create-universe-schema.md)

------------------------------
## Description of the Universe database table schema
<img src="../../../diagram/schema-universe.png" width="70%" align="top"/>

## Practice

------------------------------
#### 1. Complete the statement in `< >` so that the output is sorted in ascending order of planetary mass
```sql
SELECT name, mass, escape_velocity, orbital_velocity
FROM universe.planets
< >;
```

------------------------------
#### 2. Complete the statement in `< >` to find the top three planets that are most difficult to escape from their surface
```sql
SELECT name, mass, escape_velocity
FROM universe.planets
< >;
```

## Practice Solutions
------------------------------
### Tip: Use the `DESC` command to observe the structure and column of the `universe.planets` table

------------------------------
### Tip: Use `source show-universe-comments.sql` to observe the column comments in the `universe.planets` table

------------------------------
#### 1. Complete the statement in `< >` so that the output is sorted in ascending order of planetary mass
```sql
SELECT name, mass, escape_velocity, orbital_velocity
FROM universe.planets
ORDER BY mass ASC;
```
```
+--------------------+--------+-----------------+------------------+
| name               | mass   | escape_velocity | orbital_velocity |
+--------------------+--------+-----------------+------------------+
| Pluto              |  0.013 |             1.3 |              4.7 |
| Mercury            |   0.33 |             4.3 |             47.4 |
| Mars               |  0.642 |             5.0 |             24.1 |
| Venus              |   4.87 |            10.4 |             35.0 |
| Earth              |   5.97 |            11.2 |             29.8 |
| Proxima Centauri b | 7.5819 |             9.3 |             NULL |
| Uranus             |   86.8 |            21.3 |              6.8 |
| Neptune            |    102 |            23.5 |              5.4 |
| Saturn             |    568 |            35.5 |              9.7 |
| Jupiter            |   1898 |            59.5 |             13.1 |
+--------------------+--------+-----------------+------------------+
10 rows in set (0.00 sec)
```

------------------------------
#### 2. Complete the statement in `< >` to find the top three planets that are most difficult to escape from their surface
```sql
SELECT name, mass, escape_velocity
FROM universe.planets
ORDER BY escape_velocity DESC
LIMIT 3;
```
```
+---------+------+-----------------+
| name    | mass | escape_velocity |
+---------+------+-----------------+
| Jupiter | 1898 |            59.5 |
| Saturn  |  568 |            35.5 |
| Neptune |  102 |            23.5 |
+---------+------+-----------------+
3 rows in set (0.00 sec)
```