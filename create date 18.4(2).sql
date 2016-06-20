ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';
--29-----------------------------------------------------------------------------------------------------
create table ThanhPho (
MaTP char(6) primary key, 
TenTP varchar(30) unique,
constraint format_thanhpho check( regexp_like(matp,'^TP\d{4}$'))
);

insert into thanhpho values('TP0001', 'Ho Chi Minh');
insert into thanhpho values('TP0002', 'Ha Noi');
insert into thanhpho values('TP0003', 'Quy Nhon');
insert into thanhpho values('TP0004', 'Binh Duong');
insert into thanhpho values('TP0005', 'Vung Tau');
insert into thanhpho values('TP0006', 'Da Nang');
--29 end ------------------------------------------------------------------------------------------------


--30-----------------------------------------------------------------------------------------------------
create table Quan (
MaQuan char(5) primary key, 
TenQuan varchar(30) not null, 
MaTP char(6) not null,
constraint fk_Quan_ThanhPho_matp foreign key (matp) references thanhpho(matp) on delete cascade,
constraint format_Quan check( regexp_like(maQuan,'^Q\d{4}$'))
);


insert into quan values('Q0001', 'Quan 1', 'TP0001');
insert into quan values('Q0002', 'Quan 2', 'TP0001');
insert into quan values('Q0003', 'Quan 3', 'TP0002');
insert into quan values('Q0004', 'Quan 4', 'TP0002');
insert into quan values('Q0005', 'Quan 5', 'TP0003');
insert into quan values('Q0006', 'Quan 6', 'TP0003');
--30 end ------------------------------------------------------------------------------------------------


--31-----------------------------------------------------------------------------------------------------
create table Phuong (
MaPhuong char(5) primary key, 
TenPhuong varchar(30) not null, 
MaQuan char(5) not null,
constraint fk_Quan_MaQuan foreign key (maquan) references Quan(maquan) on delete cascade,
constraint format_MaPhuong check( regexp_like(maPhuong,'^P\d{4}$'))
);

insert into Phuong values('P0001', 'Phuong 1', 'Q0001');
insert into Phuong values('P0002', 'Phuong 2', 'Q0001');
insert into Phuong values('P0003', 'Phuong 3', 'Q0002');
insert into Phuong values('P0004', 'Phuong 4', 'Q0002');
insert into Phuong values('P0005', 'Phuong 5', 'Q0003');
insert into Phuong values('P0006', 'Phuong 6', 'Q0003');
--31 end ------------------------------------------------------------------------------------------------


--32-----------------------------------------------------------------------------------------------------
 create table Duong (
 MaDuong char(5) primary key, 
 TenDuong varchar(30),
 constraint format_duong check( regexp_like(maduong,'^D\d{4}$'))
 );
 
 insert into Duong values ( 'D0001', 'Nguyen Trai');
 insert into Duong values ( 'D0002', 'Ly Thuong Kiet');
 insert into Duong values ( 'D0003', 'Tran Hung Dao');
 insert into Duong values ( 'D0004', 'Le Trong Tan');
 insert into Duong values ( 'D0005', 'Nguyen Thuong Hien');
 insert into Duong values ( 'D0006', 'Dien Bien Phu'); 
--32 end ------------------------------------------------------------------------------------------------



--33-----------------------------------------------------------------------------------------------------
 create table DuongThuocPhuong (
 MaDuong char(5), 
 MaPhuong char(5),
 constraint pk_DuongThuocPhuong primary key( maduong, maphuong)
 );
 

insert into DuongThuocPhuong values('D0001', 'P0001');
insert into DuongThuocPhuong values('D0002', 'P0001');
insert into DuongThuocPhuong values('D0003', 'P0001');
insert into DuongThuocPhuong values('D0001', 'P0002');
insert into DuongThuocPhuong values('D0002', 'P0002');
insert into DuongThuocPhuong values('D0003', 'P0002');
--33 end ------------------------------------------------------------------------------------------------



--1------------------------------------------------------------------------------------------------
create table ChiNhanh (
	MaCN int primary key, 
	TenCN varchar(15) unique,
	SoFax varchar(11) ,
  maduong char(5),
  maphuong char(5),
	DiaChi varchar(100), 
	MaNVTruong varchar(10),
  constraint fk_ChiNhanh_MaDuong foreign key (maduong) references duong(maduong) on delete set null,
  constraint fk_ChiNhanh_MaPhuong foreign key (maPhuong) references Phuong(MaPhuong) on delete set null,
  CONSTRAINT format_Chinhanh_SoFax      
      CHECK ( REGEXP_LIKE ( SoFax, '^\d{10,11}$' ) )
);

--create trigger diachi

