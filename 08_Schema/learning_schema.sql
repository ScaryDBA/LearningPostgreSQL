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


--checking the schema search path
show search_path;



--adding a schema to the search list
SET search_path TO radio,public;


--changing schema security
CREATE SCHEMA secureschema AUTHORIZATION radio_admin;


--revoking ability to create objects on public schema 
REVOKE CREATE ON SCHEMA public FROM PUBLIC;






