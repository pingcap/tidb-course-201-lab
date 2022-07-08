/* source 07-demo-cluster-index-01-setup.sql */
/* Setup the schema for CLUSTERED vs. NONCLUSTERED primary keys */

/* Table t1 Clustered */
DROP TABLE IF EXISTS test.auto_random_t1_clustered;
CREATE TABLE test.auto_random_t1_clustered (
    id bigint PRIMARY KEY AUTO_RANDOM,
    id2 bigint, 
    name char(255),
    varname varchar(200));

/* Table t2 Non-Clustered */
DROP TABLE IF EXISTS test.t2_nonclustered;
CREATE TABLE test.t2_nonclustered (
    id bigint PRIMARY KEY NONCLUSTERED, 
    id2 bigint,
    name char(255),
    varname char(200));

/* Table t3 Non-Clustered */
DROP TABLE IF EXISTS test.t3_nonclustered;
CREATE TABLE test.t3_nonclustered (
    id varchar(32) PRIMARY KEY, 
    id2 bigint,
    name char(255),
    varname char(200));

/* Table t4 Clustered */
DROP TABLE IF EXISTS test.t4_clustered;
CREATE TABLE test.t4_clustered (
    id varchar(32) PRIMARY KEY CLUSTERED, 
    id2 bigint,
    name char(255),
    varname char(200));

/* Table t5 Clustered with no primary key */
DROP TABLE IF EXISTS test.t5_nonclustered;
CREATE TABLE test.t5_nonclustered (
    id bigint, 
    id2 bigint,
    name char(255),
    varname char(200));

/* Table t6 Non-Clustered Composite PK */
DROP TABLE IF EXISTS test.t6_nonclustered;
CREATE TABLE test.t6_nonclustered (
    id bigint, 
    id2 bigint,
    name char(255),
    varname char(200),
    PRIMARY KEY (id, id2));

/* Table t7 Clustered Composite PK */
DROP TABLE IF EXISTS test.t7_clustered;
CREATE TABLE test.t7_clustered (
    id bigint, 
    id2 bigint,
    name char(255),
    varname char(200),
    PRIMARY KEY (id, id2) CLUSTERED);

/* Populate Seed */
INSERT INTO test.auto_random_t1_clustered (name, varname) VALUES ('A','V1'), ('B','V1'), ('C','V2'), ('D','V2');
UPDATE test.auto_random_t1_clustered SET id2=id;

/* Flooding with data 2M rows to t1 */
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered select null, id2, name, varname from test.auto_random_t1_clustered;

/* Flooding with data 2M rows t0 t2 */
INSERT INTO test.t2_nonclustered select * from test.auto_random_t1_clustered where name = 'A';
INSERT INTO test.t2_nonclustered select * from test.auto_random_t1_clustered where name = 'B';
INSERT INTO test.t2_nonclustered select * from test.auto_random_t1_clustered where name = 'C';
INSERT INTO test.t2_nonclustered select * from test.auto_random_t1_clustered where name = 'D';

/* Flooding with data 2M rows to t3 */
INSERT INTO test.t3_nonclustered select * from test.auto_random_t1_clustered where name = 'A';
INSERT INTO test.t3_nonclustered select * from test.auto_random_t1_clustered where name = 'B';
INSERT INTO test.t3_nonclustered select * from test.auto_random_t1_clustered where name = 'C';
INSERT INTO test.t3_nonclustered select * from test.auto_random_t1_clustered where name = 'D';

/* Flooding with data 2M rows to t4 */
INSERT INTO test.t4_clustered select * from test.auto_random_t1_clustered where name = 'A';
INSERT INTO test.t4_clustered select * from test.auto_random_t1_clustered where name = 'B';
INSERT INTO test.t4_clustered select * from test.auto_random_t1_clustered where name = 'C';
INSERT INTO test.t4_clustered select * from test.auto_random_t1_clustered where name = 'D';


