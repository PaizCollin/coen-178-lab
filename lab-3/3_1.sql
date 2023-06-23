-- Part 1
-- Create table L_EMP
CREATE TABLE L_EMP (
    empNo INTEGER PRIMARY KEY,
    empname VARCHAR(10),
    deptId VARCHAR(5)
);

-- Create table L_DEPT
CREATE TABLE L_DEPT (
    deptId VARCHAR(5) PRIMARY KEY,
    deptname VARCHAR(10),
    budget NUMBER(10,2)
);

-- Insert tuples
insert into L_EMP values(1,'smith','d1');
insert into L_EMP values(2,'jones','d2');
insert into L_EMP values(3,'wayne','d1');
insert into L_EMP values(4,'moor','d3');
insert into L_EMP values(5,'king','d1');
insert into L_EMP values(6,'chen','d1');
insert into L_EMP values(7,'winger','d3');

insert into L_DEPT values('d1','Research',200000);
insert into L_DEPT values('d2','Devt',600000);
insert into L_DEPT values('d3','Testing',100000);
insert into L_DEPT values('d4','Advert',700000);
insert into L_DEPT values('d9','HR',700000);

-- Ensure data has been entered
SELECT * FROM L_EMP;
SELECT * FROM L_DEPT;

-- Exercise 1
SELECT empno, empname
    FROM L_EMP, L_DEPT
    WHERE deptname = 'Research';

-- Exercise 2
SELECT empno, empname
    FROM L_EMP, L_DEPT
    Where L_EMP.deptid = L_Dept.deptid 
    AND deptname='Research';

-- Exercise 3
SELECT empno, empname
    FROM L_EMP
    WHERE L_EMP.deptid = (SELECT deptid 
        FROM L_Dept 
        WHERE deptname='Research');

-- Exercise 4
SELECT empno, empname
    FROM L_EMP
    WHERE L_EMP.deptId = (SELECT deptId 
        FROM L_Dept 
        WHERE budget > 100000);

-- Exercise 5
SELECT empno, empname
    FROM L_EMP
    WHERE L_EMP.deptid 
    IN (SELECT deptid 
        FROM L_Dept 
        WHERE budget > 100000);

-- Exercise 6
SELECT deptname 
    FROM L_DEPT
    WHERE budget = (SELECT max(budget)
        FROM L_DEPT);

-- Exercise 7
SELECT deptname 
    FROM L_DEPT
    WHERE budget >= all(SELECT budget
        FROM L_DEPT);

-- Exercise 8
SELECT COUNT(*) LargeBudgetDepts
    FROM L_DEPT
    WHERE budget > 10000;

-- Exercise 9
SELECT budget Budget, COUNT(*) HowMany 
    FROM L_DEPT
    WHERE budget > 100000
    GROUP BY(budget);

insert into L_DEPT values('d5','Training',400000);
insert into L_DEPT values('d6','Storage',100000);
insert into L_DEPT values('d7','Management',600000);
insert into L_DEPT values('d8','Maintain',500000);

SELECT budget Budget, COUNT(*) HowMany 
    FROM L_DEPT
    WHERE budget > 100000
    GROUP BY(budget);

-- Exercise 10
SELECT budget Budget, COUNT(*) EqualOrGreaterThan2
    FROM L_DEPT
    WHERE budget > 100000
    GROUP BY(budget)
    HAVING COUNT(*) >=2; 

-- Part 2 
-- Exercise 11
SELECT first || last AS fullname
    FROM Staff
    WHERE salary = (SELECT max(salary)
        FROM Staff);

-- Exercise 12
SELECT last, salary
    FROM Staff
    WHERE salary = (SELECT salary  
        FROM Staff
        WHERE last = 'Zichal');

SELECT last, salary
    FROM Staff
    WHERE salary = (SELECT salary  
        FROM Staff
        WHERE UPPER(last) LIKE UPPER('Zichal'));

SELECT last, salary
    FROM Staff
    WHERE salary = (SELECT salary  
        FROM Staff
        WHERE UPPER(last) LIKE UPPER('Young'));

SELECT last, salary
    FROM Staff
    WHERE salary IN (SELECT salary  
        FROM Staff
        WHERE UPPER(last) LIKE UPPER('Young'));

-- Exercise 13
SELECT salary, COUNT(*) Salaries_100k_Above
    FROM Staff
    WHERE salary > 100000
    GROUP BY(salary);

-- Exercise 14
SELECT salary, COUNT(*) Salaries_100k_Above
    FROM Staff
    WHERE salary > 100000
    GROUP BY(salary)
    HAVING COUNT(*) >= 10;

-- Exercise 15
SELECT deptId
    FROM L_EMP
    GROUP BY(deptid)
    HAVING COUNT(*) IN (SELECT MAX(COUNT(*)) employees
        FROM L_EMP GROUP BY (deptId));

