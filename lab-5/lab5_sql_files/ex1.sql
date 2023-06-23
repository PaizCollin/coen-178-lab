Create or Replace Procedure DisplayMessage(message in VARCHAR)
As
BEGIN
	DBMS_OUTPUT.put_line('Hello '||message);

END;
/
Show Errors;
