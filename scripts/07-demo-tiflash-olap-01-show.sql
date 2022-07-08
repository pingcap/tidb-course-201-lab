/* source 07-demo-tiflash-olap-01-show.sql */

/* Reset */
set @@tidb_isolation_read_engines='tikv,tiflash,tidb';
ALTER TABLE test.t2_nonclustered SET TIFLASH REPLICA 0;
ALTER TABLE test.t5_nonclustered SET TIFLASH REPLICA 0;

/* WHERE for analysis */

SELECT COUNT(*) FROM test.t5_nonclustered;
SELECT COUNT(*) FROM test.t2_nonclustered;

/* OLAP Style Query on t2 and t5 */
SELECT avg(t5.id), t5.id2, count(*) 
FROM test.t5_nonclustered t5 JOIN test.t2_nonclustered t2
ON t5.id = t2.id
WHERE t5.id < t2.id2
GROUP BY id2
ORDER BY id2;

/* Enable TiFlash Raft Learner for t2 and t5 */
ALTER TABLE test.t2_nonclustered SET TIFLASH REPLICA 1;
ALTER TABLE test.t5_nonclustered SET TIFLASH REPLICA 1;

/* OLAP Style Query on t2 and t5 */
SELECT avg(t5.id), t5.id2, count(*) 
FROM test.t5_nonclustered t5 JOIN test.t2_nonclustered t2
ON t5.id = t2.id
WHERE t5.id < t2.id2
GROUP BY id2
ORDER BY id2;

/* Explain */
EXPLAIN SELECT avg(t5.id), t5.id2, count(*) 
FROM test.t5_nonclustered t5 JOIN test.t2_nonclustered t2
ON t5.id = t2.id
WHERE t5.id < t2.id2
GROUP BY id2
ORDER BY id2;

/* Turn off TiFlash for sesion */
select @@tidb_isolation_read_engines;
set @@tidb_isolation_read_engines='tikv,tidb';

/* OLAP Style Query on t2 and t5 */
SELECT avg(t5.id), t5.id2, count(*) 
FROM test.t5_nonclustered t5 JOIN test.t2_nonclustered t2
ON t5.id = t2.id
WHERE t5.id < t2.id2
GROUP BY id2
ORDER BY id2;

