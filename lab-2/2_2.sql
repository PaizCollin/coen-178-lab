-- Part 2)
-- a) Show all data in Customer Table
SELECT * FROM Customer;

-- b) Show all data in DeliveryService Table
SELECT * FROM DeliveryService;

-- c) Show all data in Schedule Table
SELECT * FROM Schedule;

-- d)
SELECT custid, firstname || lastname AS fullname, city 
    FROM Customer;

-- e)
SELECT * FROM Customer
    ORDER BY lastname;

-- f)
SELECT * FROM Schedule
    ORDER BY serviceid, custid DESC;

-- g)
SELECT serviceid FROM DeliveryService
    WHERE serviceid NOT IN (SELECT serviceid FROM schedule);

-- h)
SELECT firstname FROM Customer, Schedule
    WHERE day = 'M';

SELECT firstname 
    FROM Customer
    JOIN Schedule
    ON Customer.custid = Schedule.custid
    WHERE day = 'm';

-- i)
SELECT lastname 
    FROM Customer 
    JOIN Schedule
    ON Customer.custid = Schedule.custid;

-- j)
SELECT MAX(servicefee) AS highest_ServiceFee 
    FROM DeliveryService;

-- k)
SELECT COUNT(*) FROM Schedule
    GROUP BY(day);

SELECT DISTINCT A.custid, B.custid, A.city
    FROM Customer A, Customer b
    WHERE A.city = B.city
    AND A.custid != B.custid;

--l)
SELECT firstname || lastname AS fullname
    FROM Customer
    JOIN Schedule
    ON Customer.custid = Schedule.custid
    JOIN DeliveryService
    ON Schedule.serviceid = DeliveryService.serviceid
    WHERE Customer.city = DeliveryService.location;

-- m)
SELECT MIN(salary) AS min_Salary, MAX(salary) AS max_Salary
    FROM Staff;