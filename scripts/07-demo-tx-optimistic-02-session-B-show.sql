/* source 07-demo-tx-optimistic-02-session-B-show.sql */

set @@tidb_txn_mode='optimistic';

start transaction with causal consistency only;
update test.tc set name='B' where id=1;

