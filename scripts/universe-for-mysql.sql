/* 
 *	Sample schema for planets and stars in the universe. No warranty of data correctness. 
 *	It should not be used in any circumstances outside PingCAP training courses. 
 *	Data source: Space research open data set all over the world.
 *	Contributors: 
 *		guanglei.bao@pingcap.com
 */
SET AUTOCOMMIT = 1;
DROP DATABASE IF EXISTS `universe`;
CREATE DATABASE `universe` DEFAULT CHARACTER SET utf8mb4;
USE `universe`;
DROP TABLE IF EXISTS `stars`;
CREATE TABLE `stars` (
	`id` bigint AUTO_INCREMENT,
	`name` char(20) NOT NULL DEFAULT '',
	`mass` float NOT NULL DEFAULT 0.0 COMMENT '10**24 kg',
	`density` int NOT NULL DEFAULT 0 COMMENT 'kg/m**3',
	`gravity` decimal(20, 4) NOT NULL DEFAULT 0.0 COMMENT 'm/s**2',
	`escape_velocity` decimal(8, 1) DEFAULT NULL COMMENT 'km/s',
	`mass_conversion_rate` int DEFAULT NULL COMMENT '10**6 kg/s',
	`spectral_type` char(8) NOT NULL DEFAULT '',
	`distance_from_earth` float COMMENT 'light year',
	`discover_date` datetime DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY (`name`)
);
DROP TABLE IF EXISTS `planet_categories`;
CREATE TABLE `planet_categories` (
	`id` int AUTO_INCREMENT,
	`name` char(20) NOT NULL,
	PRIMARY KEY (`id`),
	KEY (`name`)
);
DROP TABLE IF EXISTS `planets`;
CREATE TABLE `planets` (
	`id` bigint AUTO_INCREMENT,
	`name` char(20) NOT NULL DEFAULT '',
	`mass` float NOT NULL DEFAULT 0.0 COMMENT '10**24 kg',
	`diameter` decimal(12, 2) NOT NULL DEFAULT 0 COMMENT 'km',
	`density` int NOT NULL DEFAULT 0 COMMENT 'kg/m**3',
	`gravity` decimal(8, 1) NOT NULL DEFAULT 0.0 COMMENT 'm/s**2',
	`escape_velocity` decimal(8, 1) NOT NULL DEFAULT 0.0 COMMENT 'km/s',
	`rotation_period` decimal(5, 1) NOT NULL DEFAULT 0.0 COMMENT 'hours',
	`length_of_day` decimal(8, 1) NOT NULL DEFAULT 0.0 COMMENT 'hours',
	`distance_from_sun` float NOT NULL DEFAULT 0.0 COMMENT '10**6 km',
	`perihelion` float DEFAULT NULL COMMENT '10**6 km',
	`aphelion` float DEFAULT NULL COMMENT '10**6 km',
	`orbital_period` decimal(12, 1) NOT NULL DEFAULT 0.0 COMMENT 'days',
	`orbital_velocity` decimal(12, 1) DEFAULT NULL COMMENT 'km/s',
	`orbital_inclination` decimal(8, 1) DEFAULT NULL COMMENT 'degrees',
	`orbital_eccentricity` decimal(7, 0) NOT NULL DEFAULT 0.0,
	`obliquity_to_orbit` decimal(10, 4) DEFAULT NULL COMMENT 'degrees',
	`mean_temperature` int NOT NULL DEFAULT 0 COMMENT 'C',
	`surface_pressure` float DEFAULT NULL COMMENT 'bars',
	`ring_systems` boolean NOT NULL DEFAULT 0,
	`global_magnetic_field` boolean DEFAULT 0,
	`sun_id` bigint NOT NULL,
	`category_id` int NOT NULL,
	`discover_date` datetime DEFAULT NULL,
	PRIMARY KEY (`id`),
	KEY (`name`),
	CONSTRAINT `planet_sun_fk` FOREIGN KEY (`sun_id`) REFERENCES `stars` (`id`),
	CONSTRAINT `planet_cat_fk` FOREIGN KEY (`category_id`) REFERENCES `planet_categories` (`id`)
);
DROP TABLE IF EXISTS `moons`;
CREATE TABLE `moons` (
	`id` bigint AUTO_INCREMENT,
	`name` char(20) NOT NULL,
	`alias` char(20) NOT NULL,
	`mass` float COMMENT '10**24 kg',
	`diameter` decimal(12, 2) NOT NULL DEFAULT 0 COMMENT 'km',
	`planet_id` bigint NOT NULL,
	PRIMARY KEY (`id`),
	KEY (`name`),
	KEY (`alias`)
);
INSERT INTO `stars` (
		name,
		mass,
		density,
		gravity,
		escape_velocity,
		mass_conversion_rate,
		spectral_type,
		distance_from_earth,
		discover_date
	)
