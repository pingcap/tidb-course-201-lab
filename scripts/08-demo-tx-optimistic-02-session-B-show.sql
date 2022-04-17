/* source 07-demo-tx-optimistic-02-session-B-show.sql */

set @@tidb_txn_mode='optimistic';

begin;
update test.tc set name='B' where id=1;

