
--CREATE ALL TABLE DATA
--29-----------------------------------------------------------------------------------------------------
create table ThanhPho (
MaTP char(6) primary key, 
TenTP varchar(30) unique,
constraint format_thanhpho check( regexp_like(matp,'^TP\d{4}$'))
);
--29 end ------------------------------------------------------------------------------------------------

--30-----------------------------------------------------------------------------------------------------
create table Quan (
MaQuan char(5) primary key, 
TenQuan varchar(30) not null, 
MaTP char(6) not null,
constraint fk_Quan_ThanhPho_matp foreign key (matp) references thanhpho(matp) on delete cascade,
constraint format_Quan check( regexp_like(maQuan,'^Q\d{4}$'))
);
--30 end ------------------------------------------------------------------------------------------------

--31-----------------------------------------------------------------------------------------------------
create table Phuong (
MaPhuong char(5) primary key, 
TenPhuong varchar(30) not null, 
MaQuan char(5) not null,
constraint fk_Quan_MaQuan foreign key (maquan) references Quan(maquan) on delete cascade,
constraint format_MaPhuong check( regexp_like(maPhuong,'^P\d{4}$'))
);
--31 end ------------------------------------------------------------------------------------------------

--32-----------------------------------------------------------------------------------------------------
 create table Duong (
 MaDuong char(5) primary key, 
 TenDuong varchar(30),
 constraint format_duong check( regexp_like(maduong,'^D\d{4}$'))
 );
--32 end ------------------------------------------------------------------------------------------------

--33-----------------------------------------------------------------------------------------------------
 create table DuongThuocPhuong (
 MaDuong char(5), 
 MaPhuong char(5),
 constraint pk_DuongThuocPhuong primary key( maduong, maphuong)
 );
--33 end ------------------------------------------------------------------------------------------------
--1------------------------------------------------------------------------------------------------
create table ChiNhanh (
	MaCN int primary key, 
	TenCN varchar(15) unique,
	SoFax varchar(11) ,
  maduong char(5),
  maphuong char(5),
	DiaChi varchar(100), 
	MaNVTruong int,
  constraint fk_ChiNhanh_MaDuong foreign key (maduong) references duong(maduong) on delete set null,
  constraint fk_ChiNhanh_MaPhuong foreign key (maPhuong) references Phuong(MaPhuong) on delete set null,
  CONSTRAINT format_Chinhanh_SoFax      
      CHECK ( REGEXP_LIKE ( SoFax, '^\d{10,11}$' ) )
);
--1 end------------------------------------------------------------------------------------------------

--2------------------------------------------------------------------------------------------------
create table ChiNhanhSDT (
	MaCN int, 
	SDT varchar(11),
  primary key (macn, sdt),
	constraint fk_ChiNhanhSDT_ChiNhanh_MaCN foreign key(MaCN) references ChiNhanh(MaCN) on delete cascade,
  constraint format_ChinhanhSDT_SDT check (REGEXP_LIKE(SDT, '^\d{10,11}$'))
	);
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

--3 end------------------------------------------------------------------------------------------------

alter table chinhanh 
add constraint fk_ChiNhanh_MaNVTruong foreign key (maNVTruong) references Nhanvien(Manv) on delete set null DEFERRABLE;

--4-----------------------------------------------------------------------------------------------------
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
--4 end ------------------------------------------------------------------------------------------------

--5-----------------------------------------------------------------------------------------------------
create table NhanVienBH (
MaNV int primary key, 
TongDoanhSo int default 0,
constraint fk_Nhanvienbh_nhanvien_manv foreign key(Manv) references nhanvien(manv) on delete cascade
);
--5 end ------------------------------------------------------------------------------------------------

--6-----------------------------------------------------------------------------------------------------
create table DoanhSoThang (
MaNV int, 
Nam char(4) , 
Thang char(2) , 
DoanhSo number(12, 0) default 0,
primary key (Manv,nam, thang),
constraint fk_doanhsothang_nhanvien_manv foreign key(manv) references nhanvien(manv) on delete cascade,
constraint format_doanhsothang_thang check( thang > '00' and thang < '13' and regexp_like(thang, '\d\d')),
constraint format_doandsothang_nam check( nam > '1900' and nam <= '9999' and regexp_like(nam, '\d{4}'))
);
--6 end ------------------------------------------------------------------------------------------------