Insert into chinhanh values(1, 'Phuoc Thien', '0987654321', 'D0001', 'P0001', '', '1');
Insert into chinhanh values(2, 'Tan Hoa', '0987654321', 'D0002', 'P0001', '', '2');
Insert into chinhanh values(3, 'Phat Hoa', '0987654312', 'D0003', 'P0001', '', '3');
Insert into chinhanh values(4, 'Hung Hoa', '0987654322', 'D0001', 'P0002', '', '4');
Insert into chinhanh values(5, 'Thien Ngu', '0987654322', 'D0002', 'P0002', '', '5');
Insert into chinhanh values(6, 'Kim Lang', '09876543289', 'D0003', 'P0003', '', '6');

--1 end------------------------------------------------------------------------------------------------

--2------------------------------------------------------------------------------------------------
create table ChiNhanhSDT (
	MaCN int, 
	SDT varchar(11),
  primary key (macn, sdt),
	constraint fk_ChiNhanhSDT_ChiNhanh_MaCN foreign key(MaCN) references ChiNhanh(MaCN) on delete cascade,
  constraint format_ChinhanhSDT_SDT check (REGEXP_LIKE(SDT, '^\d{10,11}$'))
	);

insert into chinhanhsdt values('1', '01234567886');
insert into chinhanhsdt values('1', '01234567876');
insert into chinhanhsdt values('2', '01234567933');
insert into chinhanhsdt values('2', '01234567966');
insert into chinhanhsdt values('3', '01234567896');
insert into chinhanhsdt values('3', '01234567807');
--2 end------------------------------------------------------------------------------------------------


