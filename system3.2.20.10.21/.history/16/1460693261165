--1------------------------------------------------------------------------------------------------
create table ChiNhanh (
	MaCN int primary key, 
	TenCN varchar(15) unique,
	SoFax varchar(11) ,
	DiaChi varchar(10), 
	MaNVTruong varchar(10),
  CONSTRAINT format_Chinhanh_SoFax      
      CHECK ( REGEXP_LIKE ( SoFax, '^\d{10,11}$' ) )
);
Insert into chinhanh values(1, 'phuoc thien', '12345678900', 'thanh p', 'matruong');
Delete chinhanh where MaCN = '1';
--1 end------------------------------------------------------------------------------------------------

--2------------------------------------------------------------------------------------------------
create table ChiNhanhSDT (
	MaCN int primary key, 
	SDT varchar(11),
	constraint fk_ChiNhanhSDT_ChiNhanh_MaCN foreign key(MaCN) references ChiNhanh(MaCN) on delete cascade,
  constraint format_ChinhanhSDT_SDT check (REGEXP_LIKE(SDT, '^\d{10,11}$'))
	);
insert into chinhanhsdt values('1', '1234567899');
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
DiaChi varchar(30),
MaCN int,
constraint fk_NhanVien_ChiNhanh_MaCN foreign key (MaCN) references Chinhanh(macn) on delete set null,
constraint format_Nhanvien_cmnd check (regexp_like(cmnd,'^\d{9}|\d{11}')),
constraint format_Nhanvien_email check(regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+')),
constraint format_Nhanvien_SDT check (REGEXP_LIKE(SDT, '^\d{10,11}$')),
constraint format_Nhanvien_namvao check(namvao > '1900' and regexp_like(namvao, '^\d{4}$') )
);

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';

Insert into nhanvien  ( manv,HoTen, NgaySinh, CMND, Email, SDT, NamVao, ChucVu, Luong, DiaChi,MaCN) 
values (seq_MaNhanVien.NEXTVAL,'Nguyen Van A', '11-11-1990', '123456789','nguyenvana@gmai.com', '0912345678', '1991', 'nhan vien',700000, 'Binh Dinh', 1 );

Insert into nhanvien  ( HoTen, NgaySinh, CMND, Email, SDT, NamVao, ChucVu, Luong, DiaChi,MaCN) 
values ('Nguyen Van B', '11-11-1990', '123456793','nguyenvana@gmai.com', '0912345678', '1991', 'nhan vien',700000, 'Binh Dinh', 1 );

Drop table nhanvien;
----doi tuoi lao dong phai lon hon 18

create sequence seq_MaNhanVien
minvalue 1
start with 1
increment by 1;
--3 end------------------------------------------------------------------------------------------------


--4-----------------------------------------------------------------------------------------------------
create table DoiTac (
MaDT int primary key,
Ten varchar(30) not null unique, 
HoTenNLL varchar(30) not null, 
SDTNLL varchar(11), 
DiaChi varchar(30), 
MaNV int,
constraint fk_doitac_nhanvien_manv foreign key(manv) references nhanvien(manv) on delete set null,
constraint format_doitac_SDTNLL check (REGEXP_LIKE(SDTNLL, '^\d{10,11}$'))
);

create  sequence seq_MaDoiTac
minvalue 1
start with 1
maxvalue 1000
cache 10
increment by 1;

insert into DoiTac values(seq_MaDoiTac.nextval, 'Agribank Binh Duong', 'Truong Quang Dieu', '0123456789', 'binh dinh, nghia binh', 1);
insert into DoiTac values(888, 'Agribank Thuan Hoa 2', 'Truong Quang Sang', '0123456789', 'binh dinh, nghia binh', 1);
--4 end ------------------------------------------------------------------------------------------------


--5-----------------------------------------------------------------------------------------------------
create table NhanVienBH (
MaNV int primary key, 
TongDoanhSo int default 0,
constraint fk_Nhanvienbh_nhanvien_manv foreign key(Manv) references nhanvien(manv) on delete cascade
);

insert into nhanvienbh (manv) values (2);
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

