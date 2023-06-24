/* source 07-demo-auto-increment-02-show.sql */
/* Populate test.t1 */
INSERT INTO test.t1 (from_port)
VALUES ('4000');
INSERT INTO test.t1 (from_port)
VALUES ('4000');
INSERT INTO test.t1 (from_port)
VALUES ('4000');
INSERT INTO test.t1 (from_port)
VALUES ('4000');
/* Query 1: Check */
SELECT id,
  from_port
FROM test.t1;