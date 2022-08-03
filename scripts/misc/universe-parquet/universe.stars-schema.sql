CREATE TABLE `stars` (
  `id` bigint AUTO_RANDOM,
  `name` char(20) NOT NULL DEFAULT '',
  `mass` float NOT NULL DEFAULT 0.0 COMMENT '10**24 kg',
	`density` int NOT NULL DEFAULT 0 COMMENT 'kg/m**3',
	`gravity` decimal(20,4) NOT NULL DEFAULT 0.0 COMMENT 'm/s**2',
	`escape_velocity` decimal(8,1) DEFAULT NULL COMMENT 'km/s',
	`mass_conversion_rate` int DEFAULT NULL COMMENT '10**6 kg/s',
	`spectral_type` char(8) NOT NULL DEFAULT '',
	`distance_from_earth` float COMMENT 'light year',
	`discover_date` datetime DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY (`name`)
);
