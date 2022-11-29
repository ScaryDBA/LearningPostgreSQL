CREATE INDEX radios_radioname ON radios(radioname);

CREATE INDEX radios_radioname ON radios USING BTREE(radioname);

DROP INDEX if EXISTS radios_radioname;

CREATE INDEX radios_radioname_radioid ON radios USING BTREE(radioname, radioid);

DROP INDEX IF EXISTS radios_radioname_radioid;

CREATE INDEX radios_radioid_unique ON radios USING BTREE(radioid);

DROP INDEX IF EXISTS radios_radioid_unique;

CREATE INDEX radios_radioname ON radios USING BTREE(radioname DESC NULLS FIRST);

DROP INDEX IF EXISTS radios_radioname;

CREATE INDEX radios_radioid ON radios USING BTREE(radioid) INCLUDE(radioname);

DROP INDEX IF EXISTS radios_radioid;

create index on radios using btree(radioid)
