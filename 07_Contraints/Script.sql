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


--Foreign key



