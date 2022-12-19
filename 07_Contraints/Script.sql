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





