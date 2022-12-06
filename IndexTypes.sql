--defaults
CREATE INDEX radios_radioname ON radios(radioname);

--defining index type
CREATE INDEX radios_radioname ON radios USING BTREE(radioname);

DROP INDEX if EXISTS radios_radioname;

--compound keys
CREATE INDEX radios_radioname_radioid ON radios USING BTREE(radioname, radioid);

DROP INDEX IF EXISTS radios_radioname_radioid;

--uniqe
CREATE UNIQUE INDEX radios_radioid_unique ON radios USING BTREE(radioid);

DROP INDEX IF EXISTS radios_radioid_unique;

--defining order
CREATE INDEX radios_radioname ON radios USING BTREE(radioname DESC NULLS FIRST);

DROP INDEX IF EXISTS radios_radioname;

--include
CREATE INDEX radios_radioid ON radios USING BTREE(radioid) INCLUDE(radioname);

DROP INDEX IF EXISTS radios_radioid;

--partial/filtered
CREATE INDEX radios_radioname ON radios USING BTREE(radioname)
WHERE radioname IS NOT NULL;




create index on radios using btree(radioid)
