--## BTree indexes
--defaults
create index radios_radioname on
radio.radios(radio_name);

--defining index type
create index radios_radioname on
radio.radios
	using BTREE(radio_name);

drop index if exists radio.radios_radioname;

--compound keys
create index radios_radioname_radioid on
radio.radios
	using BTREE(radio_name,
radio_id);

drop index if exists radio.radios_radioname_radioid;

--uniqe
create unique index radios_radioid_unique on
radio.radios
	using BTREE(radio_id);

drop index if exists radio.radios_radioid_unique;

--defining order
create index radios_radioname on
radio.radios
	using BTREE(radio_name desc nulls first);

drop index if exists radio.radios_radioname;

--include
create index radios_radioid on
radio.radios
	using BTREE(radio_id) include(radio_name);

drop index if exists radio.radios_radioid;

--partial/filtered
create index radios_radioname on
radio.radios
	using BTREE(radio_name)
where
radio_name is not null;

drop index if exists radio.radios_radioname;
--clean all indexes using the drop statements
--## Hash Indexes

create index bands_band_name on
radio.bands
	using HASH(band_name);

--partial/filtered hash index
create index logs_log_date on
logging.logs
	using HASH(log_date)
where
log_date > '1/1/2020';

--## GiST indexes
create index logs_location on
logging.logs
	using gist(log_location);

drop index if exists logging.logs_location;

--## SP-GIST indexes
create index logs_location on logging.logs using spgist(log_location);

--## GIN indexes 
create index parksontheair_contacts on logging.parksontheair using GIN(contacts);

drop index if exists logging.parksontheair_contacts;


--## BRIN indexes 
create index logs_log_date on logging.logs using BRIN(logs_log_date);


