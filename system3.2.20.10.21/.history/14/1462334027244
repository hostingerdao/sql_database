select *
from sys.employee;

--i. Dùng tài kho?n Director gán các quy?n cho phép Admin có th? t?o và xóa các b?ng trong Company
--và cho phép Admin có th? c?p l?i các quy?n ðó cho user khác.
grant create table, drop any table to Admin with admin option;

SELECT * FROM USER_TAB_PRIVS;
select * from USER_ROLE_PRIVS where USERNAME='director';
select * from USER_TAB_PRIVS where Grantee = 'DIRECTOR';
select * from USER_SYS_PRIVS where USERNAME = 'SAMPLE';

