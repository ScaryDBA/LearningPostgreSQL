--reset the database
--connect first to postgres database

DROP DATABASE IF EXISTS hamshackradio;


CREATE DATABASE hamshackradio;

--connect to hamshackradio
--start with a radio schema
--may add more schema for more functionality in the future

CREATE SCHEMA radio;

GRANT USAGE ON SCHEMA radio TO postgres

--radios is the root of the whole thing
CREATE TABLE IF NOT EXISTS radio.radios
	(radio_id int CONSTRAINT pkradios PRIMARY KEY GENERATED always AS IDENTITY,
	radio_name varchar(100) NOT NULL,
	manufacturer_id int NOT NULL,
	picture BYTEA NULL,
	connectortype_id int NOT NULL,
	digitaltype_id int NULL);
	
--natural key for radios
CREATE UNIQUE INDEX radios_radio_name_manufacturer_id_unique ON radios USING BTREE(radio_name,manufacturer_id);

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
CREATE UNIQUE INDEX connectory_types_connectorytype_name ON radio.connectortypes USING BTREE(connectorytype_id);

ALTER TABLE radio.radios
ADD foreign key (manufacturer_id) references radio.manufacturers;

ALTER TABLE radio.radios
ADD FOREIGN KEY (connectortype_id) REFERENCES radio.connectortypes;

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
ADD FOREIGN KEY (connectorytype_id) REFERENCES radio.connectortypes;

--amateur radios work within bands, defined by country
CREATE TABLE IF NOT EXISTS radio.bands
(band_id int CONSTRAINT pkbands PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
 band_name varchar(100) NOT NULL,
 frequency_start numeric()
)