insert into doanhsothang (manv, nam, thang) values(2,'2013','12');
drop table doanhsothang;
--6 end ------------------------------------------------------------------------------------------------


--7-----------------------------------------------------------------------------------------------------
create table TinDang (
MaTin varchar(20) primary key, 
ThoiGianBD date, 
ThoiGianKT date
);
drop table tindang;
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

insert into tindang values('CT12345689', '10-10-2012', '15-04-2016');
--7 end ------------------------------------------------------------------------------------------------


--8-----------------------------------------------------------------------------------------------------
create table KhachHang (
MaKH varchar(20) primary key, 
HoTen varchar(30) not null, 
NamSinh char(4), 
CMND varchar(11) unique, 
Email varchar(30), 
SDT varchar(11), 
DiaChi varchar(30),
constraint format_Khachhang_cmnd check (regexp_like(cmnd, '^\d{9}$|\d{11}$')),
constraint format_Khachhang_SDT check (REGEXP_LIKE(SDT, '^\d{10,11}$')),
constraint format_Khachhang_email check(regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+')),
constraint format_Khachhang_namsinh check( namsinh > '1900' and namsinh <= '9999' and regexp_like(namsinh, '\d{4}'))
);
drop table khachhang;

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

insert into KhachHang values(
                        'CT00000001',
                        'Thong Thi Minh', 
                        '1996', 
                        '11223344559', 
                        'phan.truong@gmail.com', 
                        '0123456789', 
                        'Nghia Binh - Phu My');

delete khachhang where makh = 'CT00001';

--8 end ------------------------------------------------------------------------------------------------


--9-----------------------------------------------------------------------------------------------------
create table TinKhachHang (
MaTin varchar(20) primary key, 
MaKH varchar(20) not null, 
GiaTin decimal(10,0), 
HueHong number(4,3),

constraint fk_tinkhachhang_tindang_matin foreign key (MaTin) references tindang(matin) on delete cascade,
constraint fk_tinkhachhang_khachhang_makh foreign key (Makh) references khachhang(makh) on delete set null,
constraint format_tinkhachhang_huehong check (huehong > 0.000 and huehong < 1.000)
);

insert into tinkhachhang values('CT00000002', 'CT00000001', 700000,0.070);
--9 end ------------------------------------------------------------------------------------------------



--10-----------------------------------------------------------------------------------------------------
create table TinNhanVienBH (
MaTin varchar(20), 
MaNVBH int,
primary key (matin, manvbh),
constraint fk_tinnhanvienbh_matin foreign key (matin) references tindang(matin) on delete set null,
constraint fk_tinnhanvienbh_manvbh foreign key ( manvbh) references nhanvienbh(manv) on delete set null
);

insert into tinnhanvienbh values('CT00000002', 2);
--10 end ------------------------------------------------------------------------------------------------


--11-----------------------------------------------------------------------------------------------------
create table BatDongSan (
MaBDS varchar(10) primary key
);

create sequence seq_MaBds_CH -- for can ho
start with 1
increment by 1
maxvalue 999999
cache 10;

create sequence seq_MaBds_NP -- for nha pho
start with 1
increment by 1
maxvalue 999999
cache 10;

create sequence seq_MaBds_DN -- for dat nen
start with 1
increment by 1
maxvalue 999999
cache 10;

insert into batdongsan values('DN000001');
--11 end ------------------------------------------------------------------------------------------------



--12-----------------------------------------------------------------------------------------------------
 create table BDSDangBan (
 MaBDS varchar(10), 
 MaTin varchar(20) , 
 GiaBan number(12,0), 
 HinhThucTT varchar(30), 
 GhiChu varchar(100),
 primary key(MaBDS, MaTin),
 constraint fk_BDSDangBan_BDS_MaBDS foreign key (mabds) references batdongsan(mabds) on delete set null,
 constraint fk_BDSDanbBan_TinDang_Matin foreign key (matin) references tindang(matin) on delete set  null 
 );

drop table bdsdangban;

insert into bdsdangban values('CH000001', 'CT00000001', 10000000000, 'thanh toan 1 lan', 'De biet them thong tin lien he...');
--12 end ------------------------------------------------------------------------------------------------

--13-----------------------------------------------------------------------------------------------------
create table BDSDangThue (
MaBDS varchar(10), 
MaTin varchar(20) , 
TienCoc number(12,0), 
ThoiHan number(3,0),
GiaThue number (12,0), 
GhiChu varchar(100),
constraint pk_bdsdangthue primary key(mabds, matin),
constraint fk_dbsDangThue_bds_mabds foreign key( mabds) references batdongsan(mabds),
constraint fk_dbsDangThue_tindang_matin foreign key(matin) references tindang(matin)
);

insert into bdsdangthue values('DN000002', 'CT00000002',12000000, 30, 20000000, 'Lien he nhanh de huong khuyen mai.');
--13 end ------------------------------------------------------------------------------------------------




--14-----------------------------------------------------------------------------------------------------
create table GiaoDichThanhCong (
MaBDS varchar(10) primary key, 
MaNV int not null, 
Nam char(4), 
Thang char(2), 
Ngay char(2), 
Gia number(12,0), 
BanHoacThue varchar(4),
constraint fk_gdtc_mabds foreign key (mabds) references batdongsan(mabds) on delete cascade,
constraint fk_gdtc_manv_nam_thang foreign key (manv, nam, thang) references Doanhsothang(manv, nam, thang) on delete set null
);

insert into GiaoDichThanhCong values('DN000002', 2, '2013','12','20', 10000000, 'Ban' );
--------------trong mot ngay co thoi da bao nhieu viec dang tin
--14 end ------------------------------------------------------------------------------------------------


--15-----------------------------------------------------------------------------------------------------
 create table ChuongTrinhKM (
 MaCT int primary key, 
 Ten varchar(50), 
 MoTa varchar(200), 
 ThoiGianBD date, 
 ThoiGianKT date
 );
 
 create sequence seq_mact
 start with 1
 increment by 1
 maxvalue 10000
 cache 10;
 
insert into ChuongTrinhKM values(1, 'Mung ngay nha giao Viet Nam', 'Chuong trinh co gia tri tren toan quoc', '11-11-2016', '11-12-2016');
--15 end ------------------------------------------------------------------------------------------------


--16-----------------------------------------------------------------------------------------------------

create table BDSKM (
MaCT int, 
MaBDS varchar(10), 
ThanhCong number(1,0) default 0,
primary key (mact, mabds),
constraint fk_bdskm_chuongtrinhkm_mact foreign key (mact) references ChuongTrinhKM(MaCT) on delete cascade,
constraint fk_bdskm_bds_mabds foreign key (mabds) references batdongsan(Mabds) on delete set null,
constraint format_thangcong check(thanhcong = 0 or thanhcong = 1)
);

insert into BDSKM values(1, 'DN000002', 0);
--16 end ------------------------------------------------------------------------------------------------


--17-----------------------------------------------------------------------------------------------------
create table CoSoHaTang (
MaCSHT char(8) primary key, 
Ten varchar(30), 
So varchar(6), 
MaDuong char(5), 
MaPhuong char(5), 
TenLoaiCSHT varchar(30),
constraint format_csht_mcsht check (regexp_like(macsht,'^CSHT\d{4}')),
constraint fk_CSHT_MaDuong foreign key (maDuong) references Duong(MaDuong) on delete set null,
constraint fk_CSHT_MaPhuong foreign key (maPhuong) references Phuong(MaPhuong) on delete set null,
constraint fk_CSHT_TenLoaiCSHT foreign key (TenLoaiCSHT) references LoaiCSHT(TenLoaiCSHT) on delete set null
);

insert into Cosohatang values('CSHT0001', 'Nha Tre Anh Duong'       ,'113', 'D0001', 'P0001', 'Nha Tre');
insert into Cosohatang values('CSHT0002', 'Truong THPT Nguyen Trai' ,'23', 'D0001', 'P0002', 'Truong hoc');
insert into Cosohatang values('CSHT0003', 'Benh vien Nhi Dong 2'    ,'28', 'D0003', 'P0003', 'Benh vien');
insert into Cosohatang values('CSHT0004', 'Cong Vien Tan Phuoc'     ,'28', 'D0001', 'P0004', 'Cong vien');
insert into Cosohatang values('CSHT0005', 'Cho Ba Chieu'            ,'89', 'D0005', 'P0003', 'Cho');
--17 end ------------------------------------------------------------------------------------------------


--18-----------------------------------------------------------------------------------------------------
create table LoaiCSHT (
TenLoaiCSHT varchar(30) primary key
);

insert into Loaicsht values ('Nha Tre');
insert into Loaicsht values ('Truong hoc');
insert into Loaicsht values ('Cong vien');
insert into Loaicsht values ('Cho');
insert into Loaicsht values ('Benh vien');

--18 end ------------------------------------------------------------------------------------------------


--19-----------------------------------------------------------------------------------------------------
create table BDSCSHT (
MaCSHT char(8), 
MaBDS varchar(10),
KhoangCach number(2,1),
constraint pk_BDSCSHT primary key (MaCSHT,MaBDS),
constraint format_Khoangcach check(khoangcach >= 0 and khoangcach <=7 )
);

-- create database;
--19 end ------------------------------------------------------------------------------------------------


--20-----------------------------------------------------------------------------------------------------

--20 end ------------------------------------------------------------------------------------------------


--21-----------------------------------------------------------------------------------------------------
--21 end ------------------------------------------------------------------------------------------------


--22-----------------------------------------------------------------------------------------------------
--22 end ------------------------------------------------------------------------------------------------


--23-----------------------------------------------------------------------------------------------------
--23 end ------------------------------------------------------------------------------------------------


--24-----------------------------------------------------------------------------------------------------
--24 end ------------------------------------------------------------------------------------------------


--25-----------------------------------------------------------------------------------------------------
--25 end ------------------------------------------------------------------------------------------------


--26-----------------------------------------------------------------------------------------------------
--26 end ------------------------------------------------------------------------------------------------


--27-----------------------------------------------------------------------------------------------------
--27 end ------------------------------------------------------------------------------------------------


--28-----------------------------------------------------------------------------------------------------
--28 end ------------------------------------------------------------------------------------------------


--29-----------------------------------------------------------------------------------------------------
create table ThanhPho (
MaTP char(6) primary key, 
TenTP varchar(30) unique,
constraint format_thanhpho check( regexp_like(matp,'^TP\d{4}$'))
);

insert into thanhpho values('TP0001', 'Quy Nhon');
insert into thanhpho values('TP0002', 'Ho Chi Minh');
insert into thanhpho values('TP0003', 'Ha Noi');
insert into thanhpho values('TP0004', 'Binh Duong');
insert into thanhpho values('TP0005', 'Vung Tau');
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
insert into quan values('Q0004', 'Quan 4', 'TP0003');
insert into quan values('Q0005', 'Quan 5', 'TP0004');
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
insert into Phuong values('P0002', 'Phuong 2', 'Q0002');
insert into Phuong values('P0003', 'Phuong 3', 'Q0003');
insert into Phuong values('P0004', 'Phuong 4', 'Q0004');
insert into Phuong values('P0005', 'Phuong 4', 'Q0004');

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
 
--32 end ------------------------------------------------------------------------------------------------



--33-----------------------------------------------------------------------------------------------------
 create table DuongThuocPhuong (
 MaDuong char(5), 
 MaPhuong char(5),
 constraint pk_DuongThuocPhuong primary key( maduong, maphuong)
 );
 
drop table duongthuocphuong;

insert into DuongThuocPhuong values('D0001', 'P0001');
insert into DuongThuocPhuong values('D0001', 'P0002');
insert into DuongThuocPhuong values('D0002', 'P0003');
insert into DuongThuocPhuong values('D0001', 'P0004');
insert into DuongThuocPhuong values('D0003', 'P0005');

--33 end ------------------------------------------------------------------------------------------------









------------------------------------------------------
Drop table ChiNhanhSDT;
Drop table Chinhanh;


