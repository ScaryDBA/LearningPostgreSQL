--sample data for the hamradio db
INSERT INTO radio.manufacturers
(manufacturer_name)
VALUES
('Yeasu'),('Icom'),('Baofeng'),('BTech'),('TidRadio'),('Xiegu');

INSERT INTO radio.countries
(country_name)
VALUES
('USA'),('Great Britain');

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
('Rubber duck')

