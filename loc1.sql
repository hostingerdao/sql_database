alter user Admin identified by Admin 
quota 5m on users
temporary tablespace temp
account unlock;

grant insert(salary) on employee to Accountant;

select * from USER_TAB_PRIVS where Grantee = 'DIRECTOR';

--2.
--a.
UPDATE Employee SET salary = salary*1.3;
SAVEPOINT inc_sal_13;

--b.
UPDATE Employee SET salary = salary*1.15;
SAVEPOINT inc_sal_15;

--c.
rollback to inc_sal_30;

--d.
UPDATE Employee SET salary = salary*0.9;
SAVEPOINT dec_sal_10;

--e.
rollback;


--f.
UPDATE Employee SET salary = salary*1.1;
commit;
rollback;
--e.
UPDATE Employee SET salary = 100000 where ssn ='123456789';
rollback;

select ssn, salary 
from Employee;

commit;

