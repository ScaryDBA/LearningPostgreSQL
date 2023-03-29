WITH addant AS
(
INSERT
	INTO
		radio.antenna (antenna_name,
		manufacturer_id,
		connectortype_id)
	VALUES('Rubber duck',
	1,
	2)
RETURNING antenna_id)
INSERT
	INTO
	radio.antennabands 
(antenna_id,
	band_id)
SELECT
	aa.antenna_id,
	1
FROM
	addant AS aa;

