/* source 07-demo-online-ddl-add-column-01-setup.sql */

/* target_table(id, name1) */
DROP TABLE IF EXISTS test.target_table;
CREATE TABLE test.target_table(
  id bigint PRIMARY KEY AUTO_RANDOM,
  name1 char(20));

/* Seed */
DROP TABLE IF EXISTS test.seed;
CREATE TABLE test.seed(name char(20));

insert into test.seed (name) values ('BEFORE-DDL'),('BEFORE-DDL'),('BEFORE-DDL'),('BEFORE-DDL'),('BEFORE-DDL');
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
select count(*) as "|320|" from test.seed;

DESC test.target_table;
