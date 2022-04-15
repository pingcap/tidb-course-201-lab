/* source 07-demo-auto-increment-01-show.sql */

show variables like 'auto_increment_%';
show variables like 'tidb_allow_remove_auto_inc';

/* Setup the schema for attribute AUTO_INCREMENT */
DROP TABLE IF EXISTS test.t1;
CREATE TABLE test.t1 (
    id int PRIMARY KEY AUTO_INCREMENT, 
    name char(4));

DROP TABLE IF EXISTS test.t2;
CREATE TABLE test.t2 (
    id int PRIMARY KEY AUTO_INCREMENT, 
    name char(4))
    AUTO_ID_CACHE 300;

/* Populate */
INSERT INTO test.t1 (name) VALUES ('A'), ('B'), ('C'), ('D'), ('E');

/* Check value */
select id, name from test.t1;

/* Explictly assign value to auto_incremental column */
insert into test.t1 values (7, 'G');
/* Check value */
select id, name from test.t1;

/* Relying on auto_incremental values */
insert into test.t1 (name) values ('F');
insert into test.t1 (name) values ('H');
/* Check value */
select id, name from test.t1;