--7-----------------------------------------------------------------------------------------------------
create table TinDang (
MaTin char(10) primary key, 
ThoiGianBD date, 
ThoiGianKT date,
constraint format_tindang_thoigian check(thoigianbd < thoigiankt)
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
--8 end ------------------------------------------------------------------------------------------------

--9-----------------------------------------------------------------------------------------------------
create table TinKhachHang (
MaTin char(10), 
MaKH char(10) , 
GiaTin decimal(10,0), 
HueHong number(4,3),
primary key(matin, makh),
constraint fk_tinkhachhang_tindang_matin foreign key (MaTin) references tindang(matin) on delete cascade,
constraint fk_tinkhachhang_khachhang_makh foreign key (Makh) references khachhang(makh) on delete set null,
constraint format_tinkhachhang_huehong check (huehong > 0.000 and huehong < 1.000)
);
--9 end ------------------------------------------------------------------------------------------------

--10-----------------------------------------------------------------------------------------------------
create table TinNhanVienBH (
MaTin char(10), 
MaNVBH int,
primary key (matin, manvbh),
constraint fk_tinnhanvienbh_matin foreign key (matin) references tindang(matin) on delete set null,
constraint fk_tinnhanvienbh_manvbh foreign key ( manvbh) references nhanvienbh(manv) on delete set null
);

--10 end ------------------------------------------------------------------------------------------------

--11-----------------------------------------------------------------------------------------------------
create table BatDongSan (
MaBDS char(8) primary key
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
--11 end ------------------------------------------------------------------------------------------------

--12-----------------------------------------------------------------------------------------------------
 create table BDSDangBan (
 MaBDS char(8), 
 MaTin char(10) , 
 GiaBan number(12,0), 
 HinhThucTT varchar(30), 
 GhiChu varchar(100),
 primary key(MaBDS, MaTin),
 constraint fk_BDSDangBan_BDS_MaBDS foreign key (mabds) references batdongsan(mabds) on delete set null,
 constraint fk_BDSDanbBan_TinDang_Matin foreign key (matin) references tindang(matin) on delete set  null 
 );
--12 end ------------------------------------------------------------------------------------------------

--13-----------------------------------------------------------------------------------------------------
create table BDSDangThue (
MaBDS char(8), 
MaTin char(10) , 
TienCoc number(12,0), 
ThoiHan number(3,0),
GiaThue number (12,0), 
GhiChu varchar(100),
constraint pk_bdsdangthue primary key(mabds, matin),
constraint fk_dbsDangThue_bds_mabds foreign key( mabds) references batdongsan(mabds),
constraint fk_dbsDangThue_tindang_matin foreign key(matin) references tindang(matin)
);
--13 end ------------------------------------------------------------------------------------------------

--14-----------------------------------------------------------------------------------------------------
create table GiaoDichThanhCong (
MaBDS char(8) primary key, 
MaNV int not null, 
Nam char(4), 
Thang char(2), 
Ngay char(2), 
Gia number(12,0), 
BanHoacThue varchar(4),
constraint fk_gdtc_mabds foreign key (mabds) references batdongsan(mabds) on delete cascade,
constraint fk_gdtc_manv_nam_thang foreign key (manv, nam, thang) references Doanhsothang(manv, nam, thang) on delete set null
);
--14 end ------------------------------------------------------------------------------------------------

--15-----------------------------------------------------------------------------------------------------
 create table ChuongTrinhKM (
 MaCT int primary key, 
 Ten varchar(50), 
 MoTa varchar(200), 
 ThoiGianBD date, 
 ThoiGianKT date,
 constraint format_ctkm_thoigian check(thoigianbd < thoigiankt)
 );
 
 create sequence seq_mact
 start with 1
 increment by 1
 maxvalue 10000
 cache 10;
 
--15 end ------------------------------------------------------------------------------------------------

--16-----------------------------------------------------------------------------------------------------
create table BDSKM (
MaCT int, 
MaBDS char(8), 
ThanhCong number(1,0) default 0,
primary key (mact, mabds),
constraint fk_bdskm_chuongtrinhkm_mact foreign key (mact) references ChuongTrinhKM(MaCT) on delete cascade,
constraint fk_bdskm_bds_mabds foreign key (mabds) references batdongsan(Mabds) on delete set null,
constraint format_thangcong check(thanhcong = 0 or thanhcong = 1)
);
--16 end ------------------------------------------------------------------------------------------------
--18-----------------------------------------------------------------------------------------------------
create table LoaiCSHT (
TenLoaiCSHT varchar(30) primary key
);

--18 end ------------------------------------------------------------------------------------------------


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
--17 end ------------------------------------------------------------------------------------------------




--19-----------------------------------------------------------------------------------------------------
create table BDSCSHT (
MaCSHT char(8), 
MaBDS char(8),
KhoangCach number(2,1),
constraint pk_BDSCSHT primary key (MaCSHT,MaBDS),
constraint fk_BDSCSHT_MaBDS foreign key (maBDS) references batdongsan(mabds) on delete cascade,
constraint fk_BDSCSHT_MaCSHT foreign key (MaCSHT) references CoSoHaTang(Macsht) on delete cascade,
constraint format_Khoangcach check(khoangcach >= 0 and khoangcach <=7 )

);
--19 end ------------------------------------------------------------------------------------------------


--20-----------------------------------------------------------------------------------------------------
  create table ChungCu (
  MaCC char(6) primary key, 
  Ten varchar(30), 
NamXD char(4), 
So varchar(6), 
MaDuong char(5), 
MaPhuong char(5), 
TongTang int, 
TongCH int, 
PhiSH number(10,0),
SoThangMay int, 
SoThangBo int, 
TienIchRieng varchar(100),
constraint format_macc check(regexp_like(macc, '^CC\d{4}$')),
constraint format_nam check(regexp_like(namxd, '^\d{4}$')),
constraint fk_ChungCu_MaDuong foreign key (maDuong) references Duong(MaDuong) on delete set null,
constraint fk_ChungCu_MaPhuong foreign key (maPhuong) references Phuong(MaPhuong) on delete set null
);
--20 end ------------------------------------------------------------------------------------------------

--21-----------------------------------------------------------------------------------------------------
create table ChungCuAnh (
MaCC char(6), 
Anh varchar(150),
primary key(macc, anh),
constraint fk_ChungCuAnh_MaCC foreign key (maCC) references ChungCu(MaCC) on delete cascade
);
--21 end ------------------------------------------------------------------------------------------------

--22-----------------------------------------------------------------------------------------------------
create table CanHo (
MaCC char(6), 
SoCH varchar(6), 
STTTang int , 
DienTich int, 
SoPN int, 
Huong varchar(20), 
TinhTrang varchar(8), 
GiayTo varchar(20),
ThongTinThem varchar(200), 
MaBDS char(8),
constraint pk_Canho primary key (macc, soch),
constraint fk_CanHo_MaCC foreign key (macc) references chungcu(macc) on delete cascade,
constraint fk_CanHo_MaBDS foreign key (maBDS) references batdongsan(mabds) on delete  set null,
constraint format_TinhTrang check (TinhTrang =  'Moi' or TinhTrang = 'DaSuDung')
);
--22 end ------------------------------------------------------------------------------------------------


--23-----------------------------------------------------------------------------------------------------
create table CanHoAnh (
MaCC char(6), 
SoCH varchar(6), 
Anh varchar(120),
primary key(MaCC, SoCH, Anh),
constraint fk_CanHoAnh_CanHo foreign key (MaCC, SoCH) references Canho(MaCC, SoCH) on delete cascade
);
--23 end ------------------------------------------------------------------------------------------------


--24-----------------------------------------------------------------------------------------------------
create table  NhaPho (
MaNha char(6), 
So varchar(6), 
MaDuong char(5), 
MaPhuong char(5), 
KichThuoc varchar(7), 
DienTich int, 
NamXD char(4), 
LoaiNha varchar(20), 
SoPN int,
Huong varchar(20), 
TinhTrang varchar(8), 
GiayTo varchar(20), 
ThongTinThem varchar(200), 
MaBDS char(8),
constraint pk_nhapho primary key(manha),
constraint foramt_MaNha check(regexp_like(manha,'^NP\d{4}')),
constraint format_NhaPho_TinhTrang check (TinhTrang =  'Moi' or TinhTrang = 'DaSuDung'),
constraint fk_NhaPho_MaDuong foreign key (maduong) references duong(maduong) on delete set null,
constraint fk_NhaPho_MaPhuong foreign key (maPhuong) references Phuong(MaPhuong) on delete set null,
constraint fk_NhaPho_Mabds foreign key (mabds) references batdongsan(Mabds) on delete set null
);
--24 end ------------------------------------------------------------------------------------------------


--25-----------------------------------------------------------------------------------------------------
create table NhaPhoAnh (
MaNha char(6), 
Anh varchar(120),
constraint pk_NhaPhoAnh primary key(manha, anh),
constraint fk_NhaPhoAnh_maNha foreign key (manha) references nhapho(Manha) on delete cascade
);
--25 end ------------------------------------------------------------------------------------------------

--26-----------------------------------------------------------------------------------------------------
create table KhuDuAn (
MaKDA char(7) primary key, 
Ten varchar(30) not null, 
TienIchRieng varchar(100), 
So varchar(6), 
MaDuong char(5), 
MaPhuong char(5),
constraint foramt_KhuDuAn check(regexp_like(maKDA,'^KDA\d{4}')),
constraint fk_KhuDuAn_MaDuong foreign key (maDuong) references Duong(MaDuong) on delete set null,
constraint fk_KhuDuAn_MaPhuong foreign key (maPhuong) references Phuong(MaPhuong) on delete set null
);
--26 end ------------------------------------------------------------------------------------------------


--27-----------------------------------------------------------------------------------------------------
create table DatNen (
MaKDA char(7), 
SoLo varchar(7), 
KichThuoc varchar(10), 
DienTich int, 
GiayPhepXD varchar(20), 
Huong varchar(20), 
ThongTinThem varchar(100),
MaBDS char(8), 
constraint pk_DatNen primary key(makda, solo),
constraint fk_DatNen_MaKDA foreign key (MaKDA) references KhuDuAn(maKDA) on delete cascade,
constraint fk_DatNen_MaBDS foreign key (maBDS) references batdongsan(mabds) on delete  set null
);
--27 end ------------------------------------------------------------------------------------------------


--28-----------------------------------------------------------------------------------------------------

create table DatNenAnh (
MaKDA char(7), 
SoLo varchar(7), 
Anh varchar(120),
primary key(MaKDA, SoLo, Anh),
constraint fk_DatNenAnh_MaKDA foreign key (MaKDA, SoLo) references DatNen(MaKDA, SoLo) on delete cascade
);

--28 end ------------------------------------------------------------------------------------------------














--CREATE OR CREATE TRIGGER
CREATE OR REPLACE TRIGGER NhaPho_dientich 
BEFORE INSERT OR UPDATE ON nhapho 
FOR EACH ROW 
declare 
rong int;
dai int;
BEGIN
  rong := 0;
  dai := 0;
  if( not regexp_like(:new.kichthuoc, '^\d{1,}x\d{1,}$')) then
    raise_application_error(-20009, 'Kich thuoc khong theo chuan');
  end if;
   select REGEXP_SUBSTR(:new.kichthuoc, '[^x]+', 1, 1) into rong
   from dual;
   select REGEXP_SUBSTR(:new.kichthuoc, '[^x]+', 1, 2) into dai
   from dual;
   :new.dientich := rong*dai;
   dbms_output.put_line(:new.dientich  ||',' || rong ||','|| dai );
END;
/
-------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER DatNen_dientich 
BEFORE INSERT OR UPDATE ON DatNen 
FOR EACH ROW 
declare 
rong int;
dai int;
BEGIN
  rong := 0;
  dai := 0;
  if(not regexp_like(:new.kichthuoc, '^\d{1,}x\d{1,}$')) then
    raise_application_error(-20009, 'Kich thuoc khong theo chuan');
  end if;
   select REGEXP_SUBSTR(:new.kichthuoc, '[^x]+', 1, 1) into rong
   from dual;
   select REGEXP_SUBSTR(:new.kichthuoc, '[^x]+', 1, 2) into dai
   from dual;
   :new.dientich := rong*dai;
   dbms_output.put_line(:new.dientich  ||',' || rong ||','|| dai );
END;
/
---------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TRIGGER_CHINHANH_DIACHI 
BEFORE INSERT OR UPDATE ON CHINHANH 
FOR EACH ROW 
declare
ten_Duong varchar(30);
ten_Phuong varchar(30);
ma_Quan char(5);
ten_Quan varchar(30);
ma_TP char(6);
ten_TP varchar(30);
BEGIN
  select tenDuong into ten_duong
  from Duong
  where maDuong = :new.maDuong;

  select tenphuong, maQuan into ten_Phuong, ma_Quan
  from Phuong
  where maPhuong = :new.maPhuong;
  
  select TenQuan, MaTP into ten_quan, ma_tp
  from Quan
  where maquan = ma_quan;

  select tenTP into  ten_TP
  from thanhpho
  where matp = ma_tp;
  
  :new.diachi := ten_Duong || ', ' || ten_Phuong || ', ' || ten_Quan || ', ' || ten_TP;
END;
/
----------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER TRIGGER_NHANVIEN_DIACHI 
BEFORE INSERT OR UPDATE ON NHANVIEN 
FOR EACH ROW 
declare
ten_Duong varchar(30);
ten_Phuong varchar(30);
ma_Quan char(5);
ten_Quan varchar(30);
ma_TP char(6);
ten_TP varchar(30);
BEGIN
  select tenDuong into ten_duong
  from Duong
  where maDuong = :new.maDuong;

  select tenphuong, maQuan into ten_Phuong, ma_Quan
  from Phuong
  where maPhuong = :new.maPhuong;
  
  select TenQuan, MaTP into ten_quan, ma_tp
  from Quan
  where maquan = ma_quan;

  select tenTP into  ten_TP
  from thanhpho
  where matp = ma_tp;
  
  :new.diachi := ten_Duong || ', ' || ten_Phuong || ', ' || ten_Quan || ', ' || ten_TP;
END;
/
---------------------------------------------------------------------------

------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRIGGER_DOITAC_DIACHI 
BEFORE INSERT OR UPDATE ON DOITAC 
FOR EACH ROW 
declare
ten_Duong varchar(30);
ten_Phuong varchar(30);
ma_Quan char(5);
ten_Quan varchar(30);
ma_TP char(6);
ten_TP varchar(30);
BEGIN
  select tenDuong into ten_duong
  from Duong
  where maDuong = :new.maDuong;

  select tenphuong, maQuan into ten_Phuong, ma_Quan
  from Phuong
  where maPhuong = :new.maPhuong;
  
  select TenQuan, MaTP into ten_quan, ma_tp
  from Quan
  where maquan = ma_quan;

  select tenTP into  ten_TP
  from thanhpho
  where matp = ma_tp;
  
  :new.diachi := ten_Duong || ', ' || ten_Phuong || ', ' || ten_Quan || ', ' || ten_TP;
END;
/
------------------------------------------------------------------------------
--CREATE OR REPLACE TRIGGER TRIGGER_TINDANG_MATIN 
--BEFORE INSERT ON TINDANG 	
--FOR EACH ROW 
--BEGIN
--  if(regexp_like(:new.matin,'^CT' )) then
--    select 'CT' || to_char(seq_matindang_CT.nextval, 'FM00000000') into :new.matin
--    from dual;
--  elsif (regexp_like(:new.matin, '^KH' )) then
--    select 'KH' || to_char(seq_matindang_KH.nextval, 'FM00000000') into :new.matin
--    from dual;
--  else
--    raise_application_error(-20003, 'Error format MaTin');
--  end if;
--END;
--/



------------------------------------------------------------------------------
--CREATE OR REPLACE TRIGGER TRIGGER_KHACHHANG_MAKH 
--BEFORE INSERT ON KHACHHANG 
--FOR EACH ROW 
--BEGIN
--  if(regexp_like(:new.maKH,'^CT' )) then
--    select 'CT' || to_char(seq_makh_kh.nextval, 'FM00000000') into :new.makh
--    from dual;
--  elsif (regexp_like(:new.maKH, '^KH' )) then
--    select 'KH' || to_char(seq_makh_ct.nextval, 'FM00000000') into :new.makh
--    from dual;
--  else
--    raise_application_error(-20003, 'Error format MaKH');
--  end if;
--END;
--/
--insert into KhachHang values('CT' || to_char(seq_makh_kh.nextval, 'FM00000000'),'Minh Van Tran', '1966', '61223704559', 'vantran@gmail.com', '01234567895', 'D0003', 'P0002', '');

------------------------------------------------------------------------------
--select 'CT' || to_char(seq_makh_kh.nextval, 'FM00000000')
--from dual;
------------------------------------------------------------------------------
--CREATE OR REPLACE TRIGGER TRIGGER_BatDongSan_MABDS 
--BEFORE INSERT ON BatDongSan
--FOR EACH ROW 
--BEGIN
--  if(regexp_like(:new.mabds,'^NP' )) then
--    select 'NP' || to_char(seq_MaBds_NP.nextval, 'FM000000') into :new.mabds
--    from dual;
--  elsif (regexp_like(:new.mabdds, '^DN' )) then
--    select 'DN' || to_char(seq_MaBds_DN.nextval, 'FM000000') into :new.mabds
--    from dual;
--  elsif (regexp_like(:new.mabdds, '^CH' )) then
--    select 'CH' || to_char(seq_MaBds_CH.nextval, 'FM000000') into :new.mabds
--    from dual;
--  else
--    raise_application_error(-20010, 'Error format MaBDS');
--  end if;
--END;
--/
------------------------------------------------------------------------------

create or replace 
trigger TRIGGER_KHACHHANG_DIACHI 
BEFORE INSERT OR UPDATE ON KHACHHANG 
FOR EACH ROW 
declare
ten_Duong varchar(30);
ten_Phuong varchar(30);
ma_Quan char(5);
ten_Quan varchar(30);
ma_TP char(6);
ten_TP varchar(30);
BEGIN
  select tenDuong into ten_duong
  from Duong
  where maDuong = :new.maDuong;

  select tenphuong, maQuan into ten_Phuong, ma_Quan
  from Phuong
  where maPhuong = :new.maPhuong;
  
  select TenQuan, MaTP into ten_quan, ma_tp
  from Quan
  where maquan = ma_quan;

  select tenTP into  ten_TP
  from thanhpho
  where matp = ma_tp;
  
  :new.diachi := ten_Duong || ', ' || ten_Phuong || ', ' || ten_Quan || ', ' || ten_TP;
END;
/
------------------------------------------------------------------------------






--CREATE ALL INSERT DATA
--29-----------------------------------------------------------------------------------------------------
insert into thanhpho values('TP0001', 'Ho Chi Minh');
insert into thanhpho values('TP0002', 'Ha Noi');
insert into thanhpho values('TP0003', 'Quy Nhon');
insert into thanhpho values('TP0004', 'Binh Duong');
insert into thanhpho values('TP0005', 'Vung Tau');
insert into thanhpho values('TP0006', 'Da Nang');
--29 end ------------------------------------------------------------------------------------------------

--30-----------------------------------------------------------------------------------------------------
insert into quan values('Q0001', 'Quan 1', 'TP0001');
insert into quan values('Q0002', 'Quan 10', 'TP0001');
insert into quan values('Q0003', 'Q.Thu Duc', 'TP0002');
insert into quan values('Q0004', 'Quan 7', 'TP0002');
insert into quan values('Q0005', 'Quan 9', 'TP0003');
insert into quan values('Q0006', 'Quan 3', 'TP0003');
--30 end ------------------------------------------------------------------------------------------------

--31-----------------------------------------------------------------------------------------------------
insert into Phuong values('P0001', 'Phuong 1', 'Q0001');
insert into Phuong values('P0002', 'Phuong 2', 'Q0001');
insert into Phuong values('P0003', 'Phuong 3', 'Q0002');
insert into Phuong values('P0004', 'Phuong 4', 'Q0002');
insert into Phuong values('P0005', 'Phuong 5', 'Q0003');
insert into Phuong values('P0006', 'P.Truong Tho', 'Q0003');
--31 end ------------------------------------------------------------------------------------------------

--32-----------------------------------------------------------------------------------------------------
 insert into Duong values ( 'D0001', 'Nguyen Trai');
 insert into Duong values ( 'D0002', 'Ly Thuong Kiet');
 insert into Duong values ( 'D0003', 'Tran Hung Dao');
 insert into Duong values ( 'D0004', 'Le Trong Tan');
 insert into Duong values ( 'D0005', 'Nguyen Thuong Hien');
 insert into Duong values ( 'D0006', 'Dien Bien Phu'); 
--32 end ------------------------------------------------------------------------------------------------

--33-----------------------------------------------------------------------------------------------------
insert into DuongThuocPhuong values('D0001', 'P0001');
insert into DuongThuocPhuong values('D0002', 'P0001');
insert into DuongThuocPhuong values('D0003', 'P0001');
insert into DuongThuocPhuong values('D0001', 'P0002');
insert into DuongThuocPhuong values('D0002', 'P0002');
insert into DuongThuocPhuong values('D0003', 'P0002');
--33 end ------------------------------------------------------------------------------------------------

SET CONSTRAINTS fk_ChiNhanh_MaNVTruong  DEFERRED;
ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MM-YYYY';
--1------------------------------------------------------------------------------------------------
Insert into chinhanh values(1, 'Phuoc Thien', '0987654321', 'D0001', 'P0001', '', '1');
Insert into chinhanh values(2, 'Tan Hoa', '0987654321', 'D0002', 'P0001', '', '2');
Insert into chinhanh values(3, 'Phat Hoa', '0987654312', 'D0003', 'P0001', '', '3');
Insert into chinhanh values(4, 'Hung Hoa', '0987654322', 'D0001', 'P0002', '', '4');
Insert into chinhanh values(5, 'Thien Ngu', '0987654322', 'D0002', 'P0002', '', '5');
Insert into chinhanh values(6, 'Kim Lang', '09876543289', 'D0003', 'P0003', '', '6');

--1 end------------------------------------------------------------------------------------------------

--2------------------------------------------------------------------------------------------------
insert into chinhanhsdt values('1', '01234567886');
insert into chinhanhsdt values('1', '01234567876');
insert into chinhanhsdt values('2', '01234567933');
insert into chinhanhsdt values('2', '01234567966');
insert into chinhanhsdt values('3', '01234567896');
insert into chinhanhsdt values('3', '01234567807');
--2 end------------------------------------------------------------------------------------------------

--3------------------------------------------------------------------------------------------------
Insert into nhanvien  
values (seq_MaNhanVien.nextval,'Nguyen Van A', '11-11-1990', '113456780','nguyenvananh@gmai.com', '0922345678', '2015', 'Truong Chi Nhanh',700000, 'D0001', 'P0001', '', 1 );
Insert into nhanvien  
values (seq_MaNhanVien.nextval,'Le Thi B', '10-11-1991', '113456781','hung.tranh@gmai.com', '0932345678', '2014', 'Truong Chi Nhanh',700000, 'D0002', 'P0001', '', 2 );
Insert into nhanvien  
values (seq_MaNhanVien.nextval,'Tran Thi Thanh Ly', '20-11-1980', '113456782','lythanh@gmai.com', '0942345678', '2016', 'Truong Chi Nhanh',14000000, 'D0003', 'P0001', '', 3 );
Insert into nhanvien  
values (seq_MaNhanVien.nextval,'Phan Quoc Tung', '22-06-1989', '113456783','quoctung@gmai.com', '0952345678', '2010', 'Truong Chi Nhanh',17000000, 'D0001', 'P0001', '', 4 );
Insert into nhanvien  
values (seq_MaNhanVien.nextval,'Tran Ba Dao', '11-12-1993', '113456784','badao@gmai.com', '0962345678', '2016', 'Truong Chi Nhanh',17000000, 'D0002', 'P0001', '', 5 );
Insert into nhanvien  
values (seq_MaNhanVien.nextval,'Nguyen Hoang Anh', '15-06-1992', '113456785','hoanganh@gmai.com', '0972345678', '2016', 'Truong Chi Nhanh',15000000, 'D0003', 'P0001', '', 6 );
Insert into nhanvien  
values (seq_MaNhanVien.nextval,'Luong Thien Cua', '22-12-1988', '113456786','thiencua@gmai.com', '0982345678', '2015', 'Nhan vien',7000000, 'D0001', 'P0002', '', 1 );
Insert into nhanvien  
values (seq_MaNhanVien.nextval,'Vuong Quoc Nga', '03-11-168', '113456787','ngaquoc@gmai.com', '0992345678', '2016', 'Nhan vien',8000000, 'D0002', 'P0002', '', 2 );
Insert into nhanvien  
values (seq_MaNhanVien.nextval,'Tran Dai Chien', '21-02-1987', '113456788','daichien@gmai.com', '0910345678', '2015', 'Nhan vien',9000000, 'D0002', 'P0002', '', 3 );
Insert into nhanvien  
values (seq_MaNhanVien.nextval,'Phan The Hiem', '12-10-1993', '113456789','thehien@gmai.com', '0911345678', '2015', 'Nhan vien',7000000, 'D0001', 'P0002', '', 4 );
Insert into nhanvien  
values (seq_MaNhanVien.nextval,'Phan Huynh Chien', '21-02-1987', '113456790','huynhchien@gmai.com', '0910345678', '2015', 'Nhan vien',9000000, 'D0002', 'P0002', '', 3 );
Insert into nhanvien  
values (seq_MaNhanVien.nextval,'Luong Ba Hiem', '12-10-1993', '113456791','bahien@gmai.com', '0911345678', '2015', 'Nhan vien',7000000, 'D0001', 'P0002', '', 4 );
--3 end------------------------------------------------------------------------------------------------
commit;

--4-----------------------------------------------------------------------------------------------------
insert into DoiTac values(1, 'Agribank Binh Duong', 'Truong Quang Dieu', '0123456789', 'D0001', 'P0001', '', 1);
insert into DoiTac values(2, 'Cong Ty Thuan Hoa 2', 'Dinh Quang Sang', '0123456789','D0002', 'P0001', '', 1);
insert into DoiTac values(3, 'Cong Ty Binh Duong',  'Dien Ba Hung', '0123457789','D0001', 'P0002', '', 2);
insert into DoiTac values(4, 'Cong Ty Thuan Hoa 3', 'Huynh Quoc Anh', '0123458789', 'D0002', 'P0002','', 2);
--4 end ------------------------------------------------------------------------------------------------

--5-----------------------------------------------------------------------------------------------------
insert into nhanvienbh (manv) values (7);
insert into nhanvienbh (manv) values (8);
insert into nhanvienbh (manv) values (9);
insert into nhanvienbh (manv) values (10);
insert into nhanvienbh (manv) values (11);
insert into nhanvienbh (manv) values (12);
--5 end ------------------------------------------------------------------------------------------------

--6-----------------------------------------------------------------------------------------------------
--insert into doanhsothang (manv, nam, thang) values(7,'2016','01');
--insert into doanhsothang (manv, nam, thang) values(7,'2016','02');
--insert into doanhsothang (manv, nam, thang) values(8,'2016','01');
--insert into doanhsothang (manv, nam, thang) values(8,'2016','02');
--insert into doanhsothang (manv, nam, thang) values(9,'2016','01');
--insert into doanhsothang (manv, nam, thang) values(9,'2016','02');

insert into doanhsothang values(7,'2016','01', 700000);
insert into doanhsothang values(7,'2016','02', 800000);
insert into doanhsothang values(8,'2016','01', 900000);
insert into doanhsothang values(8,'2016','02', 88000000);
insert into doanhsothang values(9,'2016','01', 10000000);
insert into doanhsothang values(9,'2016','02', 100000000);


--6 end ------------------------------------------------------------------------------------------------

--7-----------------------------------------------------------------------------------------------------
ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YYYY HH24:MI:SS';
--insert into tindang values('CT00000001', '15-02-2016', '15-04-2016');
--insert into tindang values('CT00000002', '03-12-2015', '03-04-2016');
--insert into tindang values('CT00000003', '06-10-2015', '06-05-2016');
--insert into tindang values('KH00000001', '07-11-2015', '07-06-2016');
--insert into tindang values('KH00000002', '10-01-2016', '10-03-2016');

--insert into tindang values('CT00000001',  TO_date('12-08-2015 10:02:30', 'DD/MM/YYYY HH24:MI:SS') , TO_date('10-08-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );
--insert into tindang values('CT00000002',  TO_date('12-08-2015 10:02:30', 'DD/MM/YYYY HH24:MI:SS') , TO_date('13-07-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );
--insert into tindang values('CT00000003',  TO_date('12-08-2015 10:02:30', 'DD/MM/YYYY HH24:MI:SS') , TO_date('12-06-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );
--insert into tindang values('KH00000001',  TO_date('12-08-2015 10:02:30', 'DD/MM/YYYY HH24:MI:SS') , TO_date('13-05-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );
--insert into tindang values('KH00000002',  TO_date('12-08-2015 10:02:30', 'DD/MM/YYYY HH24:MI:SS') , TO_date('12-05-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );
--insert into tindang values('KH00000003',  TO_date('12-08-2015 10:02:30', 'DD/MM/YYYY HH24:MI:SS') , TO_date('22-05-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );

INSERT INTO TINDANG VALUES('CT' || TO_CHAR(SEQ_MATINDANG_CT.NEXTVAL, 'FM00000000'),  TO_DATE('12-08-2015 10:02:30', 'DD/MM/YYYY HH24:MI:SS') , TO_DATE('10-08-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );
insert into tindang values('CT' || to_char(seq_matindang_CT.nextval, 'FM00000000'),  TO_date(SYSDATE, 'DD/MM/YYYY HH24:MI:SS') , TO_date('13-07-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );
INSERT INTO TINDANG VALUES('CT' || TO_CHAR(SEQ_MATINDANG_CT.NEXTVAL, 'FM00000000'),  TO_DATE(SYSDATE, 'DD/MM/YYYY HH24:MI:SS') , TO_DATE('12-06-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );
INSERT INTO TINDANG VALUES('KH' || TO_CHAR(SEQ_MATINDANG_KH.NEXTVAL, 'FM00000000'),  TO_DATE('12-08-2015 10:02:30', 'DD/MM/YYYY HH24:MI:SS') , TO_DATE('12-05-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );
insert into tindang values('KH' || to_char(seq_matindang_KH.nextval, 'FM00000000'),  TO_date(SYSDATE, 'DD/MM/YYYY HH24:MI:SS') , TO_date('13-05-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );
insert into tindang values('KH' || to_char(seq_matindang_KH.nextval, 'FM00000000'),  TO_date(SYSDATE, 'DD/MM/YYYY HH24:MI:SS') , TO_date('22-05-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );

ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YYYY';


--insert into tindang values('CT00000006',  TO_date('12-08-2015 10:02:30', 'DD/MM/YYYY HH24:MI:SS') , TO_date('12-06-2016 01:02:30', 'DD/MM/YYYY HH24:MI:SS') );
--insert into bdsdangban values('CH000002', 'CT00000001', 10000000000, 'Thanh toan 1 lan', 'De biet them thong tin lien he...');
--insert into bdsdangban values('CH000001', 'CT00000006', 10000000000, 'Thanh toan 1 lan', 'De biet them thong tin lien he...');
--
--select max(ThoiGianBD) 
--from TinDang T, BDSDangBan B
--where mabds = 'CH000001' and T.matin = B.matin ;
--



--7 end ------------------------------------------------------------------------------------------------

--8-----------------------------------------------------------------------------------------------------
insert into KhachHang values('CT' || to_char(seq_makh_ct.nextval, 'FM00000000'),'Thong Thi Minh', '1996', '11223344559', 'phan.truong@gmail.com', '0901234567', 'D0001', 'P0001', '');
insert into KhachHang values('CT' || to_char(seq_makh_ct.nextval, 'FM00000000'),'Vuong Ba Thinh', '1986', '21223344559', 'ba.vuong@gmail.com', '01234567891', 'D0002', 'P0001', '');
insert into KhachHang values('CT' || to_char(seq_makh_ct.nextval, 'FM00000000'),'Hoang Phi Hong', '1976', '31223344559', 'hongphi@gmail.com', '01234567892', 'D0003', 'P0001', '');
insert into KhachHang values('KH' || to_char(seq_makh_kh.nextval, 'FM00000000'),'Van Thi Huong', '1976', '41223344559', 'thinh.vuong@gmail.com', '01234567893', 'D0001', 'P0002', '');
insert into KhachHang values('KH' || to_char(seq_makh_kh.nextval, 'FM00000000'),'Do Duc Tai', '1976', '51223344559', 'tai.do@gmail.com', '01234567894', 'D0002', 'P0002', '');
insert into KhachHang values('KH' || to_char(seq_makh_kh.nextval, 'FM00000000'),'Minh Van Tran', '1966', '61223344559', 'vantran@gmail.com', '01234567895', 'D0003', 'P0002', '');

--8 end ------------------------------------------------------------------------------------------------

--9-----------------------------------------------------------------------------------------------------
insert into tinkhachhang values('CT00000001', 'CT00000001', 700000,0.070);
insert into tinkhachhang values('CT00000002', 'CT00000001', 800000,0.050);
insert into tinkhachhang values('CT00000003', 'CT00000001', 860000,0.040);
insert into tinkhachhang values('KH00000001', 'KH00000002', 980000,0.020);
insert into tinkhachhang values('KH00000002', 'KH00000002', 1000000,0.060);
insert into tinkhachhang values('KH00000003', 'KH00000002', 790000,0.08);
--9 end ------------------------------------------------------------------------------------------------

--10-----------------------------------------------------------------------------------------------------
insert into tinnhanvienbh values('CT00000001', 7);
insert into tinnhanvienbh values('CT00000001', 8);
insert into tinnhanvienbh values('CT00000002', 9);
insert into tinnhanvienbh values('CT00000002', 10);
insert into tinnhanvienbh values('KH00000001', 11);
insert into tinnhanvienbh values('KH00000001', 12);
--10 end ------------------------------------------------------------------------------------------------

--11-----------------------------------------------------------------------------------------------------
--insert into batdongsan values('CH000001');
--insert into batdongsan values('CH000002');
--insert into batdongsan values('CH000003');
--insert into batdongsan values('CH000004');
--insert into batdongsan values('CH000005');
--insert into batdongsan values('CH000006');
--insert into batdongsan values('CH000007');
--insert into batdongsan values('CH000008');
--
--insert into batdongsan values('NP000001');
--insert into batdongsan values('NP000002');
--insert into batdongsan values('NP000003');
--insert into batdongsan values('NP000004');
--insert into batdongsan values('NP000005');
--insert into batdongsan values('NP000006');
--insert into batdongsan values('NP000007');
--
--insert into batdongsan values('DN000001');
--insert into batdongsan values('DN000002');
--insert into batdongsan values('DN000003');
--insert into batdongsan values('DN000004');
--insert into batdongsan values('DN000005');
--insert into batdongsan values('DN000006');
insert into batdongsan values('CH' || to_char(seq_MaBds_CH.nextval, 'FM000000'));
insert into batdongsan values('CH' || to_char(seq_MaBds_CH.nextval, 'FM000000'));
insert into batdongsan values('CH' || to_char(seq_MaBds_CH.nextval, 'FM000000'));
insert into batdongsan values('CH' || to_char(seq_MaBds_CH.nextval, 'FM000000'));
insert into batdongsan values('CH' || to_char(seq_MaBds_CH.nextval, 'FM000000'));
insert into batdongsan values('CH' || to_char(seq_MaBds_CH.nextval, 'FM000000'));
insert into batdongsan values('CH' || to_char(seq_MaBds_CH.nextval, 'FM000000'));

insert into batdongsan values('NP' || to_char(seq_MaBds_NP.nextval, 'FM000000'));
insert into batdongsan values('NP' || to_char(seq_MaBds_NP.nextval, 'FM000000'));
insert into batdongsan values('NP' || to_char(seq_MaBds_NP.nextval, 'FM000000'));
insert into batdongsan values('NP' || to_char(seq_MaBds_NP.nextval, 'FM000000'));
insert into batdongsan values('NP' || to_char(seq_MaBds_NP.nextval, 'FM000000'));
insert into batdongsan values('NP' || to_char(seq_MaBds_NP.nextval, 'FM000000'));

insert into batdongsan values('DN' || to_char(seq_MaBds_DN.nextval, 'FM000000'));
insert into batdongsan values('DN' || to_char(seq_MaBds_DN.nextval, 'FM000000'));
insert into batdongsan values('DN' || to_char(seq_MaBds_DN.nextval, 'FM000000'));
insert into batdongsan values('DN' || to_char(seq_MaBds_DN.nextval, 'FM000000'));
insert into batdongsan values('DN' || to_char(seq_MaBds_DN.nextval, 'FM000000'));
insert into batdongsan values('DN' || to_char(seq_MaBds_DN.nextval, 'FM000000'));


--11 end ------------------------------------------------------------------------------------------------

--12-----------------------------------------------------------------------------------------------------
insert into bdsdangban values('CH000001', 'CT00000001', 10000000000, 'Thanh toan 1 lan', 'De biet them thong tin lien he...');
insert into bdsdangban values('CH000002', 'CT00000001', 11000000000, 'Tra gop', 'De biet them thong tin lien he...');
insert into bdsdangban values('CH000003', 'CT00000001', 12000000000, 'Thanh toan 1 lan', 'De biet them thong tin lien he...');
insert into bdsdangban values('CH000004', 'CT00000001', 13000000000, 'Tra gop', 'De biet them thong tin lien he...');
insert into bdsdangban values('NP000001', 'KH00000001', 20000000000, 'Tra gop', 'De biet them thong tin lien he...');
insert into bdsdangban values('DN000001', 'KH00000001', 25000000000, 'Thanh toan 1 lan', 'De biet them thong tin lien he...');
--12 end ------------------------------------------------------------------------------------------------

--13-----------------------------------------------------------------------------------------------------
insert into bdsdangthue values('DN000001', 'CT00000002',12000000, 30, 20000000, 'Lien he nhanh de huong khuyen mai.');
insert into bdsdangthue values('DN000002', 'CT00000002',15000000, 30, 10000000, 'Nha chinh chu');
insert into bdsdangthue values('NP000001', 'CT00000002',17000000, 30, 17000000, 'Nha chinh chu');
insert into bdsdangthue values('NP000002', 'KH00000002',21000000, 30, 28000000, 'Lien he nhanh de huong khuyen mai.');
insert into bdsdangthue values('CH000001', 'KH00000002',9000000, 30, 29000000, 'Can tien gap');
insert into bdsdangthue values('CH000002', 'KH00000002',17000000, 30, 20000000, 'Can tien gap');
insert into bdsdangthue values('CH000003', 'KH00000002',9000000, 30, 29000000, 'Can tien gap');
insert into bdsdangthue values('CH000004', 'KH00000002',17000000, 30, 20000000, 'Can tien gap');
--13 end ------------------------------------------------------------------------------------------------

--14-----------------------------------------------------------------------------------------------------
insert into GiaoDichThanhCong values('DN000001', 7, '2016','01','21', 10000000, 'Ban' );
insert into GiaoDichThanhCong values('DN000002', 7, '2016','02','22', 20000000, 'Thue' );
insert into GiaoDichThanhCong values('NP000002', 8, '2016','01','09', 12000000, 'Thue' );
insert into GiaoDichThanhCong values('CH000002', 8, '2016','02','21', 15000000, 'Thue' );
insert into GiaoDichThanhCong values('NP000001', 9, '2016','02','13', 10300000, 'Ban' );
insert into GiaoDichThanhCong values('CH000001', 9, '2016','01','28', 12000000, 'Ban' );

--------------trong mot ngay co thoi da bao nhieu viec dang tin
--14 end ------------------------------------------------------------------------------------------------

--15-----------------------------------------------------------------------------------------------------
insert into ChuongTrinhKM values(seq_mact.nextval, 'Mung ngay nha giao Viet Nam', 'Chuong trinh co gia tri tren toan quoc', '11-11-2016', '11-12-2016');
insert into ChuongTrinhKM values(seq_mact.nextval, 'Mung Dang Mung Xuan 2016', 'Chuong trinh co gia tri tren toan quoc', '20-12-2015', '11-02-2016');
insert into ChuongTrinhKM values(seq_mact.nextval, 'Giai phong hoan toan mien Nam', 'Chuong trinh co gia tri tren toan quoc', '11-03-2016', '11-04-2016');
insert into ChuongTrinhKM values(seq_mact.nextval, 'Quoc Khanh 2-9', 'Chuong trinh co gia tri tren toan quoc', '01-09-2016', '05-09-2016');
insert into ChuongTrinhKM values(seq_mact.nextval, 'Quoc te phu nu', 'Chuong trinh co gia tri tren toan quoc', '06-03-2016', '08-03-2016');
insert into ChuongTrinhKM values(seq_mact.nextval, 'Sinh nhat la thu 10', 'Chuong trinh co gia tri tren toan quoc', '10-10-2016', '13-10-2016');
--15 end ------------------------------------------------------------------------------------------------

--16-----------------------------------------------------------------------------------------------------
insert into BDSKM values(1, 'CH000001', 0);
insert into BDSKM values(1, 'CH000002', 1);
insert into BDSKM values(1, 'DN000002', 1);
insert into BDSKM values(2, 'CH000002', 0);
insert into BDSKM values(2, 'DN000002', 1);
insert into BDSKM values(3, 'NP000002', 0);
--16 end ------------------------------------------------------------------------------------------------


--18-----------------------------------------------------------------------------------------------------
insert into Loaicsht values ('Nha tre');
insert into Loaicsht values ('Truong tieu hoc');
insert into Loaicsht values ('Cong vien');
insert into Loaicsht values ('Cho');
insert into Loaicsht values ('Benh vien');
insert into Loaicsht values ('Nha hat');
--18 end ------------------------------------------------------------------------------------------------


--17--- ------------------------------------------------------------------------------------------------
insert into Cosohatang values('CSHT0001', 'Nha Tre Anh Duong'       ,'113', 'D0001', 'P0001', 'Nha tre');
insert into Cosohatang values('CSHT0002', 'Truong TH Nguyen Trai' ,'23', 'D0001', 'P0002', 'Truong tieu hoc');
insert into Cosohatang values('CSHT0003', 'Benh vien Nhi Dong 2'    ,'28', 'D0003', 'P0003', 'Benh vien');
insert into Cosohatang values('CSHT0004', 'Cong Vien Tan Phuoc'     ,'28', 'D0001', 'P0004', 'Cong vien');
insert into Cosohatang values('CSHT0005', 'Nha tre Hoa Huong Duong'    ,'28', 'D0003', 'P0003', 'Nha tre');
insert into Cosohatang values('CSHT0006', 'Truong TH My Hiep 2'     ,'28', 'D0001', 'P0004', 'Truong tieu hoc');
insert into Cosohatang values('CSHT0007', 'Cho Ba Chieu'            ,'89', 'D0005', 'P0003', 'Cho');
--17 end ------------------------------------------------------------------------------------------------



--19-----------------------------------------------------------------------------------------------------
insert into bdscsht values('CSHT0001', 'CH000001', 0.7);
insert into bdscsht values('CSHT0002', 'CH000001', 0.3);
insert into bdscsht values('CSHT0002', 'CH000002', 1.8);
insert into bdscsht values('CSHT0005', 'NP000001', 2.7);
insert into bdscsht values('CSHT0006', 'NP000001', 3.7);
insert into bdscsht values('CSHT0006', 'NP000002', 5);
insert into bdscsht values('CSHT0003', 'DN000001', 1.2);
insert into bdscsht values('CSHT0004', 'DN000001', 2.2);
--19 end ------------------------------------------------------------------------------------------------


--20-----------------------------------------------------------------------------------------------------
------------ChungCu (MaCC, Ten, NamXD, So, MaDuong, MaPhuong, TongTang, TongCH, PhiSH, SoThangMay, SoThangBo, TienIchRieng)
insert into ChungCu values('CC0001','Chung cu Son Ky', '1990', '49', 'D0001', 'P0005', 10, 80, 8000000, 3, 6, 'Cong vien, Nha tre, Nha tap the hinh');
insert into ChungCu values('CC0002','Chung cu Lu Gia', '2001', '112', 'D0002', 'P0004', 20, 400, 12000000, 12, 18, 'Truong hoc, Nha tre, Nha tap the hinh');
insert into ChungCu values('CC0003','Lan Phuong', '2012', '8', 'D0003', 'P0006', 5, 20, 7000000, 3, 6, 'Cong vien, Cho, Nha tap the hinh');
insert into ChungCu values('CC0004','Chung cu Phu Tho', '2003', '128', 'D0004', 'P0002', 12, 30, 5000000, 8, 10, 'Cong vien, Nha tre');
insert into ChungCu values('CC0005','Chung cu Phan Lam', '2013', '93', 'D0001', 'P0004', 10, 80, 3000000, 6, 16, 'Cong vien, Nha tre, Nha tap the hinh');


--20 end ------------------------------------------------------------------------------------------------

--21-----------------------------------------------------------------------------------------------------
insert into Chungcuanh values('CC0001', 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ0raDHSRLxeppVMbkW4GyAX1D659nfVMiWt8zQ4nw2oNuSUMh9');
insert into Chungcuanh values('CC0002', 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSn0h_VtSqwKSm9h3ko82XHM1mCtdvdv2RPpBgyNkAD1Hqh1ZY_Ag');
insert into Chungcuanh values('CC0002', 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ0raDHSRLxeppVMbkW4GyAX1D659nfVMiWt8zQ4nw2oNuSUMh9');
insert into Chungcuanh values('CC0003', 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSn0h_VtSqwKSm9h3ko82XHM1mCtdvdv2RPpBgyNkAD1Hqh1ZY_Ag');
insert into Chungcuanh values('CC0003', 'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQ0raDHSRLxeppVMbkW4GyAX1D659nfVMiWt8zQ4nw2oNuSUMh9');

--21 end ------------------------------------------------------------------------------------------------

--22-----------------------------------------------------------------------------------------------------
-- CanHo (MaCC, SoCH, STTTang, DienTich, SoPhongNgu, Huong, TinhTrang, GiayTo, ThongTinThem, MaBDS)
insert into CanHo values('CC0001', '101B3', 1, 50, 4, 'Dong Nam', 'Moi', 'Day du giay to', 'Khu vuc gan UBND, an ninh rat tot', 'CH000001');
insert into CanHo values('CC0002', '103H2', 1, 30, 3, 'Nam', 'DaSuDung', 'Day du giay to', 'Gan cho va trung tam mua sam', 'CH000002');
insert into CanHo values('CC0003', '301B4', 3, 40, 4, 'Tay Tay Nam', 'Moi', 'Day du giay to', 'Moi truong trong lanh sach se', 'CH000003');
insert into CanHo values('CC0004', '405B2', 4, 45, 4, 'Bac', 'Moi', 'Day du giay to', 'Gan trung tam thanh pho', 'CH000004');
insert into CanHo values('CC0003', '201A2', 2, 35, 3, 'Dong Bac', 'DaSuDung', 'Day du giay to', 'Khu vuc an ninh tot, it xay ra trom cap', 'CH000005');
insert into CanHo values('CC0003', '101B2', 2, 35, 3, 'Dong Bac', 'DaSuDung', 'Day du giay to', 'Khu vuc an ninh tot, it xay ra trom cap', 'CH000006');
insert into CanHo values('CC0003', '203A2', 2, 35, 3, 'Dong Bac', 'DaSuDung', 'Day du giay to', 'Khu vuc an ninh tot, it xay ra trom cap', 'CH000007');
--22 end ------------------------------------------------------------------------------------------------


--23-----------------------------------------------------------------------------------------------------
insert into Canhoanh values('CC0001', '101B3','http://www.alphaven.ch/Alphaven%20KITCHEN%20Apartment%20A.jpg');
insert into Canhoanh values('CC0001', '101B3','http://www.lavernevillage.com/gridmedia/img/slide4.jpg');
insert into Canhoanh values('CC0002', '103H2','http://www.alphaven.ch/Alphaven%20KITCHEN%20Apartment%20A.jpg');
insert into Canhoanh values('CC0002', '103H2','http://www.lavernevillage.com/gridmedia/img/slide4.jpg');
insert into Canhoanh values('CC0003', '301B4','http://timeandplace.com/photos/destination/paris/saint-martin/hero/paris-luxury-rental-apartment.jpg');
--23 end ------------------------------------------------------------------------------------------------


--24-----------------------------------------------------------------------------------------------------
-- NhaPho (MaNha, So, MaDuong, MaPhuong, KichThuoc, DienTich, NamXD, LoaiNha, SoPN, Huong, TinhTrang, GiayTo, ThongTinThem, MaBDS)
insert into NhaPho values ('NP0001', '103','D0001','P0004','20x30',0,'2012','Nha cap 4',5,'Dong Nam', 'Moi', 'Day du', 'Mua truc tiep mien tiep co', 'NP000001');
insert into NhaPho values ('NP0002', '59','D0003','P0005','30x50',0,'2016','Biet Thu',5,'Dong Nam', 'Moi', 'Day du', 'Can ban gap', 'NP000002');
insert into NhaPho values ('NP0003', '77','D0002','P0003','5x20',0,'2000','Nha cap 4',5,'Bac', 'DaSuDung', 'Day du', 'Can ban gap', 'NP000003');
insert into NhaPho values ('NP0004', '28','D0001','P0002','5x18',0,'2012','Nha cap 4',5,'Tay Nam', 'Moi', 'Day du', 'Can ban gap', 'NP000004');
insert into NhaPho values ('NP0005', '98','D0004','P0001','4x20',0,'2011','Nha cap 4',5,'Nam', 'Moi', 'Day du', 'Can ban gap', 'NP000005');

--24 end ------------------------------------------------------------------------------------------------


--25-----------------------------------------------------------------------------------------------------
insert into NhaPhoAnh values('NP0001', 'http://www.alphaven.ch/Alphaven%20KITCHEN%20Apartment%20A.jpg');
insert into NhaPhoAnh values('NP0001', 'http://www.lavernevillage.com/gridmedia/img/slide4.jpg');
insert into NhaPhoAnh values('NP0002', 'http://www.alphaven.ch/Alphaven%20KITCHEN%20Apartment%20A.jpg');
insert into NhaPhoAnh values('NP0002', 'http://www.lavernevillage.com/gridmedia/img/slide4.jpg');
insert into NhaPhoAnh values('NP0003', 'http://timeandplace.com/photos/destination/paris/saint-martin/hero/paris-luxury-rental-apartment.jpg');

--25 end ------------------------------------------------------------------------------------------------

--26-----------------------------------------------------------------------------------------------------
insert into KhuDuAn values('KDA0001','Khu Do thi moi Phu My Tai' , 'Cong vien, Ho boi, Nha tre', '11a', 'D0001', 'P0002');
insert into KhuDuAn values('KDA0002','Nha Moi Song Han' , 'Cong vien, Ho boi, Nha tre', '11a', 'D0003', 'P0002');
insert into KhuDuAn values('KDA0003','Star House' , 'Cong vien, Ho boi, Nha tre', '11a', 'D0002', 'P0002');
insert into KhuDuAn values('KDA0004','Song Me Kong' , 'Cong vien, Ho boi, Nha tre', '11a', 'D0004', 'P0005');
insert into KhuDuAn values('KDA0005','Diamon' , 'Cong vien, Ho boi, Nha tre', '11a', 'D0005', 'P0002');
--26 end ------------------------------------------------------------------------------------------------


--27-----------------------------------------------------------------------------------------------------
insert into DatNen values ('KDA0001', 'SL001', '15x6', 0, 'GPXD-0001', 'Dong Nam', 'Nam gan trung tam thanh pho','DN000001');
insert into DatNen values ('KDA0002', 'SL003', '14x7', 0, 'GPXD-0002', 'Tay Nam', 'Nam gan trung tam thanh pho','DN000002');
insert into DatNen values ('KDA0002', 'SL012', '15x4', 0, 'GPXD-0012', 'Dong Nam', 'Nam gan trung tam thanh pho','DN000003');
insert into DatNen values ('KDA0003', 'SL001', '15x5', 0, 'GPXD-0038', 'Dong Nam', 'Nam gan trung tam thanh pho','DN000004');
insert into DatNen values ('KDA0001', 'SL002', '15x6', 0, 'GPXD-0088', 'Dong Nam', 'Nam gan trung tam thanh pho','DN000005');

--27 end ------------------------------------------------------------------------------------------------


--28-----------------------------------------------------------------------------------------------------
insert into DatNenAnh values('KDA0001', 'SL001','http://www.alphaven.ch/Alphaven%20KITCHEN%20Apartment%20A.jpg');
insert into DatNenAnh values('KDA0002', 'SL003','http://www.lavernevillage.com/gridmedia/img/slide4.jpg');
insert into DatNenAnh values('KDA0002', 'SL003','http://www.alphaven.ch/Alphaven%20KITCHEN%20Apartment%20A.jpg');
insert into DatNenAnh values('KDA0003', 'SL001','http://www.lavernevillage.com/gridmedia/img/slide4.jpg');
insert into DatNenAnh values('KDA0003', 'SL001','http://timeandplace.com/photos/destination/paris/saint-martin/hero/paris-luxury-rental-apartment.jpg');

--28 end ------------------------------------------------------------------------------------------------


--TRIGGER CHO PHAN 2
------------------------------------------------------------------------------
create or replace 
TRIGGER TRIGGER_GDTC_GIA_UPDATE
BEFORE INSERT OR UPDATE OR DELETE ON GIAODICHTHANHCONG 
FOR EACH ROW 
declare
PRAGMA AUTONOMOUS_TRANSACTION;
gia number(12,0);
numThang int;
numTong int;
BEGIN
  numThang := -1;
  numTong := -1;
  
--  begin test
  select count(*) into numThang
  from DoanhSoThang
  where MaNV = :old.MaNV and Nam = :old.nam and Thang = :old.thang;
  dbms_output.put_line(numThang || ', oldThang');
  
  select count(*) into numTong
  from NhanVienBH
  where MaNV = :old.MaNV;
  dbms_output.put_line(numTong || ', oldTong');
--  show du lieu de test

  if(not deleting) then
      IF( :NEW.BANHOACTHUE = 'Ban') THEN
        dbms_output.put_line('test ban 1');
        select GiaBan into gia
        from bdsdangban
        WHERE MABDS = :NEW.MABDS;
        dbms_output.put_line('test ban 2');
      elsif (:new.BanHoacThue = 'Thue') then
          select GiaThue into gia
          from bdsdangthue
          where mabds = :new.mabds;
      else
        raise_application_error(-20006, 'Error BanHoacThue');
      end if;
      if(:new.gia > gia) then
      raise_application_error(-20007, 'Error value Gia');
      END IF;
  end if;--kiem tra gia trong truong hop ban hoac cho thue
--  select count(*) into num
--  from DoanhSoThang
--  where MaNV = :old.MaNV and Nam = :old.nam and Thang = :old.thang;
--  dbms_output.put_line(num || ', old');
  
  dbms_output.put_line(numThang || ', oldThangtoi day');
  
  select count(*) into numThang
  from DoanhSoThang
  where MaNV = :new.MaNV and Nam = :new.nam and Thang = :new.thang;
  
  dbms_output.put_line(numThang || ', oldThangtoi day1');
  select count(*) into numTong
  from NhanVienBH
  where MaNV = :new.MaNV;
  
  dbms_output.put_line(numTong || ', oldTongtoi day1');
  
--  xu li cho phan doanh so thang
  if(updating or deleting ) then
      update DoanhSoThang set DoanhSo  = DoanhSo - :old.gia 
      where MaNV = :old.MaNV and Nam = :old.nam and Thang = :old.thang;
      update NhanVienBH set TongDoanhSo  = TongDoanhSo - :old.gia 
      where MaNV = :old.MaNV;
  end if;  
  
--  xu li cho phan doanhthuthang
  if(not deleting) then
      if(numThang = 0) then
        insert into DoanhSoThang values(:new.manv, :new.nam, :new.thang, :new.gia);
      elsif(numThang = 1) then
        update DoanhSoThang set DoanhSo  = DoanhSo + :new.gia 
        WHERE MANV = :NEW.MANV AND NAM = :NEW.NAM AND THANG = :NEW.THANG;
      end if;   
    --  xu li cho phan tongdoanhthu
      if(numTong = 0) then
        insert into NhanVienBH values(:new.manv, :new.gia);
      elsif(numTong = 1) then
        update NhanVienBH set TongDoanhSo  = TongDoanhSo + :new.gia 
        where MaNV = :new.MaNV;
      END IF;  
  end if;
  
  -- kiem tra trong dieu kien update neu co trong chuong trinh khuyen mai
  
  
--  cap nhat thoi gian tindang cho nhung bat dong san 
  dbms_output.put_line(numTong || ', ' || :new.gia );
    commit;  
END;
/
---------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRIGGER_BDSDANGBAN_UNIQUE 
BEFORE INSERT ON BDSDANGBAN 
FOR EACH ROW 
DECLARE
MAXTHOIGIAN DATE;
INSERTthoigian date;
BEGIN
SELECT  MAX(THOIGIANKT) INTO MAXTHOIGIAN
FROM TINDANG, BDSDANGBAN
WHERE TINDANG.MATIN = BDSDANGBAN.MATIN AND BDSDANGBAN.MABDS = :NEW.MABDS;

SELECT THOIGIANBD INTO INSERTthoigian
FROM TINDANG
WHERE TINDANG.MATIN =  :NEW.MaTIN;

dbms_output.put_line('date' || INSERTTHOIGIAN || ', ' || MAXTHOIGIAN );

IF (INSERTTHOIGIAN < MAXTHOIGIAN) THEN
  raise_application_error(-20009, 'Tin dang ban hien tai con hieu luc');
end if; 
END;
/
--------------------------------------------------------------------------------------------------------
commit;


--update dia chi
--update chinhanh set diachi = (
--select tenduong || ', ' ||tenphuong || ', ' ||tenQuan || ', ' || tentp
--from duong d, phuong p, quan q, thanhpho tp
--where chinhanh.maduong  =  d.maduong and p.maphuong = chinhanh.maphuong and p.maquan = q.maquan and q.matp = tp.matp);
--
--update nhanvien set diachi = (
--select tenduong || ', ' ||tenphuong || ', ' ||tenQuan || ', ' || tentp
--from duong d, phuong p, quan q, thanhpho tp
--where nhanvien.maduong  =  d.maduong and p.maphuong = nhanvien.maphuong and p.maquan = q.maquan and q.matp = tp.matp);
--
--update doitac set diachi = (
--select tenduong || ', ' ||tenphuong || ', ' ||tenQuan || ', ' || tentp
--from duong d, phuong p, quan q, thanhpho tp
--where doitac.maduong  =  d.maduong and p.maphuong = doitac.maphuong and p.maquan = q.maquan and q.matp = tp.matp);
--
--update khachhang set diachi = (
--select tenduong || ', ' ||tenphuong || ', ' ||tenQuan || ', ' || tentp
--from duong d, phuong p, quan q, thanhpho tp
--where khachhang.maduong  =  d.maduong and p.maphuong = khachhang.maphuong and p.maquan = q.maquan and q.matp = tp.matp);



--end update dia chi
-----------
--------------
--------------
------------

























--create table dientich(
--kichthuoc varchar(20) primary key,
--dientich int,
--constraint format_kithuoc check (regexp_like(kichthuoc, '^\d{1,}x\d{1,}$'))
--);
--drop table dientich;
--insert into dientich values ('6x3',1);









--TEST FOR TRIGGER 2 
--CHO CAU 1
INSERT INTO GIAODICHTHANHCONG VALUES('CH000003', 9, '2016','03','28', 12000000, 'Ban' );

UPDATE GIAODICHTHANHCONG SET manv = 10 WHERE MABDS = 'CH000003';

DELETE GIAODICHTHANHCONG WHERE MABDS = 'CH000003';
--TABLE CAN KIEM TRA: NHANVIENBH(TONGDOANHSO), DOANHSOTHANG(DOANHSO), TINDANG;

--BEGIN CHO PHAN 2
INSERT INTO BDSDANGBAN VALUES('CH000001', 'CT00000002', 10000000000, 'Thanh toan 1 lan', 'De biet them thong tin lien he...');
delete from BDSDANGBAN where mabds = 'CH000001' and matin = 'CT00000002';
--END PHAN 2




--END TEST FOR GIAODICHHTHANHCONG

--delete doanhsothang where manv = 9 and nam ='2016'  and thang = '03';
--delete nhanvienbh where manv =12;
--
--commit;
--
--insert into doanhsothang (manv, nam, thang) values(9,'2016','02');
--commit;
--
--

------------------------------------------------------
--drop table DatNenAnh;
--drop table DatNen;
--drop table KhuDuAn;
--drop table NhaPhoAnh;
--drop table NhaPho;
--drop table CanHoAnh;
--drop table CanHo;
--drop table ChungCuAnh;
--drop table ChungCu;
--drop table  BDSCSHT;
--drop table CoSoHaTang;
--drop table LoaiCSHT;
--drop table  BDSKM;
--drop table ChuongTrinhKM;
--drop table GiaoDichThanhCong;
--drop table BDSDangThue;
--drop table BDSDangBan;
--drop table BatDongSan; 
--drop table TinNhanVienBH;
--drop table TinKhachHang ;
--drop table KhachHang;
--drop table TinDang;
--drop table DoanhSoThang;
--drop table NhanVienBH ;
--drop table DoiTac ;
--ALTER TABLE Chinhanh
--  DROP CONSTRAINT fk_ChiNhanh_MaNVTruong;
--drop table NhanVien;
--drop table ChiNhanhSDT;
--drop table ChiNhanh;
--drop table DuongThuocPhuong ;
--drop table Duong;
--drop table Phuong;
--drop table Quan;
--drop table ThanhPho;
--drop sequence seq_MaNhanVien;
--drop SEQUENCE seq_matindang_KH;
--drop SEQUENCE seq_matindang_CT;
--drop sequence seq_makh_kh;
--drop sequence seq_makh_ct;
--drop sequence seq_MaBds_CH; -- for can ho
--drop sequence seq_MaBds_NP; -- for nha pho
--drop sequence seq_MaBds_DN; -- for dat nen
--drop sequence seq_mact;



--SELECT DATA
--select TONGDOANHSOTHEOTHOIGIAN ( 7, '01','2016', '03', '2016')
--from dual;
--
--select TONGDOANHSOTHEOTHOIGIAN ( 7, '01','2016', null, null)
--from dual;
--
--select SHOWKHUYENMAI (1 )
--from dual;
--
--select TINHHUEHONG('01', '2016')
--from dual;
--
--update doitac set MaNV = (select manv
--            from nhanvien
--            where hoten = 'Le Thi B')
--where madt in (
--        select madt 
--        from doitac where manv in (
--          select manv
--          from nhanvien
--          where hoten = 'Nguyen Van A'
--        )
--);
--
--
--
----Xoa khach hang co sdt “0901234567”
----so dien thoai-> khachhang 
----xoa tin dang->
----KhachHang (MaKH, HoTen, NamSinh, CMND, Email, SDT, DiaChi)
----TinKhachHang (MaTin, MaKH, GiaTin, HueHong)
--delete tinkhachhang where
--makh  = (select makh from khachhang where sdt = '0901234567');
--
--
--SELECT C.Ten
--FROM ChuongTrinhKM C
--WHERE C.MaCT not in 
--(
--  SELECT B.MaCT
--  FROM BDSKM B
--  WHERE B.thanhcong =1 
--);


--bat dong san gan quan 10
--SELECT distinct BD.MABDS
--FROM BDSCSHT BD, COSOHATANG CS,CanHo ch, NhaPho Np,BDSDANGBAN Ban, ChungCu CC , Phuong, Quan
--WHERE BD.KhoangCach <= 5 And BD.MACSHT = CS.MACSHT And 
--(CS.TENLOAICSHT = 'Cho' OR CS.TENLOAICSHT = 'Truong tieu hoc') and 
--((ch.MABDS = BD.MABDS and ch.MACC = CC.MACC And CC.MAPHUONG = Phuong.MAPHUONG And Phuong.MaQuan = Quan.MaQuan and Quan.tenQuan = 'Quan 10')  
--or( Np.MABDS = BD.MABDS and Np.MAPHUONG = Phuong.MAPHUONG and Phuong.MaQuan = quan.maquan and Quan.TenQuan = 'Quan 10')) and
--BD.MABDS = Ban.MABDS ;
--
--
--
------- 4 can ho gan huong lan
--SELECT  C.MaCC, C.SOCH, T.MATD
--FROM CanHo C, BDSDangBan Ban, BDSDangThue  Thue, TinDang T
--WHERE C.MaCC in
--(
--  SELECT C.MaCC
--  FROM ChungCu c,  Phuong p , Quan q, ThanhPho tp
--  WHERE Ten = 'Lan Phuong' and p.tenPhuong = 'Tru?ng Th?' and
--    q.TenQuan = 'Thu Duc' and tp.tenTp= 'Ho Chi Minh' and
--    q.matp = tp.matp and p.maQuan = q.maQuan and  
--    c.maPhuong = p.maPhuong
--)  and 
--C.MaBDS not in 
-- (
--  SELECT B.MaBDS
--  FROM BDSKM B
--  WHERE B.thanhcong = 1 
--  ) 
--And (
-- (Ban.MaBDS = C.MaBDS and Ban.MaTin= T.MATD ) or
-- (Thue.MaBDS =C.MaBDS and Ban.MaTin = T.MaTD)
-- );
--
--
--select distinct bds.mabds, ch.soch, b.matin
--from batdongsan bds, bdsdangban b , bdsdangthue t, chungcu cc , canho ch, tindang td
--where (bds.mabds = b.mabds or b.mabds = b.mabds)
--      and bds.mabds not in (
--        select mabds
--        from GiaoDichThanhCong) 
--      and cc.ten = 'Lan Phuong' and cc.macc = ch.macc and ch.mabds = bds.mabds and (td.matin = b.matin or td.matin = t.matin);  
--
--
----1. doanh so cao nhat
--select ab.MANV, ab.tongdoanhso, dc.hoten
--from (select MANV, sum(doanhso) as tongdoanhso
--    from doanhsothang
--    where thang > 0 and thang < 4
--    group by manv
--    ) ab,
--    (select max(sum(doanhso)) as maxi
--    from doanhsothang
--    where thang > 0 and thang < 4
--    group by manv) bc, nhanvien dc
--where ab.tongdoanhso=bc.maxi and dc.manv = ab.manv;
--