VALUES (
		'Sun',
		1988500,
		1408,
		274.0,
		617.6,
		4260,
		'G2 V',
		0.0000158,
		NULL
	);
SET @SUN_ID = LAST_INSERT_ID();
INSERT INTO `stars` (
		name,
		mass,
		density,
		gravity,
		escape_velocity,
		mass_conversion_rate,
		spectral_type,
		distance_from_earth,
		discover_date
	)
VALUES (
		'Proxima Centauri',
		244600,
		56800,
		0.052,
		NULL,
		NULL,
		'M5.5 Ve',
		4.426,
		'1915-01-01'
	);
SET @PC_ID = LAST_INSERT_ID();
INSERT INTO `planet_categories` (name)
VALUES ('Terrestrial');
SET @CAT_TER_ID = LAST_INSERT_ID();
INSERT INTO `planet_categories` (name)
VALUES ('Jovian');
SET @CAT_JOV_ID = LAST_INSERT_ID();
INSERT INTO `planet_categories` (name)
VALUES ('Dwarf');
SET @CAT_DWA_ID = LAST_INSERT_ID();
/* Batch Add */
INSERT INTO `planets` (
		name,
		mass,
		diameter,
		density,
		gravity,
		escape_velocity,
		rotation_period,
		length_of_day,
		distance_from_sun,
		perihelion,
		aphelion,
		orbital_period,
		orbital_velocity,
		orbital_inclination,
		orbital_eccentricity,
		obliquity_to_orbit,
		mean_temperature,
		surface_pressure,
		ring_systems,
		global_magnetic_field,
		sun_id,
		category_id,
		discover_date
	)
VALUES (
		'Mercury',
		0.33,
		4879,
		5429,
		3.7,
		4.3,
		1407.6,
		4222.6,
		57.9,
		46.0,
		69.8,
		88.0,
		47.4,
		7.0,
		0.206,
		0.034,
		167,
		0,
		0,
		1,
		@SUN_ID,
		@CAT_TER_ID,
		NULL
	),
	(
		'Venus',
		4.87,
		12104,
		5234,
		8.9,
		10.4,
		-5832.5,
		2802,
		108.2,
		107.5,
		108.9,
		224.7,
		35.0,
		3.4,
		0.007,
		177.4,
		464,
		92,
		0,
		0,
		@SUN_ID,
		@CAT_TER_ID,
		NULL
	),
	(
		'Earth',
		5.97,
		12756,
		5514,
		9.8,
		11.2,
		23.9,
		24.0,
		149.6,
		147.1,
		152.1,
		365.2,
		29.8,
		0,
		0.017,
		23.4,
		15,
		1,
		0,
		1,
		@SUN_ID,
		@CAT_TER_ID,
		NULL
	),
	(
		'Mars',
		0.642,
		6792,
		3934,
		3.7,
		5.0,
		24.6,
		24.7,
		228.0,
		206.7,
		249.3,
		687.0,
		24.1,
		1.8,
		0.094,
		25.2,
		-65,
		0.01,
		0,
		0,
		@SUN_ID,
		@CAT_TER_ID,
		NULL
	),
	(
		'Jupiter',
		1898,
		142984,
		1326,
		23.1,
		59.5,
		9.9,
		9.9,
		778.5,
		740.6,
		816.4,
		4331,
		13.1,
		1.3,
		0.049,
		3.1,
		-110,
		null,
		1,
		1,
		@SUN_ID,
		@CAT_JOV_ID,
		NULL
	),
	(
		'Saturn',
		568,
		120536,
		687,
		9.0,
		35.5,
		10.7,
		10.7,
		1432.0,
		1357.6,
		1506.5,
		10747,
		9.7,
		2.5,
		0.052,
		26.7,
		-140,
		null,
		1,
		1,
		@SUN_ID,
		@CAT_JOV_ID,
		NULL
	),
	(
		'Uranus',
		86.8,
		51118,
		1270,
		8.7,
		21.3,
		-17.2,
		17.2,
		2867.0,
		2732.7,
		3001.4,
		30589,
		6.8,
		0.8,
		0.047,
		97.8,
		-195,
		null,
		1,
		1,
		@SUN_ID,
		@CAT_JOV_ID,
		NULL
	),
	(
		'Neptune',
		102,
		49528,
		1638,
		11.0,
		23.5,
		16.1,
		16.1,
		4515.0,
		4471.1,
		4558.9,
		59800,
		5.4,
		1.8,
		0.010,
		28.3,
		-200,
		null,
		1,
		1,
		@SUN_ID,
		@CAT_JOV_ID,
		NULL
	),
	(
		'Pluto',
		0.0130,
		2376,
		1850,
		0.7,
		1.3,
		-153.3,
		153.3,
		5906.4,
		4436.8,
		7375.9,
		90560,
		4.7,
		17.2,
		0.244,
		122.5,
		-225,
		0.00001,
		0,
		null,
		@SUN_ID,
		@CAT_DWA_ID,
		NULL
	),
	(
		'Proxima Centauri b',
		7.5819,
		16582.8,
		5970,
		11.32194,
		9.3,
		267.68,
		267.7,
		2992,
		NULL,
		NULL,
		11.21,
		NULL,
		NULL,
		0.1,
		NULL,
		-57.15,
		NULL,
		0,
		NULL,
		@PC_ID,
		@CAT_TER_ID,
		'2016-08-24'
	);
