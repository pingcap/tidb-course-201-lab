# Lab 201.2.3: Answer 5 Challenges Listed on this Page

## Objectives
+ Practice the comprehensive operations of **SELECT** in **universe** database
+ If possible, try to give multiple query solutions to compare execution plans
+ *Note: Write your own query solutions as possible as you can, don't look at the reference answers easily*

## Duration: 60-90 minutes

## Prerequisites
+ Completed [Lab 201.1.2](../201.1/lab-2-create-universe-schema.md)

--------------------------------------------------------
## Description of the Universe database table schema
<img src="../../../diagram/schema-universe.png" width="70%" align="top"/>

## Practice

--------------------------------------------------------
#### 1. Which planets have lighter mass than Jupiter's smallest moons?

--------------------------------------------------------
#### 2. Show a planetary statistics of the Solar system. The requirements are: 1) The presence or absence of ring system, 2) Magnetic field coverage and 3) The number of moons, 4) Sort the result in descending order of the number of moons (null values are shown as 0). 5) Last, assign row number to each result row. Achieve all five requirements by one query.

--------------------------------------------------------
#### 3. What is the average number of moons for Jovian category planets?

--------------------------------------------------------
#### 4. What are the top 3 gravitational accelerations of the 5 planets in the solar system that are closest to the Sun?

--------------------------------------------------------
#### 5. Sorts planets in the Solar system by distance from the Sun (from near to far) and shows the ratio of the diameters of neighboring planets (self to previous)

## Practice Solutions
--------------------------------------------------------
### Tip: Use the `DESC` command to observe the structure and column of the `universe.planets` table

------------------------------
### Tip: Use `source show-universe-comments.sql` to observe the column comments in the `universe.planets` table

--------------------------------------------------------
####  1. Which planets have lighter mass than Jupiter's smallest moons?
```sql
/* Subquery Style */
SELECT name, mass FROM universe.planets
WHERE diameter < (SELECT MIN(diameter) FROM universe.moons
                  WHERE planet_id = (SELECT id FROM universe.planets 
                                     WHERE name = 'Jupiter'));
```
```
+-------+-------+
| name  | mass  |
+-------+-------+
| Pluto | 0.013 |
+-------+-------+
```
--------------------------------------------------------
#### 2. Show a planetary statistics of the Solar system. The requirements are: 1) The presence or absence of ring system, 2) Magnetic field coverage and 3) The number of moons, 4) Sort the result in descending order of the number of moons (null values are shown as 0). 5) Last, assign row number to each result row. Achieve all five requirements by one query.
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
```
```
+---------------------+--------------+-----------------------+------------+
| ROW_NUMBER() OVER() | ring_systems | global_magnetic_field | moon_count |
+---------------------+--------------+-----------------------+------------+
|                   1 |            1 |                     1 |         25 |
|                   2 |            0 |                  NULL |          2 |
|                   3 |            0 |                     1 |          1 |
|                   4 |            0 |                     0 |          0 |
+---------------------+--------------+-----------------------+------------+
```
```sql
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
```
+------+---------------+-----------------+------------+
| ROW# | Ring Systems? | Magnetic Field? | Moon Count |
+------+---------------+-----------------+------------+
|    1 | Yes           | Yes             |         25 |
|    2 | No            | N/A             |          2 |
|    3 | No            | Yes             |          1 |
|    4 | No            | No              |          0 |
+------+---------------+-----------------+------------+
```

--------------------------------------------------------
#### 3. What is the average number of moons for Jovian category planets?
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
```
```
+--------------------------+
| sum(pm.m_count)/count(*) |
+--------------------------+
|                   6.2500 |
+--------------------------+
```
```sql
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
```
+-----------------------+
| SUM(w.count)/COUNT(*) |
+-----------------------+
|                6.2500 |
+-----------------------+
```
--------------------------------------------------------
#### 4. What are the top 3 gravitational accelerations of the 5 planets in the solar system that are closest to the Sun?
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
```
+---------+
| name    |
+---------+
| Jupiter |
| Earth   |
| Venus   |
+---------+
```
--------------------------------------------------------
#### 5. Sorts planets in the Solar system by distance from the Sun (from near to far) and shows the ratio of the diameters of neighboring planets (self to previous)
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
```
+---------+------------------------+---------------------------------------------+
| name    | LAG(solar.name) OVER() | solar.diameter/(LAG(solar.diameter) OVER()) |
+---------+------------------------+---------------------------------------------+
| Mercury | NULL                   |                                        NULL |
| Venus   | Mercury                |                                    2.480836 |
| Earth   | Venus                  |                                    1.053866 |
| Mars    | Earth                  |                                    0.532455 |
| Jupiter | Mars                   |                                   21.051826 |
| Saturn  | Jupiter                |                                    0.843003 |
| Uranus  | Saturn                 |                                    0.424089 |
| Neptune | Uranus                 |                                    0.968895 |
| Pluto   | Neptune                |                                    0.047973 |
+---------+------------------------+---------------------------------------------+
```