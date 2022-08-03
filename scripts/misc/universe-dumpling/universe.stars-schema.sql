/*!40101 SET NAMES binary*/;
CREATE TABLE `stars` (
  `id` bigint(20) NOT NULL /*T![auto_rand] AUTO_RANDOM(5) */,
  `name` char(20) NOT NULL DEFAULT '',
  `mass` float NOT NULL DEFAULT '0.0' COMMENT '10**24 kg',
  `density` int(11) NOT NULL DEFAULT '0' COMMENT 'kg/m**3',
  `gravity` decimal(20,4) NOT NULL DEFAULT '0.0' COMMENT 'm/s**2',
  `escape_velocity` decimal(8,1) DEFAULT NULL COMMENT 'km/s',
  `mass_conversion_rate` int(11) DEFAULT NULL COMMENT '10**6 kg/s',
  `spectral_type` char(8) NOT NULL DEFAULT '',
  `distance_from_earth` float DEFAULT NULL COMMENT 'light year',
  `discover_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) /*T![clustered_index] CLUSTERED */,
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin /*T![auto_rand_base] AUTO_RANDOM_BASE=56041 */;