SET @P_ID =(
		select id
		from planets
		where name = 'Earth'
	);
INSERT INTO `moons` (name, alias, mass, diameter, planet_id)
VALUES ('Moon', 'Lunar', 0.07342, 3474.2, @P_ID);
SET @P_ID =(
		select id
		from planets
		where name = 'Jupiter'
	);
INSERT INTO `moons` (name, alias, mass, diameter, planet_id)
VALUES ('Io', 'Jupiter 1', 0.089319, 3642, @P_ID),
	('Europa', 'Jupiter 2', 0.048, 3138, @P_ID),
	('Ganymede', 'Jupiter 3', NULL, 5262, @P_ID),
	('Callisto', 'Jupiter 4', 0.108, 4800, @P_ID);
SET @P_ID =(
		select id
		from planets
		where name = 'Saturn'
	);
INSERT INTO `moons` (name, alias, mass, diameter, planet_id)
VALUES ('Mimas', 'Saturn 1', 0.000384, 397.2, @P_ID),
	('Enceladus', 'Saturn 2', 0.011, 505, @P_ID),
	('Tethys', 'Saturn 3', 0.000617449, 1062, @P_ID),
	('Dione', 'Saturn 4', 0.001096, 1118, @P_ID),
	('Rhea', 'Saturn 5', 0.002306518, 1528, @P_ID),
	('Titan', 'Saturn 6', 0.1345, 4828, @P_ID),
	('Hyperion', 'Saturn 7', 0.0000056119, 270, @P_ID),
	('Iapetus', 'Saturn 8', 0.001805635, 1469, @P_ID);
SET @P_ID =(
		select id
		from planets
		where name = 'Uranus'
	);
INSERT INTO `moons` (name, alias, mass, diameter, planet_id)
VALUES ('Ariel', 'Uranus 1', 0.001251, 1157.8, @P_ID),
	('Umbriel', 'Uranus 2', 0.001275, 1169.4, @P_ID),
	('Titania', 'Uranus 3', 0.0034, 1576.8, @P_ID),
	('Oberon', 'Uranus 4', 0.003076, 1522.8, @P_ID),
	('Miranda', 'Uranus 5', 0.0000659, 473, @P_ID);
SET @P_ID =(
		select id
		from planets
		where name = 'Neptune'
	);
INSERT INTO `moons` (name, alias, mass, diameter, planet_id)
VALUES ('Triton', 'Neptune 1', 0.02139, 2706.8, @P_ID),
	('Nereid', 'Neptune 2', 0.00002, 340, @P_ID),
	('Naiad', 'Neptune 3', 0.00000019, 58, @P_ID),
	('Thalassa', 'Neptune 4', 0.00000037, 82, @P_ID),
	('Despina', 'Neptune 5', 0.0000008, 150, @P_ID),
	('Galatea', 'Neptune 6', 0.00000212, 184, @P_ID),
	('Larissa', 'Neptune 7', NULL, 193, @P_ID),
	('Proteus', 'Neptune 8', NULL, 416, @P_ID);
SET @P_ID =(
		select id
		from planets
		where name = 'Pluto'
	);
INSERT INTO `moons` (name, alias, mass, diameter, planet_id)
VALUES ('Charon', 'Pluto 1', 0.001586, 1212, @P_ID),
	('Nix', 'Pluto 2', 0.000000045, 49.8, @P_ID);