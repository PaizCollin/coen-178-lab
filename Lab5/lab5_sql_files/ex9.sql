Create or Replace Function countByTitle(p_title in AlphaCoEmp.title%type) 
RETURN NUMBER IS 
l_cnt Integer; 
BEGIN
	/* Complete the query below */ 
Select into l_cnt from AlphaCoEmp 
Group by 
Having 
return l_cnt; 
END; 
/ 
show errors;

