--a) nhan vien co sex la male trong department research, lam it nhat 1 project hon 10h
select distinct fname, minit, lname
from employee , department, works_on
where sex = 'M' and dno = dnumber and dname='Research' and ssn = essn and hours >= 10;

--b) T?m t�n c?a t?t c? employee ��?c gi�m s�t tr?c ti?p b?i manager c?a ph?ng ban �Research�.
select distinct fname, minit, lname
from employee, department
where dno = dnumber and dname='Research' and superssn = mgrssn;

--c) V?i m?i project, li?t k� t�n project, v� t?ng s? gi? m?t tu?n m� t?t c? nh�n vi�n ph?i l�m cho project ��.
select pnumber, pname, sum(hours)
from project, works_on
where pnumber = pno
group by pnumber, pname; 

--d. V?i m?i ph?ng ban, li?t k� t�n ph?ng ban v� t�n c?a t?t c? c�c employee l�m vi?c cho ph?ng ban ��.
select dname, fname, minit, lname
from employee, department
where dno = dnumber
order by department.dname asc;


--e. Li?t k� t�n c?a t?t c? employee kh�ng l�m b?t c? project n�o ? �Houston�.
select ssn
from employee
where ssn not in (
select distinct fname, minit, lname
from employee, works_on, project
where ssn = essn and pno = pnumber and plocation = 'Houston');

--f. Li?t k� t�n c?a t?t c? employee l�m vi?c cho t?t c? c�c project ? �Houston�.
select distinct fname, minit, lname
from employee, works_on, project
where ssn = essn and pno = pnumber and plocation = 'Houston';

--g. T?m c�c employee c� t?ng s? d? �n tham gia nhi?u nh?t trong c�ng ty.
--select max(num)
--from
select ssn, num
from (select ssn, count(*) as num
    from employee, works_on
    where ssn = essn
    group by ssn
    ),
    (select max(count(*)) as maxi
    from employee, works_on
    where ssn = essn
    group by ssn)
where num=maxi;
-- len hoi co lam sao de co the gan cho 1 select


--h. Li?t k� t�n c�c employee c� l��ng cao nh?t trong m?i ph?ng ban.

select fname, minit, lname
from employee,
  (select dno, max(salary) as max_sal
  from employee 
  group by dno)
where salary=max_sal;

--i. V?i m?i ph?ng ban, t?m c�c employee c� t?ng s? d? �n tham gia nhi?u nh?t trong ph?ng ban ��.
select ssn, fname, minit, lname, count(*) as num_proj
from employee , works_on
where ssn= essn
group by(ssn, fname, minit, lname);

select dno, max(num_proj) as maxi
from
  (select ssn, dno, count(*) as num_proj
  from employee, works_on
  where ssn = essn
  group by ssn, dno)
group by dno;

select ssn, fname, minit, lname
from (
      select dno, max(num_proj) as maxi
      from
        (select ssn, dno, count(*) as num_proj
        from employee, works_on
        where ssn = essn
        group by ssn, dno)
        group by dno) D,
        (select ssn, fname, minit, lname, count(*) as num_proj
        from employee , works_on
        where ssn= essn
        group by(ssn, fname, minit, lname)) E
where num_proj = maxi;


--j. Li?t k� last name c?a t?t c? c�c manager c?a c�c department nh�ng kh�ng tham gia project n�o.
select fname, minit, lname, count(*)
from employee, department, works_on
where ssn = mgrssn and ssn = essn
group by ssn, fname, minit, lname
having count(*) = 0;

--VIET LENH CAP NHAT DU LIEU
--a. Nh�n vi�n c� m? l� �123456789� thay �?i �?a ch? th�nh �123 L? Th�?ng Ki?t F.14 Q.10�.  
update employee 
set address = '123L?Th�?ngKi?F.14 Q.10'
where ssn='123456789';

--b. M?i quan h? c?a nh�n vi�n �Franklin� v?i ng�?i ph? thu?c �Joy� thay �?i th�nh �Friend�.
update dependent
set relationship = 'Friend'
where (essn, dependent_name) in (
select essn, dependent.dependent_name
from employee, dependent
where fname ='Franklin' and ssn = essn and dependent.dependent_name = 'Joy');

--c. T?t c? nh�n vi�n c?a ph?ng ban c� �t nh?t m?t v? tr� ? �Houston� ��?c t�ng l��ng g?p ��i.
update employee
set salary = salary*2
where ssn in(
  select distinct ssn
  from employee, dept_locations
  where dno = dnumber and dept_locations.dlocation ='Houston'
);

--d. Tr? 5% l��ng cho c�c nh�n vi�n c� t?ng s? d? �n tham gia �t h�n 2.
update employee
set salary = 0.95*salary
where ssn in(
    select ssn
    from employee, works_on
    where ssn = essn
    group by ssn
    having count(*) < 2);

--VIET CAU LENH XOA DU LIEU
--a. X�a nh?ng th�n nh�n c?a nh�n vi�n c� t�n l� �Alice".
delete from dependent
where (essn, dependent_name) in(
        select essn, dependent_name
        from employee, dependent
        where fname = 'Alice' and essn = ssn
    );

--b)X�a d? �n �Product Z�.
delete from project
where pname='ProductZ';



