# 实验 1: `SELECT` 基础

## 目的
+ 在 `universe` 数据库中练习以下 `SELECT` 基本操作:
  + 投射
  + 过滤

*******************************
## Universe 数据库表结构描述
<img src="../../../diagram/schema-universe.png" width="70%" align="top"/>

## 练习

*******************************
#### 1. 补全 `< >` 中的条件，找到逃逸速度大于轨道速度的行星, 并且练习一下大小写对字段名、表名有没有影响
```sql
SELECT name, escape_velocity, orbital_velocity
FROM universe.planets
WHERE < >;
```

*******************************
#### 2. 补全 `< >` 中的条件，找到平均温度低于100(包含)度的行星
```sql
SELECT name, mean_temperature
FROM universe.planets
WHERE < >;
```

*******************************
#### 3. 补全 `< >` 中的条件，找到以字母 `P` 开头的行星名及其平均气温与重力加速度
```sql
SELECT < >
FROM universe.planets
WHERE < >;
```

*******************************
#### 4. 补全 `< >` 中的条件，找到具备磁场或重力加速度为 5 (包含) 到 10 (包含) 的行星
```sql
SELECT name, gravity, global_magnetic_field
FROM universe.planets
WHERE < >;
```

## 练习答案
*******************************
### 提示：使用 `DESC` 命令观察 `universe.planets` 表的结构与各个字段

*******************************
### 提示：使用 `source show-universe-comments.sql` 观察 `universe.planets` 表中字段的 `comments`

*******************************
#### 1. 补全 `< >` 中的条件，找到逃逸速度大于轨道速度的行星, 并且练习一下大小写对字段名、表名有没有影响
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

*******************************
#### 2. 补全 `< >` 中的条件，找到平均温度低于100(包含)度的行星
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
*******************************
#### 3. 补全 `< >` 中的条件，找到以字母 `P` 开头的行星名及其平均气温与重力加速度
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

*******************************
#### 4. 补全 `< >` 中的条件，找到具备磁场或重力加速度为 5 (包含) 到 10 (包含) 的行星
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
