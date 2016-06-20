select essn, sum(hours)
from works_on
where essn ='123456789'
group by essn;

select pnumber from project;
select ssn from employee;

select * from works_on;
insert into works_on
values('123456789', '30', '20');

delete from works_on
where essn =  '123456789' and pno='30';

--test for update tuoi, hay insert nhan vien
update employee
set bdate ='01-11-1999'
where ssn ='123456789';

INSERT INTO Employee VALUES ('Hung', 'B', 'Smith', '123456888', '09-01-1998', '731 Fondren, Houston, TX', 'M', 30000, '333445555', 5);
rollback;

update works_on
set hours='10'
where essn ='333445555' and pno = '2';


-- viet ham xu li viec them vao mot nhan vien
exec addnewemployee('loc','T', 'dinh', '112233445', '06-06-1993', 'tan phu', 'F', 80000,'Franklin' , 'T', 'Wong','Research') ;
delete from employee
where ssn = '112233445';

--tinh so luong project lam cua nhan vien
select getCountproject('333445555') from dual;

--cau lenh dung de lay ve bang trong ham printemployee2
select * from table(printemployee2);
exec showemployee;




