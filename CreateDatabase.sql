--reset the database
--connect first to postgres database
drop database if exists hamshackradio;

create database hamshackradio;

--connect to hamshackradio
--start with a radio schema
--may add more schema for more functionality in the future
create schema radio;

grant usage on
schema radio to postgres


create table if not exists radio.radios
(radio_id int primary key generated always as identity,
radio_name varchar(100),
manufacturer_id int,
picture bytea);

create table radio.manufacturers
(manufacturer_id int primary key generated always as identity,
manufacturer_name varchar(100));
