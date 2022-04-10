/* source 07-demo-partition-range-01-show.sql */

/* Range Partition t1 */
drop table if exists test.t1;
create table test.t1 (x int) partition by range (x) (
    partition p0 values less than (5),
    partition p1 values less than (10));

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


/* Check Partition Pruning */
explain select * from test.t1 where x between 1 and 4;

