create user locdinh identified by tanloc123
default tablespace locdinh_tablespace
temporary tablespace locdinh_tablespace_temp;

grant create session to locdinh;
grant create table to locdinh;
grant unlimited tablespace to locdinh;