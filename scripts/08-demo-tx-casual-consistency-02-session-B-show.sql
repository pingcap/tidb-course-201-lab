/* source 07-demo-tx-casual-consistency-02-session-B-show.sql */

/* Pre-requisites: show be all on */
select @@tidb_enable_async_commit;
select @@tidb_enable_1pc;

/* Pessmistic locks help causal consistency to ensure the tx order */

start transaction with causal consistency only;
update test.tc set name='C' where id=1;

