CREATE TYPE microphone AS (
    waterproof boolean,
    speaker boolean,
    earpiece boolean
);

CREATE TABLE radio (
    radioname VARCHAR(50),
    mic microphone
);

INSERT INTO radio (mic,radioname) VALUES ('(1,1,0)','Yaesu 8900');

SELECT * FROM radio;


