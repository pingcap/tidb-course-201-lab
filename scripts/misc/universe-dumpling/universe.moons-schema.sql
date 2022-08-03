/*!40101 SET NAMES binary*/;
CREATE TABLE `moons` (
  `id` bigint(20) NOT NULL /*T![auto_rand] AUTO_RANDOM(5) */,
  `name` char(20) NOT NULL,
  `alias` char(20) NOT NULL,
  `mass` float DEFAULT NULL COMMENT '10**24 kg',
  `diameter` decimal(12,2) NOT NULL DEFAULT '0' COMMENT 'km',
  `planet_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */,
  KEY `name` (`name`),
  KEY `alias` (`alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin /*T![auto_rand_base] AUTO_RANDOM_BASE=143142 */;
