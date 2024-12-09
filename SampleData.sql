
--sample data for the hamradio db
INSERT INTO radio.manufacturers
(manufacturer_name)
VALUES
('Yeasu'),('Icom'),('Baofeng'),('BTech'),('TidRadio'),('Xiegu'),('Raddiodity');

INSERT INTO radio.countries
(country_name)
VALUES
('USA'),('United Kingdom');

INSERT INTO radio.bands
(band_name,frequency_start_khz,frequency_end_khz,country_id)
VALUES
('2 Meters',144000.0,146000.0,1),
('70 cm',420000.0,450000.0,1),
('20 Meters',14000.0,14350.0,1),
('144MHz Band',144000.0,146000.0,2),
('432MHz Band',430000.0,440000.0,2),
('20 Metres',14000.0,14350.0,2);

INSERT INTO radio.connectortypes
(connectortype_name)
VALUES
('BNC'),('SMA Male'),('SMA Female'),('PL259');


INSERT INTO radio.antenna
(antenna_name,manufacturer_id,connectortype_id)
VALUES
('Rubber duck',3,2),
('Rubber duck',2,3),
('Multi-band',1,4);

INSERT INTO radio.antennabands
(band_id,antenna_id)
VALUES
(1,1),(2,1),(4,1),(5,1),
(1,2),(2,2),(4,2),(5,2),
(3,3),(5,3);

INSERT INTO radio.digitalmodes
(digitalmode_name)
VALUES
('FusionX'),('DMR');

INSERT INTO radio.radios
(radio_name,manufacturer_id,connectortype_id,digitalmode_id)
VALUES
('FT3D',2,2,1),('UV5R',3,3,NULL),('G90',6,4,NULL);

INSERT INTO radio.radioantenna
(radio_id,antenna_id)
VALUES
(1,2),(2,1),(3,3);


INSERT INTO logging.logs
(log_date,log_callsign,log_location)
VALUES
(CURRENT_TIMESTAMP,'KC1KCE','35.947, -96.149'),
(CURRENT_TIMESTAMP,'KC1KCE','35.963, -96.114'),
(CURRENT_TIMESTAMP,'KC1KCE','35.985, -96.106');

INSERT INTO logging.parksontheair
(contacts)
VALUES
(ARRAY['KC1KCE', 'KI5EGH', 'KJ7VSF','N4DAD','KD7IFN']),
(ARRAY['KN4XP','KA0GAV','NM8GS','W3DET']),
(ARRAY['W3DET','N4AUG','KC3WRX','WA9EBX','W1OW','K4RFH','W9DC','WJ8L','N4HES']);

INSERT INTO radio.radiobands
(radio_id, band_id)
VALUES
(1,1),(1,2),(1,4),(1,5),
(2,1),(2,2),
(3,3),(3,6);



