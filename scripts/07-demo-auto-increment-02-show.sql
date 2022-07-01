/* source 07-demo-auto-increment-02-show.sql */

/* Populate */
INSERT INTO test.t1 (from_port) VALUES ('4000'), ('4000'), ('4000');

/* Check value */
select id, from_port from test.t1;

/* Explictly assign value "7" to auto_increment column */
insert into test.t1 values (7, '4000');
/* Check value */
select id, from_port from test.t1;

/* Relying on auto_increment values to assign values to new rows */
insert into test.t1 (from_port) values ('4000');
insert into test.t1 (from_port) values ('4000');
/* Check value */
select id, from_port from test.t1;
