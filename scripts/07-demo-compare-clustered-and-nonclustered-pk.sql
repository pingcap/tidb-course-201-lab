/* source 07-demo-compare-clustered-and-nonclustered-pk.sql */

/* Table 1: Clustered */
DROP TABLE IF EXISTS test.auto_increment_t2_clustered;
CREATE TABLE test.auto_increment_t2_clustered (
    id bigint PRIMARY KEY AUTO_INCREMENT,
    id2 bigint, 
    name char(255),
    varname varchar(200));

/* Populate Seed */
INSERT INTO test.auto_increment_t2_clustered (name, varname) VALUES ('A','V1'), ('B','V1'), ('C','V2'), ('D','V2');
UPDATE test.auto_increment_t2_clustered SET id2=id;

/* Flooding with data 2M rows to t1 */
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;
INSERT INTO test.auto_increment_t2_clustered select null, id2, name, varname from test.auto_increment_t2_clustered;

ANALYZE table test.auto_increment_t2_clustered;

/* Data */
select count(distinct id), count(distinct name), count(*), min(id), max(id) from test.auto_increment_t2_clustered;
/* Show information_schema for table */
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='auto_increment_t2_clustered';

/* Show indexes */
/*SHOW INDEXES FROM test.auto_increment_t2_clustered\G*/
/* Show regions */
SHOW TABLE test.auto_increment_t2_clustered regions\G

/* Table 2: Non-Clustered */
DROP TABLE IF EXISTS test.bigint_t3_nonclustered;
CREATE TABLE test.bigint_t3_nonclustered (
    id bigint PRIMARY KEY NONCLUSTERED,
    id2 bigint, 
    name char(255),
    varname varchar(200));

/* Copy from other */
INSERT INTO test.bigint_t3_nonclustered 
    SELECT * FROM test.auto_increment_t2_clustered
    WHERE id <= (SELECT max(id)/2 FROM test.auto_increment_t2_clustered);
INSERT INTO test.bigint_t3_nonclustered 
    SELECT * FROM test.auto_increment_t2_clustered
    WHERE id > (SELECT max(id)/2 FROM test.auto_increment_t2_clustered);
ANALYZE table test.bigint_t3_nonclustered;

/* Data */
select count(distinct id), count(distinct name), count(*), min(id), max(id) from test.bigint_t3_nonclustered;
/* Show information_schema for table */
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='bigint_t3_nonclustered';

/* Show indexes */
/*SHOW INDEXES FROM test.bigint_t3_nonclustered\G*/
/* Show regions */
SHOW TABLE test.bigint_t3_nonclustered regions\G

/* Compare TiKV Regions Count */
select * from 
(select count(region_id) as "Clustered # of Regions" from information_schema.tikv_region_status where table_name='auto_increment_t2_clustered') v1
join
(select count(region_id) as "Non-Clustered # of Regions" from information_schema.tikv_region_status where table_name='bigint_t3_nonclustered') v2;

/* Compare the Physical Plans */
select 'SELECT varname FROM test.auto_increment_t2_clustered WHERE id between 10 and 100;' as "Clustered";
EXPLAIN SELECT varname FROM test.auto_increment_t2_clustered WHERE id between 10 and 100;
select 'SELECT varname FROM test.bigint_t3_nonclustered WHERE id between 10 and 100;' as "Non-Clustered";
EXPLAIN SELECT varname FROM test.bigint_t3_nonclustered WHERE id between 10 and 100;