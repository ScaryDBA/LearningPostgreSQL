-- a function to return information about radios
CREATE OR REPLACE
FUNCTION radio.radiodetails (radioid INT)
RETURNS TABLE(radio_id int,
radio_name varchar(100))
AS $$
SELECT
	r.radio_id,
	r.radio_name
FROM
	radio.radios AS r
WHERE
	r.radio_id = $1 $$
LANGUAGE SQL;


--changing the ordinal to parameter name
CREATE OR REPLACE
FUNCTION radio.radiodetails (radioid INT)
RETURNS TABLE(radio_id int,
radio_name varchar(100))
AS $$
SELECT
	r.radio_id,
	r.radio_name
FROM
	radio.radios AS r
WHERE
	r.radio_id = radioid $$
LANGUAGE SQL;

--output parameters
CREATE OR REPLACE
FUNCTION radio.radiodetails2 (INOUT radioid INT, OUT radioname varchar(100))
AS $$
SELECT
	r.radio_id,
	r.radio_name
FROM
	radio.radios AS r
WHERE
	r.radio_id = radioid $$
LANGUAGE SQL;

--calling the function
SELECT * FROM radio.radiodetails(2);

--adding rows
CREATE OR REPLACE
FUNCTION radio.addantenna (antennaname varchar(100),
manufacturerid int,
connectortypeid int)
RETURNS VOID
AS $$ 
INSERT
	INTO
	radio.antenna
(antenna_name,
	manufacturer_id,
	connectortype_id)
VALUES
(antennaname,
manufacturerid,
connectortypeid)
$$ 
LANGUAGE SQL;

--using SELECT to INSERT
SELECT
	*
FROM
	radio.addantenna('Stubby',
	4,
	2);


SELECT * FROM radio.antenna


--creating a procedure
CREATE OR REPLACE
PROCEDURE radio.newantenna (antennaname varchar(100),
manufacturerid int,
connectortypeid int)
AS $$ 
INSERT
	INTO
	radio.antenna
(antenna_name,
	manufacturer_id,
	connectortype_id)
VALUES
(antennaname,
manufacturerid,
connectortypeid)
$$ 
LANGUAGE SQL;

--using a procedure
CALL radio.newantenna('771',6,3)


--transactions
CREATE OR REPLACE
PROCEDURE radio.newantenna (antennaname varchar(100),
manufacturerid int,
connectortypeid int)
AS $$ 
BEGIN

IF manufacturerid < 1 THEN 
	ROLLBACK;
ELSEIF connectortypeid < 1 THEN 
	ROLLBACK;
ELSE
	INSERT
		INTO
		radio.antenna
	(antenna_name,
	manufacturer_id,
	connectortype_id)
	VALUES
	(antennaname,
	manufacturerid,
	connectortypeid);
END IF;
END
$$ 
LANGUAGE plpgsql;



--call new procedure
CALL radio.newantenna('2 Meter short', 8, 2);



SELECT * FROM radio.manufacturers m 

