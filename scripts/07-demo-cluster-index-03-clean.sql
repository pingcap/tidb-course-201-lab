/* source 07-demo-cluster-index-03-clean.sql */

/* Clean the schema for CLUSTERED vs. NONCLUSTERED primary keys */

/* Table 1 Clustered */
DROP TABLE IF EXISTS test.auto_random_t1_clustered;

/* Table 2 Nonclustered */
DROP TABLE IF EXISTS test.t2_nonclustered;

/* Table 3 Nonclustered */
DROP TABLE IF EXISTS test.t3_nonclustered;

/* Table 4 Clustered */
DROP TABLE IF EXISTS test.t4_clustered;

/* Table 5 Nonclustered */
DROP TABLE IF EXISTS test.t5_nonclustered;

/* Table 6 */
DROP TABLE IF EXISTS test.t6_nonclustered;

/* Table 7 */
DROP TABLE IF EXISTS test.t7_clustered;

