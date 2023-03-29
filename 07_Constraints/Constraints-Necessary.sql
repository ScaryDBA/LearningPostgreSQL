--example table showing default behavior of NULL
create table public.example
(id int,
somevalue varchar(50));


--this script will fail
insert
	into
	radio.radios 
(manufacturer_id)
values
(2);


--how to list constraints on a table
select
	c.conname,
	ccu.table_schema,
	ccu.table_name,
	ccu.column_name,
	c.contype,
	pg_get_constraintdef(c.oid)
from
	pg_constraint as c
join pg_namespace as ns on
	ns.oid = c.connamespace
join pg_class as cl on
	c.conrelid = cl.oid
left join information_schema.constraint_column_usage as ccu
                   on
	c.conname = ccu.constraint_name
	and ns.nspname = ccu.constraint_schema
where
	ccu.table_name = 'radios';
	

--listing column names in a table that are nullable
select column_name
from  information_schema.columns
where table_catalog = 'hamshackradio'
  and table_schema = 'radio'
  and table_name = 'radios'
  and is_nullable = 'YES'


 
  

-- example 1 unique constraint
CREATE TABLE IF NOT EXISTS public.uniqueval1
	(id int not null,
	myuniquevalue varchar(50) unique);


--get a list of indexes from a table
select
	i.indexname,
	i.indexdef
from
	pg_indexes as i
where
	i.tablename = 'uniqueval1';




--creating a filtered unique index
CREATE UNIQUE INDEX uniqueval_notnull_idx ON public.nullunique (ComputedUniqueeval)
WHERE uniqueval IS NULL;


drop table if exists public.uniqueval1;





--example unique column constraint
create table if not exists public.uniqueval2
	(id int not null,
	myuniquevalue varchar(50) not null,
	unique(myuniquevalue));

drop table if exists public.uniqueval2;

--With the naming syntax in place
create table if not exists public.uniqueval3
	(id int not null,
	myuniquevalue varchar(50) constraint uniqueval3_inameit unique not null);

create table if not exists public.uniqueval4
	(id int not null,
	myuniquevalue varchar(50),
	constraint inameit unique(myuniquevalue));

drop table if exists public.uniqueval3;
drop table if exists public.uniqueval4;

--using alter table to add a constraint
--create a table without a constraint
create table if not exists public.uniqueval5
	(id int not null,
	myuniquevalue varchar(50) null);

--now add the constraint
alter table public.uniqueval5
add constraint mynewconstraint unique(myuniquevalue);

dropt table if exists public.uniqueval5 


--dealing with null values 
create table if not exists public.nullnotunique
	(id int not null,
	nonuniqueval varchar(50) constraint notunique unique null);

insert
	into
	public.nullnotunique
(id,
	nonuniqueval)
values
(1,
null),
(2,
null),
(3,
'one');


create table if not exists public.nullunique
	(id int not null,
	uniqueval varchar(50) constraint nowunique unique nulls not distinct null);

insert
	into
	public.nullunique
(id,
	uniqueval)
values
(1,
null),
(2,
null),
(3,
'one');


drop table if exists public.nullnotunique;
drop table if exists public.nullunique;


--Primary key
create table if not exists public.pkexample
(id int primary key not null,
somevalue varchar(50));


--bad example
create table if not exists public.badpkexample
(id int null,
somevalue varchar(50));
Check the results of the following metadata query:
select is_nullable
from   information_schema.columns
where table_schema = 'public'
and   table_name = 'badpkexample'
and   column_name = 'id';



alter table public.badpkexample
  add constraint PKbadpkexample
     primary key (id);

    
    
    
--clean up
DROP TABLE IF EXISTS public.badpkexample;



--Foreign key
ALTER TABLE radio.radios
ADD foreign key (manufacturer_id) references radio.manufacturers;

--remove and readd the foreign key 
alter table radio.radios drop constraint radios_manufacturer_id_fkey;

alter table radio.radios add constraint 
radios_fk_manufacturer foreign key (manufacturer_id) references radio.manufacturers;

--defining a foreign key as part of the table definition
create table if not exists radio.radios
	(radio_id int constraint pkradios primary key generated always as identity,
	radio_name varchar(100) not null,
	manufacturer_id int not null,
	picture BYTEA null,
	connectortype_id int not null,
	digitalmode_id int null,
	constraint radios_fk_manufacturer foreign key (manufacturer_id) references radio.manufacturers 
	);

--adding RESTRICT
create table if not exists radio.radios
	(radio_id int constraint pkradios primary key generated always as identity,
	radio_name varchar(100) not null,
	manufacturer_id int not null,
	picture BYTEA null,
	connectortype_id int not null,
	digitalmode_id int null,
	constraint radios_fk_manufacturer foreign key (manufacturer_id) references radio.manufacturers on delete restrict
	);

--changing it to cascade
create table if not exists radio.radios
	(radio_id int constraint pkradios primary key generated always as identity,
	radio_name varchar(100) not null,
	manufacturer_id int not null,
	picture BYTEA null,
	connectortype_id int not null,
	digitalmode_id int null,
	constraint radios_fk_manufacturer foreign key (manufacturer_id) references radio.manufacturers on delete cascade 
	);






--Check constraints 
CREATE TABLE IF NOT EXISTS radio.bands
(band_id int CONSTRAINT pkbands PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
 band_name varchar(100) NOT NULL,
 frequency_start_khz numeric(9,2) NOT NULL,
 frequency_end_khz numeric(9,2) NOT NULL,
 country_id int NOT NULL);

alter table radio.bands 
add constraint minfrequency check (frequency_start_khz >= 135.7);


--another constraint comparing columns
ALTER TABLE radio.bands
ADD CONSTRAINT startlessthanend CHECK (frequency_start_khz < frequency_end_khz);


--null constraint 
create table public.nullconstraintcheck
(
      id    int not null,
      value int NULL
); 

--adding constraint
alter table public.nullconstraintcheck
  add constraint valueEquals1 
     check (value = 1);


    
--code wil fail
insert into public.nullconstraintcheck(id, value)
values (1,1); 
insert into public.nullconstraintcheck(id, value)
values (2,2);
    

--code will succeed
insert into public.nullconstraintcheck(id, value)
values (3,NULL);


--changing the table to get better behavior
alter table public.nullconstraintcheck
     drop constraint valueEquals1;
alter table public.nullconstraintcheck
  add constraint valueEquals1 
  	check ((value is not null and value = 1)
		   OR (id < 5 and value = 1));

insert into public.nullconstraintcheck(id,value)
values (4,NULL);

insert into public.nullconstraintcheck(id,value)
values (5,NULL);

    

--exclusion constraint 
CREATE EXTENSION btree_gist;




alter table logging.logs
add constraint uniquecontact exclude
	using gist (log_date with =,
	log_callsign  with =,
log_location with ~=);


INSERT INTO logging.logs
(log_date,log_callsign,log_location)
VALUES
('12/21/2022','KC1KCE','35.952, -96.152'),
('12/21/2022','KC1KCE','35.957, -96.127');

INSERT INTO logging.logs
(log_date,log_callsign,log_location)
VALUES
('12/21/2022','KC1KCE','35.952, -96.152');





