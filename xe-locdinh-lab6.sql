--LAB 6
--1. VIEW

--a)
--create view employee1 as
select ssn, fname, minit, lname, pnumber, pname, hours
from employee, works_on, project
where ssn = essn and pno = pnumber and plocation = 'Houston';

--b. T?o view (h? t�n nh�n vi�n, t�n ng�?i ph? thu?c, ng�y sinh) ch?a th�ng tin c�c con d�?i 18 tu?i
--c?a c�c nh�n vi�n (t�nh �?n n�m hi?n t?i).

--Tinh tuoi hien tai
select trunc(months_between(sysdate,bdate)/12) year,
           trunc(mod(months_between(sysdate,bdate),12)) month,
           trunc(sysdate-add_months(bdate,trunc(months_between(sysdate,bdate)/12)*12+trunc(mod(months_between(sysdate,bdate),12)))) day
    from (Select bdate from dependent);
--Answer
select fname, minit, lname, dependent_name, D.bdate
from employee, (
      select essn, dependent_name, bdate, trunc(months_between(sysdate,bdate)/12) year
      from dependent) D
where ssn = essn and year > 18;

--c)T?o view ch?a th�ng tin (h? t�n nh�n vi�n, ng�y sinh, gi?i t�nh) c?a c�c nh�n vi�n c� ng�y sinh
--trong th�ng 7. View n�y ch? cho ph�p �?c
select fname, minit, lname, sex
from employee E1, (
select ssn, extract(month from bdate) thang
from employee) E2
where E1.ssn = E2.ssn and thang = 7;

--TRIGGER
--a. T?ng s? gi? l�m vi?c c?a nh�n vi�n kh�ng ��?c ph�p d�?i 24 gi?/tu?n v� qu� 48 gi? / tu?n �?i
--v?i t?t c? d? �n. Vi?t trigger �? ki?m tra r�ng bu?c n�y.
select essn, sum(hours)
from works_on
group by (essn);

create or replace trigger gioihan
after insert or update
on works_on for each row
declare
min_hours works_on.hours%type := 20;
max_hours works_on.hours%type := 48;
n_essn works_on.essn%type;
n_hours works_on.hours%type;
begin
select essn, total_hours into n_essn, n_hours 
from works_on
where essn = new.essn
group by (essn);

if  n_hours < min_hours and n_hours > max_hours
then
  raise_application_erro(-2000, 'Tong so gio lam viec khong phu hop');
end if;
end;








