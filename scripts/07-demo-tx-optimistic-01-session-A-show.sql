/* source 07-demo-tx-optimistic-01-session-A-show.sql */

set @@tidb_txn_mode='optimistic';

drop table if exists test.tc;
create table test.tc(id int, name char(10));
insert into test.tc values(1, 'O');

start transaction with causal consistency only;
update test.tc set name='A' where id=1;

