/* source 11-demo-table-01-setup.sql */
/* Setup the schema for CLUSTERED vs. NONCLUSTERED primary keys */
/* Table t1: Clustered */
DROP TABLE IF EXISTS test.auto_random_t1_clustered;
CREATE TABLE test.auto_random_t1_clustered (
    id BIGINT PRIMARY KEY AUTO_RANDOM,
    id2 BIGINT,
    name CHAR(255),
    varname VARCHAR(200)
);
/* Table t2: Non-Clustered */
DROP TABLE IF EXISTS test.t2_nonclustered;
CREATE TABLE test.t2_nonclustered (
    id BIGINT PRIMARY KEY NONCLUSTERED,
    id2 BIGINT,
    name CHAR(255),
    varname CHAR(200)
);
/* Table t5: Clustered with no primary key */
DROP TABLE IF EXISTS test.t5_nonclustered;
CREATE TABLE test.t5_nonclustered (
    id BIGINT,
    id2 BIGINT,
    name CHAR(255),
    varname CHAR(200)
);
/* Populate Seed */
INSERT INTO test.auto_random_t1_clustered (name, varname)
VALUES ('A', 'V1'),
    ('B', 'V1'),
    ('C', 'V2'),
    ('D', 'V2');
UPDATE test.auto_random_t1_clustered
SET id2 = id;
/* Flooding with data 2M rows to t1 */
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
INSERT INTO test.auto_random_t1_clustered
select null,
    id2,
    name,
    varname
from test.auto_random_t1_clustered;
/* Flooding with data 2M rows to t2 */
INSERT INTO test.t2_nonclustered
select *
from test.auto_random_t1_clustered
where name = 'A';
INSERT INTO test.t2_nonclustered
select *
from test.auto_random_t1_clustered
where name = 'B';
INSERT INTO test.t2_nonclustered
select *
from test.auto_random_t1_clustered
where name = 'C';
INSERT INTO test.t2_nonclustered
select *
from test.auto_random_t1_clustered
where name = 'D';
/* Flooding with data 2M rows to t5 */
INSERT INTO test.t5_nonclustered
select *
from test.t2_nonclustered
where name = 'A';
INSERT INTO test.t5_nonclustered
select *
from test.t2_nonclustered
where name = 'B';
INSERT INTO test.t5_nonclustered
select *
from test.t2_nonclustered
where name = 'C';
INSERT INTO test.t5_nonclustered
select *
from test.t2_nonclustered
where name = 'D';