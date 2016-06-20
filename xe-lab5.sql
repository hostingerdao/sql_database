create table test(
id char(3) primary key,
name varchar(3) not null);

insert into test values('abc','det');

select * from test;