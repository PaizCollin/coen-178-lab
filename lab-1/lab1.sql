-- Part 1:
CREATE TABLE trial (
    tnum int,
    str char(10)
    );

INSERT INTO trial VALUES (1,'A test');

INSERT INTO trial VALUES (2, 'test2');

INSERT INTO trial VALUES (3, 'test3');

SELECT * FROM trial;

SELECT tnum FROM trial;

INSERT INTO trial VALUES (1, 'A test');

SELECT * FROM trial;

CREATE TABLE test (
    tnum int,
    str char(10),
    PRIMARY KEY(tnum)
    );

INSERT INTO test VALUES (1, 'A test');

INSERT INTO test VALUES (1, 'A test');

SELECT TABLE_NAME
    FROM USER_TABLES;

DROP TABLE trial;

SELECT TABLE_NAME
    FROM USER_TABLES;



-- Part 2:
start /home/cpaiz/COEN178/labs/lab1/data.sql

SELECT * FROM test;



-- Part 3:
start /home/cpaiz/COEN178/labs/lab1/insertStaffData.sql

SELECT * FROM Staff;

SELECT Last FROM Staff;

SELECT First || Last AS fullname FROM Staff;