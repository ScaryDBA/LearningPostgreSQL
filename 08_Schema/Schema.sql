--a test schema
CREATE SCHEMA mytestschema;


--create a table within the schema
create table mytestschema.testtable
(id int,
somevalue varchar(50));


--querying the table using schema 
select id from mytestschema.testtable;


--second schema and testtable 
create schema anothertest;

create table anothertest.testtable
(id int,
somevalue varchar(50));

create table public.testtable
(id int,
somevalue varchar(50));


