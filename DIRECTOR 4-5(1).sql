select *
from sys.employee;

--i. D�ng t�i kho?n Director g�n c�c quy?n cho ph�p Admin c� th? t?o v� x�a c�c b?ng trong Company
--v� cho ph�p Admin c� th? c?p l?i c�c quy?n �� cho user kh�c.
grant create table, drop any table to Admin with admin option;

SELECT * FROM USER_TAB_PRIVS;
select * from USER_ROLE_PRIVS where USERNAME='director';
select * from USER_TAB_PRIVS where Grantee = 'DIRECTOR';
select * from USER_SYS_PRIVS where USERNAME = 'SAMPLE';

