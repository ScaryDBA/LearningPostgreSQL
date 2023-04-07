--JOIN with USING
SELECT
	r.radio_name,
	m.manufacturer_name 
FROM
	radio.radios r
JOIN radio.manufacturers m
		USING (manufacturer_id);

	
--JOIN using NATURAL	
SELECT
	r.radio_name,
	m.manufacturer_name 
FROM
	radio.radios r
NATURAL JOIN radio.manufacturers m;


--LEFT join example
SELECT
	a.antenna_name,
	ab.band_id
FROM
	radio.antenna a
NATURAL LEFT JOIN radio.antennabands ab;


--LATERAL 
SELECT
	b.band_name,
	rl.radio_name
FROM
	radio.bands b,
	LATERAL (
	SELECT
		*
	FROM
		radio.radios r
	JOIN radio.radiobands rb
ON
		r.radio_id = rb.radio_id
	WHERE
		b.frequency_start_khz < 146) rl;
	
	
--WHERE 
--No samples
	
--SELECT 
--Automatic names

SELECT
	rb.radio_id + rb.band_id
FROM
	radio.radiobands rb;

	


--LIMIT

SELECT
	r.radio_name
FROM
	radio.radios r
LIMIT 3;
	

SELECT
	r.radio_name
FROM
	radio.radios r
LIMIT 3 OFFSET 2;

--FETCH
SELECT
	r.radio_name
FROM
	radio.radios r
ORDER BY
	r.radio_name DESC 	
FETCH NEXT 3 ROWS ONLY;

		