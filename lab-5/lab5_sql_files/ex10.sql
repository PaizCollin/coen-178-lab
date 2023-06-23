CREATE or REPLACE procedure saveCountByTitle 
AS 
l_advisor_cnt integer := 0; 
BEGIN 
l_advisor_cnt := countByTitle('advisor'); 

delete from EmpStats; -- Any previously loaded data is deleted 
/* inserting count of employees with title, ‘advisor’.*/ 
insert into EmpStats values ('advisor',l_advisor_cnt,SYSDATE); 
END; 
/ 
Show errors; 

