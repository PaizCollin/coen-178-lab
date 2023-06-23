-- Part 1
-- Create Club Table
CREATE TABLE Club (
    clubName VARCHAR(25),
    fee INTEGER
);

-- Create Members Table
CREATE TABLE Members (
    id VARCHAR(5),
    name VARCHAR(20),
    clubName VARCHAR(25)
);

-- Insert values
insert into Club values ('tennis',1000);
insert into Club values ('hockey',1200);
insert into Club values ('dancing',300);
insert into Club values ('videogames',200);
insert into Club values ('gymnastics',500);
insert into Club values ('polo',5000);
insert into Members values ('m1','smith','tennis');
insert into Members values ('m2','jones','tennis');
insert into Members values ('m3','shiner','dancing');
insert into Members values ('m4','winger','dancing');
insert into Members values ('m5','toner','videogames');
insert into Members values ('m6','clark','videogames');
insert into Members values ('m22','mason','rockclimbing');

-- Exercise 1.1
-- Natural Join Approach
SELECT clubname, fee FROM Members
    NATURAL JOIN Club;

-- Eliminate duplicates
SELECT DISTINCT clubname, fee FROM Members
    NATURAL JOIN Club;

-- Inner Join Approach
SELECT Members.clubName, fee FROM Members
    INNER JOIN Club
    ON Members.clubName = Club.clubName;

-- Eliminate duplicates
SELECT DISTINCT Members.clubName, fee FROM Members
    INNER JOIN Club
    ON Members.clubName = Club.clubName;

-- Exercise 1.2
SELECT name, Members.clubName, fee FROM Members
    LEFT JOIN Club
    ON Members.clubName = Club.clubName;

-- Exercise 1.3
SELECT name, Club.clubName, fee FROM Members
    RIGHT JOIN Club
    ON Members.clubName = Club.clubName;



-- Part 2
-- Exercise 2.1
CREATE TABLE AlphaCoEmp (
    Name VARCHAR(25) PRIMARY KEY,
    Title VARCHAR(20) DEFAULT NULL,
    Salary NUMBER(10,2) DEFAULT 0
);

INSERT INTO AlphaCoEmp(name)
    SELECT last FROM Staff;

INSERT INTO AlphaCoEmp(name)
    SELECT DISTINCT last FROM Staff;

SELECT * FROM AlphaCoEmp;

-- Exercise 2.2
CREATE TABLE Emp_Work (
    name VARCHAR(25) PRIMARY KEY,
    Project VARCHAR(20) DEFAULT NULL,
    Constraint FK_AlphaCo
    FOREIGN KEY (name) REFERENCES AlphaCoEmp(name)
);

INSERT INTO Emp_Work(name)
    (SELECT Name from AlphaCoEmp 
    WHERE REGEXP_LIKE(name,'(^[ags])','i'));

SELECT name FROM Emp_Work;

SELECT name FROM AlphaCoEmp;

DELETE FROM AlphaCoEmp
    WHERE name = 'Smith';

-- Exercise 2.3
ALTER TABLE Emp_Work
    DROP Constraint FK_AlphaCo;

ALTER TABLE Emp_Work
    ADD Constraint FK_AlphaCo
    FOREIGN KEY(name) REFERENCES AlphaCoEmp(name)
    ON DELETE CASCADE;

DELETE FROM AlphaCoEmp
    WHERE name = 'Smith';

SELECT name FROM Emp_Work
    WHERE name = 'Smith';



-- Part 3
-- Create L_Person Table
CREATE TABLE L_Person (
    id INTEGER PRIMARY KEY,
    name VARCHAR(30),
    age INTEGER
);

-- Create L_Member Table
CREATE TABLE L_Member (
    id INTEGER,
    clubname VARCHAR(25),
    joinedDate DATE
);

-- Insert values
insert into L_Person values(10,'smith',25);
insert into L_Person values(15,'jones',20);
insert into L_Person values(16,'grey',30);
insert into L_Person values(17,'green',43);
insert into L_Person values(18,'sander',50);
insert into L_Person values(19,'brown',62);
insert into L_Person values(25,'mart',21);

insert into L_Member values(10,'tennis',TO_DATE('March
11,2015','MONTH DD,YYYY'));
insert into L_Member values(15,'videogames',TO_DATE('April
14,2020','MONTH DD,YYYY'));
insert into L_Member values(17,'hockey',TO_DATE('October
20,2021','MONTH DD,YYYY'));
insert into L_Member values(19,'hockey',TO_DATE('September
20,2021','MONTH DD,YYYY'));
insert into L_Member values(25,'polo',TO_DATE('may
2,2019','MONTH DD,YYYY'));

-- Exercise 3.1
SELECT id, MONTHS_BETWEEN(SYSDATE, joinedDate) MONTHS_BETWEEN
    FROM L_Member;

SELECT id, FLOOR(MONTHS_BETWEEN(SYSDATE, joinedDate)) MONTHS_BETWEEN
    FROM L_Member;

-- a
SELECT id, joinedDate, SYSDATE, 
    FLOOR((MONTHS_BETWEEN(SYSDATE, joinedDate)) / 12) Years,
    MOD(FLOOR(MONTHS_BETWEEN(SYSDATE, joinedDate)), 12) Months
    FROM L_Member;

-- b
SELECT id, clubName, joinedDate
    FROM L_Member
    WHERE joinedDate <= all(SELECT joinedDate FROM L_Member);

-- Exercise 3.2
SELECT id, name FROM L_Person
    WHERE EXISTS (SELECT * FROM L_Member
        WHERE L_Person.id = L_Member.id);

SELECT id, name FROM L_Person
    WHERE EXISTS (SELECT * FROM L_Member);

-- a
SELECT id, name FROM L_Person
    WHERE NOT EXISTS (SELECT * FROM L_Member
        WHERE L_Person.id = L_Member.id);

-- Exercise 3.3
-- a
SELECT p.id, name FROM L_Person p
    JOIN L_Member m
    ON p.id = m.id;

-- b
SELECT id, name FROM L_Person
    WHERE id NOT IN (SELECT id FROM L_Member);