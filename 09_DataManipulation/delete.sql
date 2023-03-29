--delete all rows
DELETE
FROM
	radio.bands;

--targeted DELETE 
DELETE
FROM
	radio.antenna
WHERE
	antenna_id = 42;

--USING another table
DELETE
FROM
	radio.antennabands AS ab
		USING radio.bands AS b
WHERE
	ab.band_id = b.band_id
	AND b.band_name = '6 Meters';
