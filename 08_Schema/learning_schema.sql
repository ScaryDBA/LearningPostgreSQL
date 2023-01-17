--creating the first schema
CREATE SCHEMA mytestschema;


--creating a table in that schema 
create table mytestschema.testtable
(id int,
somevalue varchar(50));


--referencing the schema in a select statement
select id from mytestschema.testtable;


--duplicate table names as long as the schema is different
create schema secondschema;

create table secondschema.testtable
(insertdate date,
someothervalue varchar(20));



--script with an error because of the missing schema
select * from testtable;



--dropping a schema after removing all objects in it
drop table if exists secondschema.testtable;
drop schema if exists secondschema;


--generate an error 
drop schema if exists mytestschema;


--cascade to remove all objects
drop schema if exists mytestschema cascade;


--cleanup
drop schema if exists mytestschema cascade;
drop schema if exists secondschema cascade;


show search_path;

drop schema if exists public cascade;
create schema public;



