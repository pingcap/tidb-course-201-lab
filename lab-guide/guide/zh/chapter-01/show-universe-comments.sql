SELECT column_name as 'Stars Columns', column_comment 
FROM information_schema.columns 
WHERE table_schema='universe' AND table_name='stars' AND column_comment != '';

SELECT column_name as 'Planets Columns', column_comment 
FROM information_schema.columns 
WHERE table_schema='universe' AND table_name='planets' AND column_comment != '';

SELECT column_name as 'Planet_Categories Columns', column_comment 
FROM information_schema.columns 
WHERE table_schema='universe' AND table_name='planet_categories' AND column_comment != '';

SELECT column_name as 'Moons Columns', column_comment 
FROM information_schema.columns 
WHERE table_schema='universe' AND table_name='moons' AND column_comment != '';