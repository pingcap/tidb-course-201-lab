/* source 07-demo-partition-hash-01-show.sql */

/* Hash Partition t1 */
drop table if exists test.t1;
CREATE TABLE test.t1 (x INT)
    PARTITION BY HASH(x)
    PARTITIONS 4;

insert into test.t1 values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;
insert into test.t1 select * from test.t1;


/* Check Partition Distribution */
explain select * from test.t1 where x=0;
explain select * from test.t1 where x=1;
explain select * from test.t1 where x=2;
explain select * from test.t1 where x=3;
explain select * from test.t1 where x=4;
explain select * from test.t1 where x=5;
explain select * from test.t1 where x=6;
explain select * from test.t1 where x=7;
explain select * from test.t1 where x=8;
explain select * from test.t1 where x=9;

/* Negative */
explain select * from test.t1 where x between 7 and 9;

/* Check regions */
show table test.t1 regions;
