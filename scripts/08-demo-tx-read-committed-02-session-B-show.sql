/* source 08-demo-tx-read-committed-02-session-B-show.sql */

SET @@transaction_isolation='read-committed';

BEGIN;
SELECT * FROM test.t1;
