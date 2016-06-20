--a) nhan vien co sex la male trong department research, lam it nhat 1 project hon 10h
select distinct fname, minit, lname
from employee , department, works_on
where sex = 'M' and dno = dnumber and dname='Research' and ssn = essn and hours >= 10;

--b) T?m tên c?a t?t c? employee ðý?c giám sát tr?c ti?p b?i manager c?a ph?ng ban “Research”.
select distinct fname, minit, lname
from employee, department
where dno = dnumber and dname='Research' and superssn = mgrssn;

--c) V?i m?i project, li?t kê tên project, và t?ng s? gi? m?t tu?n mà t?t c? nhân viên ph?i làm cho project ðó.
select pnumber, pname, sum(hours)
from project, works_on
where pnumber = pno
group by pnumber, pname; 

--d. V?i m?i ph?ng ban, li?t kê tên ph?ng ban và tên c?a t?t c? các employee làm vi?c cho ph?ng ban ðó.
select dname, fname, minit, lname
from employee, department
where dno = dnumber
order by department.dname asc;


--e. Li?t kê tên c?a t?t c? employee không làm b?t c? project nào ? “Houston”.
select ssn
from employee
where ssn not in (
select distinct fname, minit, lname
from employee, works_on, project
where ssn = essn and pno = pnumber and plocation = 'Houston');

--f. Li?t kê tên c?a t?t c? employee làm vi?c cho t?t c? các project ? “Houston”.
select distinct fname, minit, lname
from employee, works_on, project
where ssn = essn and pno = pnumber and plocation = 'Houston';

--g. T?m các employee có t?ng s? d? án tham gia nhi?u nh?t trong công ty.
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


--h. Li?t kê tên các employee có lýõng cao nh?t trong m?i ph?ng ban.

select fname, minit, lname
from employee,
  (select dno, max(salary) as max_sal
  from employee 
  group by dno)
where salary=max_sal;

--i. V?i m?i ph?ng ban, t?m các employee có t?ng s? d? án tham gia nhi?u nh?t trong ph?ng ban ðó.
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


--j. Li?t kê last name c?a t?t c? các manager c?a các department nhýng không tham gia project nào.
select fname, minit, lname, count(*)
from employee, department, works_on
where ssn = mgrssn and ssn = essn
group by ssn, fname, minit, lname
having count(*) = 0;

--VIET LENH CAP NHAT DU LIEU
--a. Nhân viên có m? là “123456789” thay ð?i ð?a ch? thành “123 L? Thý?ng Ki?t F.14 Q.10”.  
update employee 
set address = '123L?Thý?ngKi?F.14 Q.10'
where ssn='123456789';

--b. M?i quan h? c?a nhân viên “Franklin” v?i ngý?i ph? thu?c “Joy” thay ð?i thành “Friend”.
update dependent
set relationship = 'Friend'
where (essn, dependent_name) in (
select essn, dependent.dependent_name
from employee, dependent
where fname ='Franklin' and ssn = essn and dependent.dependent_name = 'Joy');

--c. T?t c? nhân viên c?a ph?ng ban có ít nh?t m?t v? trí ? “Houston” ðý?c tãng lýõng g?p ðôi.
update employee
set salary = salary*2
where ssn in(
  select distinct ssn
  from employee, dept_locations
  where dno = dnumber and dept_locations.dlocation ='Houston'
);

--d. Tr? 5% lýõng cho các nhân viên có t?ng s? d? án tham gia ít hõn 2.
update employee
set salary = 0.95*salary
where ssn in(
    select ssn
    from employee, works_on
    where ssn = essn
    group by ssn
    having count(*) < 2);

--VIET CAU LENH XOA DU LIEU
--a. Xóa nh?ng thân nhân c?a nhân viên có tên là “Alice".
delete from dependent
where (essn, dependent_name) in(
        select essn, dependent_name
        from employee, dependent
        where fname = 'Alice' and essn = ssn
    );

--b)Xóa d? án “Product Z”.
delete from project
where pname='ProductZ';



