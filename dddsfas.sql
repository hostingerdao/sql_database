create or replace function showname(id employee.ssn%type)
return varchar2
is
  ret varchar2(100);
begin
  select fname||' '|| minit||' '|| lname into ret
  from employee
  where ssn = id;
  return ret;
end;