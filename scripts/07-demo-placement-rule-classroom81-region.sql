/* source 07-demo-placement-rule-classroom81-region.sql */
/* This script is designed for 201.3 training Exercise 8-2 */
/* Query 1: Show available labels */
SHOW PLACEMENT LABELS;
/* Query 2: Show TiKV stores and their labels */
SELECT store_id,
  address,
  store_state_name,
  label
FROM information_schema.tikv_store_status
WHERE label NOT LIKE '%tiflash%';
/* Create the geo-location placement policy favor for seattle */
DROP PLACEMENT POLICY IF EXISTS seattle;
CREATE PLACEMENT POLICY seattle PRIMARY_REGION = "seattle" REGIONS = "seattle,tokyo" FOLLOWERS = 2;
/* Create the geo-location placement policy favor for tokyo */
DROP PLACEMENT POLICY IF EXISTS tokyo;
CREATE PLACEMENT POLICY tokyo PRIMARY_REGION = "tokyo" REGIONS = "tokyo,seattle" FOLLOWERS = 2;
/* Query 3: Show the definition of created placement policies */
SELECT policy_name,
  primary_region,
  regions
FROM information_schema.placement_policies
ORDER BY primary_region;
/* Create a table using `seattle` placement policy */
DROP TABLE IF EXISTS test.orders_seattle;
CREATE TABLE test.orders_seattle (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  item VARCHAR(50),
  order_date DATE
) PLACEMENT POLICY = seattle;
/* Create a table using `tokyo` placement policy */
DROP TABLE IF EXISTS test.orders_tokyo;
CREATE TABLE test.orders_tokyo (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  item VARCHAR(50),
  order_date DATE
) PLACEMENT POLICY = tokyo;
/* Query 4: Show relevant information about table test.orders_seattle */
SHOW TABLE test.orders_seattle REGIONS \ G
SELECT kvrs.region_id,
  kvss.store_id,
  kvrp.is_leader,
  kvss.label,
  kvss.start_ts
FROM information_schema.tikv_region_status kvrs
  JOIN information_schema.tikv_region_peers kvrp ON kvrs.region_id = kvrp.region_id
  JOIN information_schema.tikv_store_status kvss ON kvrp.store_id = kvss.store_id
  JOIN information_schema.tables t ON t.table_name = kvrs.table_name
WHERE t.table_schema = 'test'
  AND t.table_name = 'orders_seattle'
  AND kvrs.is_index = 0
  AND kvrp.is_leader = 1;
/* Query 5: Show relevant information about table test.order2 */
SHOW TABLE test.orders_tokyo REGIONS \ G
SELECT kvrs.region_id,
  kvss.store_id,
  kvrp.is_leader,
  kvss.label,
  kvss.start_ts
FROM information_schema.tikv_region_status kvrs
  JOIN information_schema.tikv_region_peers kvrp ON kvrs.region_id = kvrp.region_id
  JOIN information_schema.tikv_store_status kvss ON kvrp.store_id = kvss.store_id
  JOIN information_schema.tables t ON t.table_name = kvrs.table_name
WHERE t.table_schema = 'test'
  AND t.table_name = 'orders_tokyo'
  AND kvrs.is_index = 0
  AND kvrp.is_leader = 1;