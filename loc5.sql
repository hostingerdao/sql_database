select * from sys.batdongsan where mabds not in(
select mabds from sys.giaodichthanhcong) order by mabds;

select count(*) from sys.BDSDANGBAN where mabds = 'CH000001';
select count(*) from sys.BDSDANGTHUE where mabds = 'CH000001';

select GiaBan    from sys.bdsdangban    WHERE ROWNUM = 1 and MABDS = 'CH000003';
INSERT INTO GIAODICHTHANHCONG VALUES('CH000003', 9, '2016','03','28', 12000000, 'Ban' );

select * from sys.giaodichthanhcong;
commit;
select nv.manv, nv.hoten from sys.nhanvienbh bh, sys.nhanvien nv where bh.manv = nv.manv;

commit;
INSERT INTO sys.GIAODICHTHANHCONG VALUES('CH000003', 7, '2016','02','01', 300000, 'Ban' );

select * from sys.GIAODICHTHANHCONG where mabds = 'CH000001';


update sys.GiaoDichThanhCong set MaNV = 9, Nam = '2016', Thang = '02', Ngay = '29', Gia = 1000000, BanHoacThue = 'Ban' where maBDS = 'CH000001';
commit;

delete sys.GiaoDichThanhCong where mabds = 'CH000001';