/* source 07-demo-tiflash-olap-01-setup.sql */

/* OLAP Style Query on t2 and t5 */
SELECT avg(t5.id), t5.id2, count(*) 
FROM test.t5_nonclustered t5 JOIN test.t2_nonclustered t2
ON t5.id = t2.id
WHERE t5.id > t5.id2
GROUP BY id2
ORDER BY id2;

/* Enable TiFlash Raft Learner for t2 and t5 */
ALTER TABLE test.t2_nonclustered SET TIFLASH REPLICA 1;
ALTER TABLE test.t5_nonclustered SET TIFLASH REPLICA 1;

/* OLAP Style Query on t2 and t5 */
SELECT avg(t5.id), t5.id2, count(*) 
FROM test.t5_nonclustered t5 JOIN test.t2_nonclustered t2
ON t5.id = t2.id
WHERE t5.id > t5.id2
GROUP BY id2
ORDER BY id2;

/* Turn off TiFlash for sesion */
set @@tidb_isolation_read_engines='tikv,tidb';

/* OLAP Style Query on t2 and t5 */
SELECT avg(t5.id), t5.id2, count(*) 
FROM test.t5_nonclustered t5 JOIN test.t2_nonclustered t2
ON t5.id = t2.id
WHERE t5.id > t5.id2
GROUP BY id2
ORDER BY id2;

