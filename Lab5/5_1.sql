-- Exercise 1
Create or Replace Procedure DisplayMessage(message in VARCHAR)
As
BEGIN
	DBMS_OUTPUT.put_line('Hello '||message);

END;
/
Show Errors;

SET SERVEROUTPUT ON

exec DisplayMessage('include a message');

-- Exercise 2
SELECT ROUND(DBMS_RANDOM.value (10,100)) from DUAL;

-- Exercise 3
UPDATE AlphaCoEmp
    SET salary = 0;

Create or Replace Procedure setSalaries(low in INTEGER, high in INTEGER)
As
Cursor Emp_cur IS
	Select * from AlphaCoEmp;
	-- Local variables
	l_emprec Emp_cur%rowtype;
	
	l_salary AlphaCoEmp.salary%type;
BEGIN
	for l_emprec IN Emp_cur
	loop
		l_salary := ROUND(dbms_random.value(low,high));
		
		 update AlphaCoEmp
		 set salary = l_salary
		 where name = l_emprec.name;
		 
   END LOOP;
   commit;
END;
/
show errors;

exec setSalaries (50000,100000);

SELECT * FROM AlphaCoEmp;

-- Exercise 4
SELECT name, salary FROM AlphaCoEmp
    WHERE salary > 60000
    AND salary < 80000;

-- Exercise 5
Create or Replace Procedure setEmpSalary(p_name in VARCHAR, low in INTEGER, high in INTEGER)
As
	/* Define the local variables you need */
    l_salary AlphaCoEmp.salary%type;
	
BEGIN
	/* since name is a primary key, set the salary 
	Of the employee where name = p_name. 
	
	With an update statement, set the salary of that employee
	With a randomly generated value between the low and high passed 
	In as parameters
	*/
    l_salary := ROUND(dbms_random.value(low,high));
    update AlphaCoEmp
        set salary = l_salary
        where name = p_name;
	commit;
END;
/
show errors;

exec setEmpSalary ('Williams', 70000, 80000);

-- Exercise 6
Create or Replace FUNCTION getEmpSalary(p_name in VARCHAR)
Return NUMBER IS

	/* Define the local variables you need. 
You need a variable to hold the salary returned	 */

	l_salary AlphaCoEmp.salary%type;
	
BEGIN
/* Two things are missing from the below statement (hint: how are you saving the result into l_salary?)*/
	Select salary INTO l_salary
	from AlphaCoEmp
	where name = p_name;

   	return l_salary;
END;
/
show errors;

SELECT getEmpSalary('Williams') FROM Dual;

-- Exercise 7
Create or Replace Procedure assignJobTitlesAndSalaries 
As 
type titlesList IS VARRAY(5) OF AlphaCoEmp.title%type; 
type salaryList IS VARRAY(5) of AlphaCoEmp.salary%type; 
v_titles titlesList; 
v_salaries salaryList; 
Cursor Emp_cur IS 
Select * from AlphaCoEmp; 
l_emprec Emp_cur%rowtype; 
l_title AlphaCoEmp.title%type; 
l_salary AlphaCoEmp.salary%type; 
l_randomnumber INTEGER := 1; 
BEGIN 
/* Titles are stored in the v_titles array  */
/* Salaries for each title are stored in the v_salaries array.
The salary of v_titles[0] title is at v_salaries[0].
*/
v_titles := titlesList('advisor', 'director', 'assistant', 'manager', 'supervisor'); 

v_salaries := salaryList(130000, 100000, 600000, 500000, 800000);

/* use a for loop to iterate through the set  */
for l_emprec IN Emp_cur 
LOOP 
	/* We get a random number between 1-5 both inclusive */
l_randomnumber := dbms_random.value(1,5);
 
/* Get the title using the random value as the index into the
v_tiles array */
l_title := v_titles(l_randomnumber);
/* Get the salary using the same random value as the index into the v_salaries array */
l_salary := v_salaries(l_randomnumber); 

	/* Update the employee title and salary using the l_title 
and l_salary */
update AlphaCoEmp 
set title = l_title 
where name = l_emprec.name;  

update AlphaCoEmp 
set salary = l_salary 
where name = l_emprec.name; 

END LOOP; 

commit; 
END; 
/ 
Show errors; 

exec assignJobTitlesAndSalaries;

SELECT * FROM AlphaCoEmp;

Create or Replace Procedure assignJobTitlesAndSalaries 
As 
type titlesList IS VARRAY(6) OF AlphaCoEmp.title%type; 
type salaryList IS VARRAY(6) of AlphaCoEmp.salary%type; 
v_titles titlesList; 
v_salaries salaryList; 
Cursor Emp_cur IS 
Select * from AlphaCoEmp; 
l_emprec Emp_cur%rowtype; 
l_title AlphaCoEmp.title%type; 
l_salary AlphaCoEmp.salary%type; 
l_randomnumber INTEGER := 1; 
BEGIN 
/* Titles are stored in the v_titles array  */
/* Salaries for each title are stored in the v_salaries array.
The salary of v_titles[0] title is at v_salaries[0].
*/
v_titles := titlesList('advisor', 'director', 'assistant', 'manager', 'supervisor', 'engineer'); 

v_salaries := salaryList(130000, 100000, 600000, 500000, 800000, 200000);

