/* source 07-demo-placement-rule-classroom81-hot-cold.sql */

/* This script is designed for 201.3 training Exercise 8-1 */

/* Setup: Make sure the TiKV region replica count is 3 */
SET CONFIG PD replication.max-replicas = 3;

/* Query 1: Show available labels */
SHOW PLACEMENT LABELS;

/* Query 2: Show TiKV stores and their labels */
SELECT store_id, address, store_state_name, label
FROM information_schema.tikv_store_status
WHERE label NOT LIKE '%tiflash%';

/* Create the placement policy for hot data, map them to label KV(storage-performance, high) */
DROP PLACEMENT POLICY IF EXISTS hot;
CREATE PLACEMENT POLICY hot
  CONSTRAINTS="[+storage-performance=high]";

/* Create the placement policy for cold data, map them to label KV(storage-performance, low) */
DROP PLACEMENT POLICY IF EXISTS cold;
CREATE PLACEMENT POLICY cold
  CONSTRAINTS="[+storage-performance=low]";

/* Query 3: Show the definition of created placement policies */
SELECT policy_name, constraints FROM information_schema.placement_policies;

/* Create a partitioned table */
DROP TABLE IF EXISTS test.orders;
CREATE TABLE test.orders (order_id INT, item VARCHAR(50), order_date DATE, PRIMARY KEY (order_date, order_id))
PARTITION BY RANGE( YEAR(order_date) ) (
  PARTITION p10 VALUES LESS THAN (2010) PLACEMENT POLICY=cold,
  PARTITION p15 VALUES LESS THAN (2015) PLACEMENT POLICY=cold,
  PARTITION pm VALUES LESS THAN MAXVALUE PLACEMENT POLICY=hot
);

/* Create a partitioned table*/
DROP TABLE IF EXISTS test.orders_log;
CREATE TABLE test.orders_log (order_id INT, item VARCHAR(50), order_date DATE, PRIMARY KEY (order_date, order_id))
PARTITION BY RANGE( YEAR(order_date) ) (
  PARTITION p10 VALUES LESS THAN (2010) PLACEMENT POLICY=cold,
  PARTITION p15 VALUES LESS THAN (2015) PLACEMENT POLICY=cold,
  PARTITION pm VALUES LESS THAN MAXVALUE PLACEMENT POLICY=cold
);

/* Query 4: Show relevant information about table test.order */
SHOW TABLE test.orders REGIONS\G

SELECT kvrs.region_id, kvss.store_id, kvrp.is_leader, kvss.label, kvss.start_ts
  FROM information_schema.tikv_region_status kvrs
  JOIN information_schema.tikv_region_peers kvrp
  ON kvrs.region_id = kvrp.region_id
  JOIN information_schema.tikv_store_status kvss
  ON kvrp.store_id = kvss.store_id
  JOIN information_schema.tables t
  ON t.table_name = kvrs.table_name
  WHERE t.table_schema='test' 
  AND t.table_name='orders'
  AND kvrs.is_index = 0
  AND kvrp.is_leader = 1;

/* Query 5: Show relevant information about table test.order2 */
SHOW TABLE test.orders_log REGIONS\G

SELECT kvrs.region_id, kvss.store_id, kvrp.is_leader, kvss.label, kvss.start_ts
  FROM information_schema.tikv_region_status kvrs
  JOIN information_schema.tikv_region_peers kvrp
  ON kvrs.region_id = kvrp.region_id
  JOIN information_schema.tikv_store_status kvss
  ON kvrp.store_id = kvss.store_id
  JOIN information_schema.tables t
  ON t.table_name = kvrs.table_name
  WHERE t.table_schema='test' 
  AND t.table_name='orders_log'
  AND kvrs.is_index = 0
  AND kvrp.is_leader = 1;

/* Query 6: Run a trace to verify the partition pruning effect, scan on cold storage is expected, because you are querying data between 2010 and 2015 */
TRACE
SELECT item, order_date FROM test.orders
WHERE order_date BETWEEN STR_TO_DATE('01/01/2013', '%m/%d/%Y') AND STR_TO_DATE('12/31/2013', '%m/%d/%Y');

/* Query 7: Run a trace to verify the partition pruning effect, scan on hot storage is expected, because you are querying data later than 2015 */
TRACE
SELECT item, order_date FROM test.orders
WHERE order_date BETWEEN STR_TO_DATE('01/01/2018', '%m/%d/%Y') AND STR_TO_DATE('12/31/2020', '%m/%d/%Y');
