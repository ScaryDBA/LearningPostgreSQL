CREATE TEMPORARY TABLE radioupdates (radio_name varchar(100),
manufacturer_id int,
connectortype_id int,
delete_flag int);

INSERT
	INTO
	radioupdates (radio_name,
	manufacturer_id,
	connectortype_id,
	delete_flag)
VALUES
('UV5R',
2,
3,
0),
('UV5R',
3,
3,
0),
('UV5R',
1,
3,
1);

MERGE
INTO
	radio.radios AS r
		USING radioupdates AS ru
ON
	ru.radio_name = r.radio_name
	AND ru.manufacturer_id = r.manufacturer_id
	WHEN NOT MATCHED THEN
  INSERT 
VALUES(DEFAULT,
ru.radio_name,
ru.manufacturer_id,
NULL,
ru.connectortype_id,
NULL)
WHEN MATCHED
AND ru.delete_flag = 0 THEN
  UPDATE
SET
	r.connectortype_id = ru.connectortype_id
	WHEN MATCHED
	AND ru.delete_flag = 1 THEN
  DELETE;