--reset the database
--connect first to postgres database

--DROP DATABASE IF EXISTS hamshackradio;
--CREATE DATABASE hamshackradio;

--connect to hamshackradio
--start with a radio schema
--may add more schema for more functionality in the future

CREATE SCHEMA radio;

GRANT USAGE ON SCHEMA radio TO postgres;

--radios is the root of the whole thing
CREATE TABLE IF NOT EXISTS radio.radios
	(radio_id int CONSTRAINT pkradios PRIMARY KEY GENERATED always AS IDENTITY,
	radio_name varchar(100) NOT NULL,
	manufacturer_id int NOT NULL,
	picture BYTEA NULL,
	connectortype_id int NOT NULL,
	digitalmode_id int NULL);
	
--natural key for radios
CREATE UNIQUE INDEX radios_radio_name_manufacturer_id_unique ON radio.radios USING BTREE(radio_name,manufacturer_id);

--a manufacturer makes multiple products
CREATE TABLE IF NOT EXISTS radio.manufacturers
	(manufacturer_id int CONSTRAINT pkmanufacturers PRIMARY KEY GENERATED always AS IDENTITY,
	manufacturer_name varchar(100) NOT NULL);	

--natural key for manufacturers
CREATE UNIQUE INDEX manufacturers_manufacturer_name_unique ON radio.manufacturers USING BTREE(manufacturer_name);

--Antenna & radios have connectors
CREATE TABLE IF NOT EXISTS radio.connectortypes
(connectorytype_id int CONSTRAINT pkconnectortypes PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
connectortype_name varchar(100) NOT NULL);

--natural key for connectortypes
CREATE UNIQUE INDEX connectortypes_connectorytype_name ON radio.connectortypes USING BTREE(connectorytype_id);

--some radios support digital modes
CREATE TABLE IF NOT EXISTS radio.digitalmodes
(digitalmode_id int CONSTRAINT pkdigitalmode PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
digitalmode_name varchar(100) NOT NULL);

--natural key for digitalmodes
CREATE UNIQUE INDEX digitalmodes_digitalmode_name ON radio.digitalmodes USING BTREE(digitalmode_id);

--relate radios to various lookup tables
ALTER TABLE radio.radios
ADD foreign key (manufacturer_id) references radio.manufacturers;

ALTER TABLE radio.radios
ADD FOREIGN KEY (connectortype_id) REFERENCES radio.connectortypes;

ALTER TABLE radio.digitalmodes
ADD FOREIGN KEY (digitalmode_id) REFERENCES radio.digitalmodes;

--radios need antenna
CREATE TABLE IF NOT EXISTS radio.antenna
	(antenna_id int CONSTRAINT pkantenna PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
		antenna_name varchar(100) NOT NULL,
	 manufacturer_id int NOT NULL,
	 connectortype_id int NOT NULL
	);

--natural key for antenna
CREATE UNIQUE INDEX antenna_antenna_name_unique ON radio.antenna USING BTREE(antenna_name,manufacturer_id);

ALTER TABLE radio.antenna
ADD FOREIGN KEY (manufacturer_id) REFERENCES radio.manufacturers;

ALTER TABLE radio.antenna
ADD FOREIGN KEY (connectortype_id) REFERENCES radio.connectortypes;

--amateur radios work within bands, defined by country
CREATE TABLE IF NOT EXISTS radio.bands
(band_id int CONSTRAINT pkbands PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
 band_name varchar(100) NOT NULL,
 frequency_start_khz numeric(9,2) NOT NULL,
 frequency_end_khz numeric(9,2) NOT NULL,
 country_id int NOT NULL);
 
--natural key for bands
CREATE UNIQUE INDEX bands_band_name_country_id ON radio.bands USING BTREE(band_name,country_id);

--radios support multiple bands
CREATE TABLE IF NOT EXISTS radio.radiobands
(radio_id int NOT NULL,
band_id int NOT NULL,
CONSTRAINT pkradiobands PRIMARY KEY(radio_id,band_id));

ALTER TABLE radio.radiobands
ADD FOREIGN KEY (radio_id) REFERENCES radio.radios;

ALTER TABLE radio.radiobands
ADD FOREIGN KEY (band_id) REFERENCES radio.bands;

--antenna support multiple bands
CREATE TABLE IF NOT EXISTS radio.antennabands
(antenna_id int NOT NULL,
band_id int NOT NULL,
CONSTRAINT pkantennabands PRIMARY KEY(antenna_id,band_id));

ALTER TABLE radio.antennabands
ADD FOREIGN KEY (antenna_id) REFERENCES radio.antenna;

ALTER TABLE radio.antennabands
ADD FOREIGN KEY (band_id) REFERENCES radio.bands;

--country table
CREATE TABLE IF NOT EXISTS radio.countries
(country_id int CONSTRAINT pkcountry PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
country_name varchar(100) NOT NULL);

ALTER TABLE radio.bands
ADD FOREIGN KEY (country_id) REFERENCES radio.countries;


--which radio is using which antenna
CREATE TABLE IF NOT EXISTS radio.radioantenna
(radio_id int NOT NULL,
antenna_id int NOT NULL,
CONSTRAINT pkradioantenna PRIMARY KEY(radio_id,antenna_id));


--logging schema for storing points & other data types
CREATE SCHEMA logging;

GRANT USAGE ON SCHEMA logging TO postgres;

CREATE TABLE IF NOT EXISTS logging.logs
(log_id int CONSTRAINT pklogs PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
log_date timestamptz  NOT NULL,
log_callsign text,
log_location point NOT NULL);

CREATE TABLE IF NOT EXISTS logging.parksontheair
(parksontheair_id int CONSTRAINT pkparksontheair PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
contacts text[]);

--making sure I have this extension
CREATE EXTENSION btree_gist;