/* Flooding with data 2M rows to t5 */
INSERT INTO test.t5_nonclustered select * from test.auto_random_t1_clustered where name = 'A';
INSERT INTO test.t5_nonclustered select * from test.auto_random_t1_clustered where name = 'B';
INSERT INTO test.t5_nonclustered select * from test.auto_random_t1_clustered where name = 'C';
INSERT INTO test.t5_nonclustered select * from test.auto_random_t1_clustered where name = 'D';

/* Flooding with data 2M rows to t6_nonclustered */
INSERT INTO test.t6_nonclustered select * from test.auto_random_t1_clustered where name = 'A';
INSERT INTO test.t6_nonclustered select * from test.auto_random_t1_clustered where name = 'B';
INSERT INTO test.t6_nonclustered select * from test.auto_random_t1_clustered where name = 'C';
INSERT INTO test.t6_nonclustered select * from test.auto_random_t1_clustered where name = 'D';

/* Flooding with data 2M rows to t7_clustered */
INSERT INTO test.t7_clustered select * from test.auto_random_t1_clustered where name = 'A';
INSERT INTO test.t7_clustered select * from test.auto_random_t1_clustered where name = 'B';
INSERT INTO test.t7_clustered select * from test.auto_random_t1_clustered where name = 'C';
INSERT INTO test.t7_clustered select * from test.auto_random_t1_clustered where name = 'D';

/* Greetings to CBO */
ANALYZE table test.auto_random_t1_clustered;
ANALYZE table test.t2_nonclustered;
ANALYZE table test.t3_nonclustered;
ANALYZE table test.t4_clustered;
ANALYZE table test.t5_nonclustered;
ANALYZE table test.t6_nonclustered;
ANALYZE table test.t7_clustered;

select 'Table test.auto_random_t1_clustered created/populated' as Result;
/* Data */
select count(distinct id), count(distinct name), count(*), min(id), max(id) from test.auto_random_t1_clustered;
/* Show information_schema for table */
select 'Table test.auto_random_t1_clustered' as Information_Schema;
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='auto_random_t1_clustered';

select 'Table test.t2_nonclustered created/populated' as Result;
/* Data */
select count(distinct id), count(distinct name), count(*), min(id), max(id) from test.t2_nonclustered;
/* Show information_schema for table */
select 'Table test.t2_nonclustered' as Information_Schema;
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='t2_nonclustered';

select 'Table test.t3_nonclustered created/populated' as Result;
/* Data */
select count(distinct id), count(distinct name), count(*), min(id), max(id) from test.t3_nonclustered;
/* Show information_schema for table */
select 'Table test.t3_nonclustered' as Information_Schema;
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='t3_nonclustered';

select 'Table test.t4_clustered created/populated' as Result;
/* Data */
select count(distinct id), count(distinct name), count(*), min(id), max(id) from test.t4_clustered;
/* Show information_schema for table */
select 'Table test.t4_clustered' as Information_Schema;
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='t4_clustered';

select 'Table test.t5_nonclustered created/populated' as Result;
/* Data */
select count(distinct id), count(distinct name), count(*), min(id), max(id) from test.t5_nonclustered;
/* Show information_schema for table */
select 'Table test.t5_nonclustered' as Information_Schema;
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='t5_nonclustered';

select 'Table test.t6_nonclustered created/populated' as Result;
/* Data */
select count(distinct id), count(distinct name), count(*), min(id), max(id) from test.t6_nonclustered;
/* Show information_schema for table */
select 'Table test.t6_nonclustered' as Information_Schema;
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='t6_nonclustered';

select 'Table test.t7_clustered created/populated' as Result;
/* Data */
select count(distinct id), count(distinct name), count(*), min(id), max(id) from test.t7_clustered;
/* Show information_schema for table */
select 'Table test.t7_clustered' as Information_Schema;
SELECT tidb_row_id_sharding_info, tidb_pk_type 
FROM information_schema.tables 
WHERE table_name='t7_clustered';