/* use a for loop to iterate through the set  */
for l_emprec IN Emp_cur 
LOOP 
	/* We get a random number between 1-5 both inclusive */
l_randomnumber := dbms_random.value(1,6);
 
/* Get the title using the random value as the index into the
v_tiles array */
l_title := v_titles(l_randomnumber);
/* Get the salary using the same random value as the index into the v_salaries array */
l_salary := v_salaries(l_randomnumber); 

	/* Update the employee title and salary using the l_title 
and l_salary */
update AlphaCoEmp 
set title = l_title 
where name = l_emprec.name;  

update AlphaCoEmp 
set salary = l_salary 
where name = l_emprec.name; 

END LOOP; 

commit; 
END; 
/ 
Show errors; 

exec assignJobTitlesAndSalaries;

SELECT * FROM AlphaCoEmp;

-- Exercise 8
Create or Replace Function calcSalaryRaise( p_name in AlphaCoEmp.name%type, percentRaise IN NUMBER) 
RETURN NUMBER 
IS 
l_salary AlphaCoEmp.salary%type; 
l_raise AlphaCoEmp.salary%type; 
l_cnt Integer; 
BEGIN 
-- Find the current salary of p_name from AlphaCoEMP table. 
Select salary into l_salary from AlphaCoEmp 
where name = p_name; 
-- Calculate the raise amount 
l_raise := l_salary * (percentRaise/100); 

-- Check if the p_name is in Emp_Work table. 
-- If so, add a $1000 bonus to the 
-- raise amount 
Select count(*) into l_cnt from Emp_Work 
where name = p_name; 
if l_cnt >= 1 THEN 
l_raise := l_raise + 1000; 
End IF; 
      /* return a value from the function */
return l_raise;
 
END; 
/ 
Show Errors;

SELECT calcSalaryRaise('Stone', 2) FROM Dual;

SELECT name, title, salary CURRENTSALARY, (salary + trunc(calcSalaryRaise(name, 2))) NEWSALARY
    FROM AlphaCoEmp
    WHERE upper(name) = upper('Stone');

Create or Replace Function calcSalaryRaise( p_name in AlphaCoEmp.name%type, percentRaise IN NUMBER) 
RETURN NUMBER 
IS 
l_salary AlphaCoEmp.salary%type; 
l_raise AlphaCoEmp.salary%type; 
l_cnt Integer; 
BEGIN 
-- Find the current salary of p_name from AlphaCoEMP table. 
Select salary into l_salary from AlphaCoEmp 
where upper(name) = upper(p_name); 
-- Calculate the raise amount 
l_raise := l_salary * (percentRaise/100); 

-- Check if the p_name is in Emp_Work table. 
-- If so, add a $1000 bonus to the 
-- raise amount 
Select count(*) into l_cnt from Emp_Work 
where upper(name) = upper(p_name); 
if l_cnt >= 1 THEN 
l_raise := l_raise + 1000; 
End IF; 
      /* return a value from the function */
return l_raise;
 
END; 
/ 
Show Errors;

SELECT calcSalaryRaise('Stone', 2) FROM Dual;

SELECT name, title, salary CURRENTSALARY, (salary + trunc(calcSalaryRaise(name, 2))) NEWSALARY
    FROM AlphaCoEmp
    WHERE upper(name) = upper('Stone');

-- Exercise 9
CREATE TABLE EmpStats (
    title VARCHAR(20) PRIMARY KEY,
    empcount INTEGER,
    lastModified DATE
);

Create or Replace Function countByTitle(p_title in AlphaCoEmp.title%type) 
RETURN NUMBER IS
l_cnt Integer; 
BEGIN 
	/* Complete the query below */ 
    Select COUNT(*) into l_cnt from AlphaCoEmp 
    Group by title
    Having title = p_title;
    return l_cnt; 
END; 
/ 
show errors;

SELECT countByTitle('director') FROM Dual;
SELECT countByTitle('advisor') FROM Dual;

-- Exercise 10
CREATE or REPLACE procedure saveCountByTitle 
AS 
l_advisor_cnt integer := 0; 
l_director_cnt integer := 0; 
l_assistant_cnt integer := 0; 
l_manager_cnt integer := 0; 
l_supervisor_cnt integer := 0; 
l_engineer_cnt integer := 0; 

BEGIN 
    l_advisor_cnt := countByTitle('advisor'); 
    l_director_cnt := countByTitle('director');
    l_assistant_cnt := countByTitle('assistant');
    l_manager_cnt := countByTitle('manager');
    l_supervisor_cnt := countByTitle('supervisor');
    l_engineer_cnt := countByTitle('engineer');

    delete from EmpStats; -- Any previously loaded data is deleted 
    /* inserting count of employees with title, ‘advisor’.*/ 
    insert into EmpStats values ('advisor',l_advisor_cnt,SYSDATE); 
    insert into EmpStats values ('director',l_director_cnt,SYSDATE); 
    insert into EmpStats values ('assistant',l_assistant_cnt,SYSDATE); 
    insert into EmpStats values ('manager',l_manager_cnt,SYSDATE); 
    insert into EmpStats values ('supervisor',l_supervisor_cnt,SYSDATE); 
    insert into EmpStats values ('engineer',l_engineer_cnt,SYSDATE); 
END; 
/ 
Show errors; 

exec saveCountByTitle;

SELECT * FROM EmpStats;