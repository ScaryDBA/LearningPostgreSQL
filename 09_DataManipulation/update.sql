--basic update
begin transaction;
UPDATE
	radio.bands
SET
	band_name = '70 CM'
WHERE
	band_id = 2;
rollback transaction; 

--update using select
BEGIN;

UPDATE
	radio.bands
SET
	band_name = r.radio_name
FROM
	radio.radios AS r
WHERE
	band_id = r.radio_id ;

ROLLBACK;

--update only table
UPDATE ONLY
	radio.bands
SET
	band_name = r.radio_name
FROM
	radio.radios AS r
WHERE
	band_id = r.radio_id ;