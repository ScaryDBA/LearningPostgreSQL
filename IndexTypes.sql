--defaults
CREATE INDEX radios_radioname ON radio.radios(radio_name);

--defining index type
CREATE INDEX radios_radioname ON radio.radios USING BTREE(radio_name);

DROP INDEX if EXISTS radio.radios_radioname;

--compound keys
CREATE INDEX radios_radioname_radioid ON radio.radios USING BTREE(radio_name, radio_id);

DROP INDEX IF EXISTS radio.radios_radioname_radioid;

--uniqe
CREATE UNIQUE INDEX radios_radioid_unique ON radio.radios USING BTREE(radio_id);

DROP INDEX IF EXISTS radio.radios_radioid_unique;

--defining order
CREATE INDEX radios_radioname ON radio.radios USING BTREE(radio_name DESC NULLS FIRST);

DROP INDEX IF EXISTS radio.radios_radioname;

--include
CREATE INDEX radios_radioid ON radio.radios USING BTREE(radio_id) INCLUDE(radio_name);

DROP INDEX IF EXISTS radio.radios_radioid;

--partial/filtered
CREATE INDEX radios_radioname ON radio.radios USING BTREE(radio_name)
WHERE radio_name IS NOT NULL;


drop index if exists radio.radios_radioname;


--Hash Indexes

CREATE INDEX bands_band_name ON radio.bands USING HASH(band_name);