--3------------------------------------------------------------------------------------------------
create table NhanVien (
MaNV int primary key, 
HoTen varchar(30), 
NgaySinh date, 
CMND varchar(12) not null unique, 
Email varchar(30), 
SDT varchar(11), 
NamVao char(4), 
ChucVu varchar(30), 
Luong decimal(10), 
 maduong char(5),
  maphuong char(5),
DiaChi varchar(100),
MaCN int,
constraint fk_Nhanvien_MaDuong foreign key (maduong) references duong(maduong) on delete set null,
 constraint fk_Nhanvien_MaPhuong foreign key (maPhuong) references Phuong(MaPhuong) on delete set null,
constraint fk_NhanVien_ChiNhanh_MaCN foreign key (MaCN) references Chinhanh(macn) on delete set null,
constraint format_Nhanvien_cmnd check (regexp_like(cmnd,'^\d{9}|\d{11}')),
constraint format_Nhanvien_email check(regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+')),
constraint format_Nhanvien_SDT check (REGEXP_LIKE(SDT, '^\d{10,11}$')),
constraint format_Nhanvien_namvao check(namvao > '1900' and regexp_like(namvao, '^\d{4}$') )
);

create sequence seq_MaNhanVien
minvalue 1
start with 1
increment by 1;

--create trigger ma nhan vien

--create trigger diachi

Insert into nhanvien  
values (1,'Nguyen Van Anh', '11-11-1990', '113456780','nguyenvananh@gmai.com', '0922345678', '2015', 'Truong Chi Nhanh',700000, 'D0001', 'P0001', '', 1 );
Insert into nhanvien  
values (2,'Tran Ba Hung', '10-11-1991', '113456781','hung.tranh@gmai.com', '0932345678', '2014', 'Truong Chi Nhanh',700000, 'D0002', 'P0001', '', 2 );
Insert into nhanvien  
values (3,'Tran Thi Thanh Ly', '20-11-1980', '113456782','lythanh@gmai.com', '0942345678', '2016', 'Truong Chi Nhanh',14000000, 'D0003', 'P0001', '', 3 );
Insert into nhanvien  
values (4,'Phan Quoc Tung', '22-06-1989', '113456783','quoctung@gmai.com', '0952345678', '2010', 'Truong Chi Nhanh',17000000, 'D0001', 'P0001', '', 4 );
Insert into nhanvien  
values (5,'Tran Ba Dao', '11-12-1993', '113456784','badao@gmai.com', '0962345678', '2016', 'Truong Chi Nhanh',17000000, 'D0002', 'P0001', '', 5 );
Insert into nhanvien  
values (6,'Nguyen Hoang Anh', '15-06-1992', '113456785','hoanganh@gmai.com', '0972345678', '2016', 'Truong Chi Nhanh',15000000, 'D0003', 'P0001', '', 6 );
Insert into nhanvien  
values (7,'Luong Thien Cua', '22-12-1988', '113456786','thiencua@gmai.com', '0982345678', '2015', 'Nhan vien',7000000, 'D0001', 'P0002', '', 1 );
Insert into nhanvien  
values (8,'Vuong Quoc Nga', '03-11-168', '113456787','ngaquoc@gmai.com', '0992345678', '2016', 'Nhan vien',8000000, 'D0002', 'P0002', '', 2 );
Insert into nhanvien  
values (9,'Tran Dai Chien', '21-02-1987', '113456788','daichien@gmai.com', '0910345678', '2015', 'Nhan vien',9000000, 'D0002', 'P0002', '', 3 );
Insert into nhanvien  
values (10,'Phan The Hiem', '12-10-1993', '113456789','thehien@gmai.com', '0911345678', '2015', 'Nhan vien',7000000, 'D0001', 'P0002', '', 4 );
Insert into nhanvien  
values (11,'Phan Huynh Chien', '21-02-1987', '113456790','huynhchien@gmai.com', '0910345678', '2015', 'Nhan vien',9000000, 'D0002', 'P0002', '', 3 );
Insert into nhanvien  
values (12,'Luong Ba Hiem', '12-10-1993', '113456791','bahien@gmai.com', '0911345678', '2015', 'Nhan vien',7000000, 'D0001', 'P0002', '', 4 );


--3 end------------------------------------------------------------------------------------------------

create table DoiTac (
MaDT int primary key,
Ten varchar(30) not null unique, 
HoTenNLL varchar(30) not null, 
SDTNLL varchar(11),
maduong char(5),
maphuong char(5),
DiaChi varchar(100), 
MaNV int,
constraint fk_doitac_MaDuong foreign key (maduong) references duong(maduong) on delete set null,
 constraint fk_doitac_MaPhuong foreign key (maPhuong) references Phuong(MaPhuong) on delete set null,
constraint fk_doitac_nhanvien_manv foreign key(manv) references nhanvien(manv) on delete set null,
constraint format_doitac_SDTNLL check (REGEXP_LIKE(SDTNLL, '^\d{10,11}$'))
);

--create trigger diachi

insert into DoiTac values(1, 'Agribank Binh Duong', 'Truong Quang Dieu', '0123456789', 'D0001', 'P0001', '', 1);
insert into DoiTac values(2, 'Cong Ty Thuan Hoa 2', 'Dinh Quang Sang', '0123456789','D0002', 'P0001', '', 1);
insert into DoiTac values(3, 'Cong Ty Binh Duong',  'Dien Ba Hung', '0123457789','D0001', 'P0002', '', 2);
insert into DoiTac values(4, 'Cong Ty Thuan Hoa 3', 'Huynh Quoc Anh', '0123458789', 'D0002', 'P0002','', 2);


--5-----------------------------------------------------------------------------------------------------
create table NhanVienBH (
MaNV int primary key, 
TongDoanhSo int default 0,
constraint fk_Nhanvienbh_nhanvien_manv foreign key(Manv) references nhanvien(manv) on delete cascade
);

insert into nhanvienbh (manv) values (7);
insert into nhanvienbh (manv) values (8);
insert into nhanvienbh (manv) values (9);
insert into nhanvienbh (manv) values (10);
insert into nhanvienbh (manv) values (11);
insert into nhanvienbh (manv) values (12);

--5 end ------------------------------------------------------------------------------------------------

--6-----------------------------------------------------------------------------------------------------
create table DoanhSoThang (
MaNV int, 
Nam char(4) , 
Thang char(2) , 
DoanhSo int default 0,
primary key (Manv,nam, thang),
constraint fk_doanhsothang_nhanvien_manv foreign key(manv) references nhanvien(manv) on delete cascade,
constraint format_doanhsothang_thang check( thang > '00' and thang < '13' and regexp_like(thang, '\d\d')),
constraint format_doandsothang_nam check( nam > '1900' and nam <= '9999' and regexp_like(nam, '\d{4}'))
);

insert into doanhsothang (manv, nam, thang) values(7,'2016','01');
insert into doanhsothang (manv, nam, thang) values(7,'2016','02');
insert into doanhsothang (manv, nam, thang) values(8,'2016','01');
insert into doanhsothang (manv, nam, thang) values(8,'2016','02');
insert into doanhsothang (manv, nam, thang) values(9,'2016','01');
insert into doanhsothang (manv, nam, thang) values(9,'2016','02');

--6 end ------------------------------------------------------------------------------------------------

--7-----------------------------------------------------------------------------------------------------
create table TinDang (
MaTin char(10) primary key, 
ThoiGianBD date, 
ThoiGianKT date
);

CREATE SEQUENCE seq_matindang_KH
START WITH 1
maxvalue 99999999
INCREMENT BY 1
cache 10;

CREATE SEQUENCE seq_matindang_CT
START WITH 1
maxvalue 99999999
INCREMENT BY 1  
cache 10;

--create trigger madangtin

insert into tindang values('CT00000001', '15-02-2016', '15-04-2016');
insert into tindang values('CT00000002', '03-12-2015', '03-04-2016');
insert into tindang values('CT00000003', '06-10-2015', '06-01-2016');
insert into tindang values('KH00000001', '07-11-2016', '07-04-2016');
insert into tindang values('KH00000002', '10-01-2016', '10-03-2016');
insert into tindang values('KH00000003', '12-08-2015', '12-09-2015');
--7 end ------------------------------------------------------------------------------------------------

--8-----------------------------------------------------------------------------------------------------
create table KhachHang (
MaKH char(10) primary key, 
HoTen varchar(30) not null, 
NamSinh char(4), 
CMND varchar(11) unique, 
Email varchar(30), 
SDT varchar(11), 
maduong char(5),
maphuong char(5),
DiaChi varchar(100),
constraint fk_KhachHang_MaDuong foreign key (maduong) references duong(maduong) on delete set null,
 constraint fk_KhachHang_MaPhuong foreign key (maPhuong) references Phuong(MaPhuong) on delete set null,
constraint format_Khachhang_cmnd check (regexp_like(cmnd, '^\d{9}$|\d{11}$')),
constraint format_Khachhang_SDT check (REGEXP_LIKE(SDT, '^\d{10,11}$')),
constraint format_Khachhang_email check(regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+')),
constraint format_Khachhang_namsinh check( namsinh > '1900' and namsinh <= '9999' and regexp_like(namsinh, '\d{4}'))
);

create sequence seq_makh_kh
start with 1
increment by 1
maxvalue 99999999
cache 10;

create sequence seq_makh_ct
start with 1
increment by 1
maxvalue 99999999
cache 10;

--create trigger makh
--create trigger diachi


insert into KhachHang values('CT00000001','Thong Thi Minh', '1996', '11223344559', 'phan.truong@gmail.com', '0123456789', 'D0001', 'P0001', '');
insert into KhachHang values('CT00000002','Vuong Ba Thinh', '1986', '21223344559', 'ba.vuong@gmail.com', '0123456789', 'D0002', 'P0001', '');
insert into KhachHang values('CT00000003','Hoang Phi Hong', '1976', '31223344559', 'hongphi@gmail.com', '0123456789', 'D0003', 'P0001', '');
insert into KhachHang values('KH00000001','Van Thi Huong', '1976', '41223344559', 'thinh.vuong@gmail.com', '0123456789', 'D0001', 'P0002', '');
insert into KhachHang values('KH00000002','Do Duc Tai', '1976', '51223344559', 'tai.do@gmail.com', '0123456789', 'D0002', 'P0002', '');
insert into KhachHang values('KH00000003','Minh Van Tran', '1966', '61223344559', 'vantran@gmail.com', '0123456789', 'D0003', 'P0002', '');

--8 end ------------------------------------------------------------------------------------------------



--9-----------------------------------------------------------------------------------------------------
create table TinKhachHang (
MaTin char(10), 
MaKH char(10) not null, 
GiaTin decimal(10,0), 
HueHong number(4,3),
primary key (matin, makh),
constraint fk_tinkhachhang_tindang_matin foreign key (MaTin) references tindang(matin) on delete cascade,
constraint fk_tinkhachhang_khachhang_makh foreign key (Makh) references khachhang(makh) on delete set null,
constraint format_tinkhachhang_huehong check (huehong > 0.000 and huehong < 1.000)
);

--drop table tinkhachhang;
-- UPDATE LAI LAN SAU MA KH
insert into tinkhachhang values('CT00000001', 'CT000001', 700000,0.05);
insert into tinkhachhang values('CT00000002', 'CT000001', 800000,0.03);
insert into tinkhachhang values('CT00000003', 'CT000005', 650000,0.02);
insert into tinkhachhang values('CT00000001', 'CT000005', 550000,0.03);
insert into tinkhachhang values('CT00000002', 'CT000006', 700000,0.04);
insert into tinkhachhang values('CT00000003', 'CT000006', 700000,0.05);
--9 end ------------------------------------------------------------------------------------------------





-------------------------------------------------------------------------------------------------------
drop table TinKhachHang ;
drop table KhachHang;
drop table TinDang;
drop table DoanhSoThang;
drop table NhanVienBH ;
drop table DoiTac ;
drop table NhanVien;
drop table ChiNhanhSDT;
drop table ChiNhanh;
drop table DuongThuocPhuong ;
drop table Duong;
drop table Phuong;
drop table Quan;
drop table ThanhPho;
drop sequence seq_MaNhanVien;
drop SEQUENCE seq_matindang_KH;
drop SEQUENCE seq_matindang_CT;
drop sequence seq_makh_kh;
drop sequence seq_makh_ct;
