# 实验 1: 利用掌握的技能回答列出的 5 个挑战

## 目的
+ 在 `universe` 数据库中练习 `SELECT` 的综合操作
+ 如有可能，尝试给出多种查询方案，比较执行计划
+ *Note: 尽可能自行写出查询语句，不要轻易查看参考答案*

*******************************
## Universe 数据库表结构描述
<img src="../../../diagram/schema-universe.png" width="70%" align="top"/>

## 练习

*******************************
#### 1. 哪些行星的质量比木星最小的卫星更轻?

*******************************
#### 2. 按有无小行星带、有无磁场覆盖和卫星数量，这三个信息观察太阳系的行星统计，按卫星数量降序排列（空值作为0显示），并给出行号

*******************************
#### 3. 类木(Jovian)行星的平均卫星数量?

*******************************
#### 4. 太阳系中距离太阳最近的 5 个行星里重力加速度的 Top 3 是?

*******************************
#### 5. 将太阳系中的行星按距太阳距离排列（由近到远），并展示相邻行星的直径之比（自身:上一个）

## 练习答案
*******************************
### 提示：使用 `DESC` 命令观察 `universe.planets` 表的结构与各个字段

*******************************
### 提示：使用 `source show-universe-comments.sql` 观察 `universe.planets` 表中字段的 `comments`

*******************************
#### 1. 哪些行星的质量比木星最小的卫星更轻?
```sql
/* Subquery Style */
SELECT name, mass FROM universe.planets
WHERE diameter < (SELECT MIN(diameter) FROM universe.moons
                  WHERE planet_id = (SELECT id FROM universe.planets 
                                     WHERE name = 'Jupiter'));
```

*******************************
#### 2. 按有无小行星带、有无磁场覆盖和卫星数量，这三个信息观察太阳系的行星统计，按卫星数量降序排列（空值作为0显示），并给出行号
```sql
SELECT 
  ROW_NUMBER() OVER(), v.ring_systems, v.global_magnetic_field, v.moon_count
FROM
(SELECT 
  p.ring_systems, p.global_magnetic_field, ifnull(count(m.name),0) moon_count
 FROM
  universe.stars s
 JOIN
  universe.planets p
 ON
  s.id = p.sun_id AND s.name = 'Sun'
 LEFT JOIN
  universe.moons m
 ON
  p.id = m.planet_id
 GROUP BY
  1,2
 ORDER BY 3 DESC) v;

/* Better decorated */
SELECT 
  ROW_NUMBER() OVER() as 'ROW#', 
  case v.ring_systems when 1 then 'Yes' when 0 then 'No' else 'N/A' end as 'Ring Systems?', 
  case v.global_magnetic_field when 1 then 'Yes' when 0 then 'No' else 'N/A' end as 'Magnetic Field?', 
  v.moon_count as 'Moon Count'
FROM
(SELECT 
  p.ring_systems, p.global_magnetic_field, ifnull(count(m.name),0) moon_count
 FROM
  universe.stars s
 JOIN
  universe.planets p
 ON
  s.id = p.sun_id AND s.name = 'Sun'
 LEFT JOIN
  universe.moons m
 ON
  p.id = m.planet_id
 GROUP BY
  1,2
 ORDER BY 3 DESC) v;
```

*******************************
#### 3. 类木(Jovian)行星的平均卫星数量?
```sql
/* Mixed subquery and join style */
SELECT sum(pm.m_count)/count(*) FROM
(SELECT count(m.name) m_count
 FROM universe.moons m
 RIGHT JOIN
 (SELECT p.id, p.name
  FROM universe.planet_categories c
  JOIN universe.planets p
  ON c.id = p.category_id AND c.name = 'Jovian') pc
 ON m.planet_id = pc.id
 GROUP BY pc.name) pm;

/* Handle windowing result after a join */
SELECT SUM(w.count)/COUNT(*) FROM
(SELECT 
  DISTINCT
  planet_name,
  COUNT(moon_name) OVER (PARTITION BY planet_name) count
FROM
  (SELECT p.name planet_name, m.name moon_name, c.name planet_category_name
   FROM universe.planets p
   LEFT JOIN universe.moons m
   ON p.id = m.planet_id
   JOIN universe.planet_categories c
   ON p.category_id = c.id AND c.name = 'Jovian') pm) w;
```

*******************************
#### 4. 太阳系中距离太阳最近的 5 个行星里重力加速度的 Top 3 是?
```sql
SELECT 
  t5.name
FROM
(SELECT p.name, p.gravity, p.distance_from_sun
 FROM universe.planets p
 JOIN universe.stars s
 ON s.id = p.sun_id AND s.name = 'Sun'
 ORDER BY p.distance_from_sun ASC
 LIMIT 5) t5
ORDER BY t5.gravity DESC
LIMIT 3;
```

******************************************
#### 5. 将太阳系中的的行星按日距排列（由近到远），并展示相邻行星的直径之比（自身:上一个）
```sql
SELECT 
 solar.name,
 LAG(solar.name) OVER(),
 solar.diameter/(LAG(solar.diameter) OVER())
FROM
(SELECT p.name, p.diameter, p.distance_from_sun
 FROM universe.planets p
 JOIN universe.stars s
 ON s.id = p.sun_id AND s.name = 'Sun'
 ORDER BY p.distance_from_sun ASC) solar;
```