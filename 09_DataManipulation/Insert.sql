--Adding a single row
INSERT
	INTO
	radio.radios
(radio_name,
	manufacturer_id,
	connectortype_id,
	digitalmode_id)
VALUES
('GD-88',
9,
3,
2);

--Adding multiple rows
INSERT
	INTO
	radio.radios
(radio_name,
	manufacturer_id,
	connectortype_id,
	digitalmode_id)
VALUES
('FT300DR',
1,
4,
1),
('IC-V86',
2,
2,
NULL);

--INSERT from SELECT
INSERT
	INTO
	radio.radiobands 
(radio_id,
	band_id)
SELECT
	9,
	band_id
FROM
	radio.radiobands
WHERE
	radio_id = 2;

--using defaults
INSERT
	INTO
	radio.connectortypes (connectorytype_id,
	connectortype_name)
VALUES
(DEFAULT,
'F-Type Male');

--all defaults
INSERT
INTO radio.connectortype
DEFAULT VALUES

--overriding defaults
INSERT
	INTO
	radio.bands
(band_id,
	band_name,
	frequency_start_khz,
	frequency_end_khz,
	country_id)
OVERRIDING SYSTEM VALUE
VALUES (10,
'6 Meters',
50000,
54000,
1);

--on conflict 
INSERT
	INTO
	radio.antenna 
(antenna_name,
	manufacturer_id,
	connectortype_id)
VALUES ('rubber duck',
2,
2)
ON
CONFLICT (antenna_name,
manufacturer_id)
DO
UPDATE
SET
	connectortype_id = excluded.connectortype_id;
