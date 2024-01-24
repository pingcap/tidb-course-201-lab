/* source 07-demo-tiflash-olap-01-show.sql */
/* Reset */
SET @@tidb_isolation_read_engines = 'tikv,tiflash,tidb';
ALTER TABLE test.t2_nonclustered
SET TIFLASH REPLICA 0;
ALTER TABLE test.t5_nonclustered
SET TIFLASH REPLICA 0;
/* WHERE for analysis */
SELECT COUNT(*)
FROM test.t5_nonclustered;
SELECT COUNT(*)
FROM test.t2_nonclustered;
/* OLAP Style Query on t2 and t5 */
SELECT AVG(t5.id),
  AVG(t5.id2),
  t2.varname,
  COUNT(*) AS cnt
FROM test.t5_nonclustered as t5
  JOIN test.t2_nonclustered as t2 ON t5.id = t2.id
WHERE t5.id < t2.id2
GROUP BY t2.varname
ORDER BY cnt;
/* OLAP Style Query on t2 and t5 */
EXPLAIN
SELECT AVG(t5.id),
  AVG(t5.id2),
  t2.varname,
  COUNT(*) AS cnt
FROM test.t5_nonclustered as t5
  JOIN test.t2_nonclustered as t2 ON t5.id = t2.id
WHERE t5.id < t2.id2
GROUP BY t2.varname
ORDER BY cnt;
/* Enable TiFlash Raft Learner for t2 and t5 */
ALTER TABLE test.t2_nonclustered
SET TIFLASH REPLICA 1;
ALTER TABLE test.t5_nonclustered
SET TIFLASH REPLICA 1;
/* Wait for the data to be populated to TiFlash` */
SELECT SLEEP(20);
/* Check TiFlash Status */
SELECT *
FROM information_schema.TIFLASH_REPLICA;
/* OLAP Style Query on t2 and t5 */
SELECT avg(t5.id),
  t5.id2,
  count(*)
FROM test.t5_nonclustered t5
  JOIN test.t2_nonclustered t2 ON t5.id = t2.id
WHERE t5.id < t2.id2
GROUP BY id2
ORDER BY id2;
/* Explain */
EXPLAIN
SELECT avg(t5.id),
  t5.id2,
  count(*)
FROM test.t5_nonclustered t5
  JOIN test.t2_nonclustered t2 ON t5.id = t2.id
WHERE t5.id < t2.id2
GROUP BY id2
ORDER BY id2;
/* Turn off TiFlash for session */
select @@tidb_isolation_read_engines;
set @@tidb_isolation_read_engines = 'tikv,tidb';
/* OLAP Style Query on t2 and t5 */
SELECT avg(t5.id),
  t5.id2,
  count(*)
FROM test.t5_nonclustered t5
  JOIN test.t2_nonclustered t2 ON t5.id = t2.id
WHERE t5.id < t2.id2
GROUP BY id2
ORDER BY id2;