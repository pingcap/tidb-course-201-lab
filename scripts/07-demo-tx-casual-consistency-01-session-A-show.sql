/* source 07-demo-tx-casual-consistency-01-session-A-show.sql */

/* Pre-requisites: show be all on */
select @@tidb_enable_async_commit;
select @@tidb_enable_1pc;

/* Pessmistic locks help causal consistency to ensure the tx order */

drop table if exists test.tc;
create table test.tc(id int, name char(10));
insert into test.tc values(1, 'A');

start transaction with causal consistency only;
update test.tc set name='B' where id=1;

