--LAB 6
--1. VIEW

--a)
--create view employee1 as
select ssn, fname, minit, lname, pnumber, pname, hours
from employee, works_on, project
where ssn = essn and pno = pnumber and plocation = 'Houston';

--b. T?o view (h? tên nhân viên, tên ngý?i ph? thu?c, ngày sinh) ch?a thông tin các con dý?i 18 tu?i
--c?a các nhân viên (tính ð?n nãm hi?n t?i).

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

--c)T?o view ch?a thông tin (h? tên nhân viên, ngày sinh, gi?i tính) c?a các nhân viên có ngày sinh
--trong tháng 7. View này ch? cho phép ð?c
select fname, minit, lname, sex
from employee E1, (
select ssn, extract(month from bdate) thang
from employee) E2
where E1.ssn = E2.ssn and thang = 7;

--TRIGGER
--a. T?ng s? gi? làm vi?c c?a nhân viên không ðý?c phép dý?i 24 gi?/tu?n và quá 48 gi? / tu?n ð?i
--v?i t?t c? d? án. Vi?t trigger ð? ki?m tra ràng bu?c này.
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








