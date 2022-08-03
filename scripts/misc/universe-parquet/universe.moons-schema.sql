CREATE TABLE `moons` (
	`id` bigint AUTO_RANDOM,
	`name` char(20) NOT NULL,
	`alias` char(20) NOT NULL,
	`mass` float COMMENT '10**24 kg',
	`diameter` decimal(12,2) NOT NULL DEFAULT 0 COMMENT 'km',
	`planet_id` bigint NOT NULL,
 	PRIMARY KEY (`id`),
	KEY (`name`),
	KEY (`alias`)
);
