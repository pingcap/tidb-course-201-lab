/* source 07-demo-online-ddl-add-column-01-setup.sql */

/* target_table(id, name1) */
drop table if exists test.target_table;
create table test.target_table(
  id bigint primary key auto_random,
  name1 char(20)
  );

/* Seed */
drop table if exists test.seed;
create table test.seed(name char(20));
insert into test.seed (name) values ('BEFORE-DDL'),('BEFORE-DDL'),('BEFORE-DDL'),('BEFORE-DDL'),('BEFORE-DDL');
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
insert into test.seed select * from test.seed;
DESC test.target_table;
