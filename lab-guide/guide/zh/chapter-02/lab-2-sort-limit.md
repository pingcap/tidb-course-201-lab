# 实验 2: 排序与 `Top-N` 分析

## 目的
+ 在 `universe` 数据库中练习以下 `SELECT` 基本操作:
  + `ORDER BY`
  + `LIMIT`

*******************************
## Universe 数据库表结构描述
<img src="../../../diagram/schema-universe.png" width="70%" align="top"/>

## 练习

*******************************
#### 1. 补全 `< >` 中的语句，让输出结果按行星质量升序排列
```sql
SELECT name, mass, escape_velocity, orbital_velocity
FROM universe.planets
< >;
```

*******************************
#### 2. 补全 `< >` 中的语句，找出最难从其表面逃逸的前三名行星
```sql
SELECT name, mass, escape_velocity
FROM universe.planets
< >;
```

## 练习答案
*******************************
### 提示：使用 `DESC` 命令观察 `universe.planets` 表的结构与各个字段

*******************************
### 提示：使用 `source show-universe-comments.sql` 观察 `universe.planets` 表中字段的 `comments`

*******************************
#### 1. 补全 `< >` 中的语句，让输出结果按行星质量升序排列
```sql
tidb> SELECT name, mass, escape_velocity, orbital_velocity
    -> FROM universe.planets
    -> ORDER BY mass ASC;
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

*******************************
#### 2. 补全 `< >` 中的语句，找出最难从其表面逃逸的前三名行星
```sql
tidb> SELECT name, mass, escape_velocity
    -> FROM universe.planets
    -> ORDER BY escape_velocity DESC
    -> LIMIT 3;
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