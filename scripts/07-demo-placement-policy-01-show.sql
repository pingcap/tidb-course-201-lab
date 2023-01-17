/* source 07-demo-placement-policy-01-show.sql */

/* PREPARE 1: Stop (ctrl-c) playground-start.sh */
/* PREPARE 2: In terminal #1: Run ./playground-init-geo-01.sh and wait for "CLUSTER START SUCCESSFULLY" */ 
/* PREPARE 3: In terminal #2: Run ./playground-init-geo-02.sh */

/* Check existing labels on TiKV stores */
SELECT store_id, address, store_state_name, label
FROM information_schema.tikv_store_status;

/* Check available labels PD aware */
SHOW PLACEMENT LABELS;

/* Create placement policy - East & West */
CREATE PLACEMENT POLICY IF NOT EXISTS east PRIMARY_REGION="shanghai" REGIONS="shanghai,seattle" FOLLOWERS=2;
CREATE PLACEMENT POLICY IF NOT EXISTS west PRIMARY_REGION="seattle" REGIONS="seattle,shanghai" FOLLOWERS=2;

/* Create table using placement policies */
DROP TABLE IF EXISTS test.t_east;
CREATE TABLE test.t_east(
  id bigint primary key auto_random,
  name varchar(30),
  t_mark timestamp default now()
) PLACEMENT POLICY = east;

DROP TABLE IF EXISTS test.t_west;
CREATE TABLE test.t_west(
  id bigint primary key auto_random,
  name varchar(30),
  t_mark timestamp default now()
) PLACEMENT POLICY = west;

/* Data load into two tables: East and West */
insert into test.t_east (name) values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
insert into test.t_west (name) values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
SELECT SLEEP(1);
insert into test.t_east (name) select name from test.t_east;
insert into test.t_west (name) select name from test.t_west;
analyze table test.t_east;
analyze table test.t_west;

/* Show status */
select kvrs.region_id, kvss.store_id, kvrp.is_leader, kvss.label, kvss.start_ts
  from information_schema.tikv_region_status kvrs
  join information_schema.tikv_region_peers kvrp
  on kvrs.region_id = kvrp.region_id
  join information_schema.tikv_store_status kvss
  on kvrp.store_id = kvss.store_id
  join information_schema.tables t
  on t.table_name = kvrs.table_name
  where t.table_schema='test' 
  and t.table_name='t_east';

select kvrs.region_id, kvss.store_id, kvrp.is_leader, kvss.label, kvss.start_ts
  from information_schema.tikv_region_status kvrs
  join information_schema.tikv_region_peers kvrp
  on kvrs.region_id = kvrp.region_id
  join information_schema.tikv_store_status kvss
  on kvrp.store_id = kvss.store_id
  join information_schema.tables t
  on t.table_name = kvrs.table_name
  where t.table_schema='test' 
  and t.table_name='t_west';

/* Advanced Placement Rules */
DROP PLACEMENT POLICY IF EXISTS ssd;
CREATE PLACEMENT POLICY ssd 
  CONSTRAINTS="[+disk=ssd]";

DROP PLACEMENT POLICY IF EXISTS hdd;
CREATE PLACEMENT POLICY hdd 
  CONSTRAINTS="[+disk=hdd]";

/* Range Partition rpt1 */
DROP TABLE IF EXISTS test.rpt1;
CREATE TABLE test.rpt1 (name int) PARTITION BY RANGE (name) (
    PARTITION p0 VALUES LESS THAN (5) PLACEMENT POLICY = ssd,
    PARTITION p1 VALUES LESS THAN (10) PLACEMENT POLICY = hdd);

/* Data load */
insert into test.rpt1 (name) values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
insert into test.rpt1 (name) select name from test.rpt1;
insert into test.rpt1 (name) select name from test.rpt1;
insert into test.rpt1 (name) select name from test.rpt1;
insert into test.rpt1 (name) select name from test.rpt1;
insert into test.rpt1 (name) select name from test.rpt1;
insert into test.rpt1 (name) select name from test.rpt1;
insert into test.rpt1 (name) select name from test.rpt1;
insert into test.rpt1 (name) select name from test.rpt1;
insert into test.rpt1 (name) select name from test.rpt1;
insert into test.rpt1 (name) select name from test.rpt1;
insert into test.rpt1 (name) select name from test.rpt1;
insert into test.rpt1 (name) select name from test.rpt1;
analyze table test.rpt1;

/* Show status */
/* Can you explain the result? */
  select kvrs.region_id, kvss.store_id, kvrp.is_leader, kvss.label, kvss.start_ts
    from information_schema.tikv_region_status kvrs
    join information_schema.tikv_region_peers kvrp
    on kvrs.region_id = kvrp.region_id
    join information_schema.tikv_store_status kvss
    on kvrp.store_id = kvss.store_id
    join information_schema.tables t
    on t.table_name = kvrs.table_name
    where t.table_schema='test' 
    and t.table_name='rpt1';

/* Check existing labels on TiKV stores */
/* Use following query to explain above result */
SELECT store_id, address, store_state_name, label
FROM information_schema.tikv_store_status;

/* Check the polices */
SELECT * FROM information_schema.placement_policies\G

/* Stale Local Read t_west table from Shanghai */

SELECT @@tidb_replica_read;

SET SESSION tidb_replica_read = 'follower';

/* Between 20 seconds before and 10 seconds before */
SELECT count(*), max(t_mark), min(t_mark), now()
FROM test.t_west;

/* Run this query as quickly as possible as the data load */
SET @FLOOR = (select min(t_mark) from test.t_west);
SET @CEIL = (select max(t_mark) from test.t_west);
SELECT count(*), max(t_mark), min(t_mark), now()
FROM test.t_west
  AS OF TIMESTAMP TIDB_BOUNDED_STALENESS(@FLOOR, @CEIL);

/* Typical stale query in application */
SELECT count(*), max(t_mark), min(t_mark), now()
FROM test.t_west
  AS OF TIMESTAMP TIDB_BOUNDED_STALENESS(NOW()-10, NOW());
