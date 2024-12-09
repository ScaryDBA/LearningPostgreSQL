--example transactoin
BEGIN;
    INSERT INTO radio.antenna (
        antenna_name,
        manufacturer_id,
        connectortype_id
    ) VALUES (
        'Stubby',
        3,
        2
    );
END;

--removing the value in order to rerun the query above
DELETE
FROM
	radio.antenna
WHERE
	antenna_name = 'Stubby';
	

--getting the current transaction id
SELECT txid_current();


--looking at an active transaction
SELECT
	psa.pid,
	psa.backend_xid,
	psa.backend_xmin,
	psa.state,
	psa.query
FROM
	pg_stat_activity AS psa
WHERE
	state <> 'idle';
