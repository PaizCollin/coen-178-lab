-- Part 1
-- Create Tables
CREATE TABLE BANKCUST_6 (
    custno VARCHAR(5) PRIMARY KEY,
    custname VARCHAR(20),
    street VARCHAR(30), 
    city VARCHAR(20)
);

CREATE TABLE ACCOUNTS_6 (
    AccountNo VARCHAR(5) PRIMARY KEY,
    accountType VARCHAR(10), 
    amount NUMBER(10,2), 
    custno varchar(5),
    CONSTRAINT accounts_fkey FOREIGN KEY (custno) REFERENCES BANKCUST_6(custno)
);

CREATE TABLE TOTALS_6 (
    custno VARCHAR(5), 
    totalAmount Number(10,2), 
    CONSTRAINT totals_fkey FOREIGN KEY (custno) REFERENCES BANKCUST_6(custno)
);

-- Exercise 1
set serveroutput on;

CREATE or REPLACE TRIGGER display_customer_trig
    AFTER INSERT on BANKCUST_6
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('From Trigger ' || ' Customer NO: '|| :new.custno || ' Customer Name: ' || :new.custname);
END;
/
show errors;

INSERT INTO BANKCUST_6 VALUES('c1','Smith','32 Lincoln st','SJ');
INSERT INTO BANKCUST_6 VALUES('c2','Jones','44 Benton st','SJ');
INSERT INTO BANKCUST_6 VALUES('c3','Peters','12 palm st','SFO');
INSERT INTO BANKCUST_6 VALUES('c20','Chen','20 san felipo','LA');
INSERT INTO BANKCUST_6 VALUES('c33','Williams',' 11 cherry Ave','SFO');

CREATE or REPLACE TRIGGER display_customer_trig
    AFTER INSERT ON BANKCUST_6
    FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('From Trigger ' || ' Customer NO: '|| :new.custno || ' Customer Name: ' || :new.custname 
    || ' City: ' || :new.city);
END;
/
show errors;

-- Exercise 2
ALTER TRIGGER display_customer_trig disable;

CREATE OR REPLACE Trigger Acct_Cust_Trig
    AFTER INSERT ON ACCOUNTS_6
    FOR EACH ROW	
BEGIN	
/*If the custno is already in the Totals_6 table, the update will succeed */
	update totals_6
	set totalAmount = totalAmount + :new.amount
	where custno = :new.custno;	
		
/*If the custno is not in the Totals_6 table, we insert a row into
Totals_6 table. Complete the missing part in the subquery */
insert into totals_6 (select :new.custno, :new.amount from dual
	where not exists (select * from TOTALS_6 where custno = :new.custno));							
END;
/
show errors;

DELETE FROM ACCOUNTS_6;

DELETE FROM TOTALS_6;

INSERT INTO ACCOUNTS_6 VALUES('a1523','checking',2000.00,'c1');
INSERT INTO ACCOUNTS_6 VALUES('a2134','saving',5000.00,'c1');
INSERT INTO ACCOUNTS_6 VALUES('a4378','checking',1000.00,'c2');
INSERT INTO ACCOUNTS_6 VALUES('a5363','saving',8000.00,'c2');
INSERT INTO ACCOUNTS_6 VALUES('a7236','checking',500.00,'c33');
INSERT INTO ACCOUNTS_6 VALUES('a8577','checking',150.00,'c20');

SELECT * FROM TOTALS_6;

-- Exercise 3
UPDATE ACCOUNTS_6
    SET amount = 1000
    WHERE accountno = 'a1523';

-- Exercise 4
CREATE OR REPLACE TRIGGER Acct_Cust_Trig
    AFTER INSERT OR UPDATE ON ACCOUNTS_6
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        UPDATE TOTALS_6
        SET totalAmount = totalAmount + :new.amount
        WHERE custno = :new.custno;

        INSERT INTO TOTALS_6 (
            SELECT :new.custno, :new.amount 
            FROM DUAL
            WHERE NOT EXISTS (
                SELECT * FROM TOTALS_6 
                    WHERE custno = :new.custno)
        );
    END IF;

    IF UPDATING THEN
    /* If we are updating we want to correctly set the totalAmount
        to the new amount that may be >= or < old amount
        Complete the query */
        UPDATE TOTALS_6
        SET totalAmount = totalAmount + :new.amount - :old.amount
        WHERE custno = :new.custno;
    END IF;
END;
/
show errors;

DELETE FROM ACCOUNTS_6;

DELETE FROM TOTALS_6;

INSERT INTO ACCOUNTS_6 VALUES('a1523','checking',2000.00,'c1');
INSERT INTO ACCOUNTS_6 VALUES('a2134','saving',5000.00,'c1');
INSERT INTO ACCOUNTS_6 VALUES('a4378','checking',1000.00,'c2');
INSERT INTO ACCOUNTS_6 VALUES('a5363','saving',8000.00,'c2');
INSERT INTO ACCOUNTS_6 VALUES('a7236','checking',500.00,'c33');
INSERT INTO ACCOUNTS_6 VALUES('a8577','checking',150.00,'c20');

SELECT * FROM ACCOUNTS_6;

SELECT * FROM TOTALS_6;

UPDATE ACCOUNTS_6  
    SET amount = 1000
    WHERE accountno = 'a1523';

SELECT * FROM ACCOUNTS_6;

SELECT * FROM TOTALS_6;

-- Exercise 5
CREATE OR REPLACE TRIGGER NoUpdatePK_trig
AFTER UPDATE ON BANKCUST_6
FOR EACH ROW
BEGIN
    IF UPDATING ('custno') THEN
        raise_application_error (-20999, 'Cannot update a Primary Key');
    END IF;
END;
/
show errors;

UPDATE BANKCUST_6
    SET custno = 'c99'
    WHERE custno = 'c1';