/* source 07-demo-placement-rules-01-show.sql */

/* PREPARE 1: Stop (ctrl-c) playground-start.sh */
/* PREAPRE 2: Run ./playground-init-geo-01.sh */ 
/* PREPARE 3: Run ./playground-init-geo-02.sh */

/* Check existing lables on TiKV stores */
SELECT store_id, address, store_state_name, label
FROM information_schema.tikv_store_status;

/* Check available labels PD aware */
SHOW PLACEMENT LABELS;

/* Create placement policy - East & West */
CREATE PLACEMENT POLICY east PRIMARY_REGION="shanghai" REGIONS="shanghai,seattle" FOLLOWERS=2;
CREATE PLACEMENT POLICY west PRIMARY_REGION="seattle" REGIONS="seattle,shanghai" FOLLOWERS=2;

/* Create table using placement policies */
DROP TABLE IF EXISTS test.p_east;
CREATE TABLE test.p_east(
  id bigint primary key auto_random,
  name varchar(30)
) PLACEMENT POLICY = east;

DROP TABLE IF EXISTS test.p_west;
CREATE TABLE test.p_west(
  id bigint primary key auto_random,
  name varchar(30)
) PLACEMENT POLICY = west;

/* Data load */
insert into test.p_east (name) values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
insert into test.p_east (name) select name from test.p_east;
insert into test.p_east (name) select name from test.p_east;
insert into test.p_east (name) select name from test.p_east;
insert into test.p_east (name) select name from test.p_east;
insert into test.p_east (name) select name from test.p_east;
insert into test.p_east (name) select name from test.p_east;
insert into test.p_east (name) select name from test.p_east;
insert into test.p_east (name) select name from test.p_east;
insert into test.p_east (name) select name from test.p_east;
insert into test.p_east (name) select name from test.p_east;
insert into test.p_east (name) select name from test.p_east;
insert into test.p_east (name) select name from test.p_east;
analyze table test.p_east;
analyze table test.p_west;

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
and t.table_name='p_east';

select kvrs.region_id, kvss.store_id, kvrp.is_leader, kvss.label, kvss.start_ts
from information_schema.tikv_region_status kvrs
join information_schema.tikv_region_peers kvrp
on kvrs.region_id = kvrp.region_id
join information_schema.tikv_store_status kvss
on kvrp.store_id = kvss.store_id
join information_schema.tables t
on t.table_name = kvrs.table_name
where t.table_schema='test' 
and t.table_name='p_west';

/* Advanced Placement Rules */
DROP PLACEMENT POLICY IF EXISTS ssd;
CREATE PLACEMENT POLICY ssd 
  CONSTRAINTS="[+disk=ssd]";

DROP PLACEMENT POLICY IF EXISTS hdd;
CREATE PLACEMENT POLICY hdd 
  CONSTRAINTS="[+disk=hdd]";

/* Range Partition rpt1 */
DROP TABLE IF EXISTS test.rpt1;
create table test.rpt1 (name int) partition by range (name) (
    partition p0 values less than (5) PLACEMENT POLICY = ssd,
    partition p1 values less than (10) PLACEMENT POLICY = hdd);

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

/* Check the polices */
SELECT * FROM information_schema.placement_policies\G
