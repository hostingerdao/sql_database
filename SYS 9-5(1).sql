SELECT * FROM SYS.CHINHANH;
commit;

GRANT SELECT ON THANHPHO TO NHANSUADMIN; 
GRANT SELECT ON QUAN TO NHANSUADMIN; 
GRANT SELECT ON PHUONG TO NHANSUADMIN;
GRANT SELECT ON DUONG TO NHANSUADMIN; 
GRANT CREATE ANY TRIGGER TO NHANSUADMIN;


