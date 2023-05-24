-- Just the basic VACUUM operation
VACUUM;


-- Equivalent to SHRINK
VACUUM (FULL);


-- Targeting a table
VACUUM radio.antenna;

-- Targeting more than one table
VACUUM radio.antenna, radio.bands, radio.digitalmodes  



-- Adding, then removing, dummy data to see this in action
INSERT INTO radio.countries 
(country_name)
SELECT generate_series(1,15000,1);

DELETE FROM radio.countries 
WHERE country_id BETWEEN 3 AND 12000;

VACUUM (VERBOSE) radio.countries;

--cleanup and reset from above
DELETE FROM radio.countries 
WHERE country_id > 2;

ALTER TABLE radio.countries ALTER COLUMN country_id RESTART WITH 3;


SELECT * FROM radio.countries c;



--ANALYZE
VACUUM (ANALYZE);


--Just ANALYZE
ANALYZE;

--ANALYZE and then look at STATISTICS
VACUUM (ANALYZE) radio.countries;

--ensure we have a clean set of statistics, then review them
VACUUM (ANALYZE) radio.countries;

SELECT
	ps.histogram_bounds
FROM
	pg_stats AS ps
WHERE
	ps.tablename = 'countries';


--modify the data and then look at STATISTICS 
INSERT INTO radio.countries 
(country_name)
SELECT generate_series(1,15000,1);

SELECT
	ps.histogram_bounds
FROM
	pg_stats AS ps
WHERE
	ps.tablename = 'countries';

VACUUM (ANALYZE) radio.countries;

SELECT
	ps.histogram_bounds
FROM
	pg_stats AS ps
WHERE
	ps.tablename = 'countries';

--VERBOSE and ANALYZE 

