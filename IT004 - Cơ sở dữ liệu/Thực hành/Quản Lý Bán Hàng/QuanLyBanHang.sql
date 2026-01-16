CREATE DATABASE QLBH
USE QLBH

SET DATEFORMAT DMY

-- I. Ngôn ngữ định nghĩa dữ liệu (Data Definition Language)
-- 1. Tạo các quan hệ và khai báo các khóa chính, khóa ngoại của quan hệ.

-- Quan hệ KHACHHANG
CREATE TABLE KHACHHANG 
(
	MAKH CHAR(4),
	HOTEN VARCHAR(40),
	DCHI VARCHAR(50),
	SODT VARCHAR(20),
	NGSINH SMALLDATETIME,
	DOANHSO MONEY,
	NGDK SMALLDATETIME,
	CONSTRAINT PK_KHACHHANG PRIMARY KEY (MaKH)
)

-- Quan hệ NHANVIEN
CREATE TABLE NHANVIEN
(
	MANV CHAR(4),
	HOTEN VARCHAR(40),
	SODT VARCHAR(20),
	NGVL SMALLDATETIME,
	CONSTRAINT PK_NHANVIEN PRIMARY KEY (MANV)
)

-- Quan hệ SANPHAM
CREATE TABLE SANPHAM
(
	MASP CHAR(4),
	TENSP VARCHAR(40),
	DVT VARCHAR(20),
	NUOCSX VARCHAR(40),
	GIA MONEY,
	CONSTRAINT PK_SANPHAM PRIMARY KEY (MASP)
)

-- Quan hệ HOADON
CREATE TABLE HOADON
(
	SOHD INT,
	NGHD SMALLDATETIME,
	MAKH CHAR(4),
	MANV CHAR(4),
	TRIGIA MONEY,
	CONSTRAINT PK_HOADON PRIMARY KEY (SOHD),
	CONSTRAINT FK_HOADON_MAKH FOREIGN KEY (MAKH) REFERENCES KHACHHANG(MAKH),
    CONSTRAINT FK_HOADON_MANV FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)
)

-- Quan hệ CTHD
CREATE TABLE CTHD
(
	SOHD INT,
	MASP CHAR(4),
	SL INT,
	CONSTRAINT PK_CTHD PRIMARY KEY (SOHD, MASP),
	CONSTRAINT FK_CTHD_SOHD FOREIGN KEY (SOHD) REFERENCES HOADON (SOHD),
	CONSTRAINT FK_CTHD_MASP FOREIGN KEY (MASP) REFERENCES SANPHAM (MASP)
)

-- 2. Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM. 
ALTER TABLE SANPHAM
ADD GHICHU VARCHAR(20)

-- 3. Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG.
ALTER TABLE KHACHHANG
ADD LOAIKH TINYINT

-- 4. Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100).
ALTER TABLE SANPHAM
ALTER COLUMN GHICHU VARCHAR(100)

-- 5. Xóa thuộc tính GHICHU trong quan hệ SANPHAM.
ALTER TABLE SANPHAM
DROP COLUMN GHICHU

-- 6. Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trị là: “Vang lai”, “Thuong xuyen”, “Vip”, …
ALTER TABLE KHACHHANG
ALTER COLUMN LOAIKH VARCHAR(20)

-- 7. Đơn vị tính của sản phẩm chỉ có thể là (“cay”,”hop”,”cai”,”quyen”,”chuc”).
ALTER TABLE SANPHAM
ADD CONSTRAINT CHK_SANPHAM_DVT
CHECK ( DVT IN ('cay', 'hop', 'cai', 'quyen', 'chuc') )

-- 8. Giá bán của sản phẩm từ 500 đồng trở lên.
ALTER TABLE SANPHAM
ADD CONSTRAINT CHK_SANPHAM_GIA
CHECK ( GIA >= 500 )

-- 9. Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm.
ALTER TABLE CTHD
ADD CONSTRAINT CHK_CTHD_SL
CHECK ( SL >= 1)

-- 10. Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó.
ALTER TABLE KHACHHANG
ADD CONSTRAINT CHK_KHACHHANG_NGDK
CHECK ( NGDK > NGSINH )
GO

-- 11. Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên (NGDK).
CREATE TRIGGER TRG_INS_HOADON_1
ON HOADON
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted I
        JOIN KHACHHANG K ON I.MAKH = K.MAKH
        WHERE I.NGHD < K.NGDK
    )
    BEGIN
        RAISERROR('Loi: Ngay mua hang phai lon hon hoac bang ngay dang ky.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

-- 12. Ngày bán hàng (NGHD) của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.
CREATE TRIGGER TRG_INS_HOADON_2
ON HOADON
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM inserted I
        JOIN NHANVIEN N ON I.MANV = N.MANV
        WHERE I.NGHD < N.NGVL
    )
    BEGIN
        RAISERROR('Loi: Ngay ban hang phai lon hon hoac bang ngay vao lam.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

-- 13. Mỗi một hóa đơn phải có ít nhất một chi tiết hóa đơn. 
CREATE TRIGGER TRG_DEL_CTHD_CHECK
ON CTHD
AFTER DELETE
AS
BEGIN
    IF EXISTS ( SELECT 1 
                FROM deleted D
                WHERE NOT EXISTS ( SELECT 1 
                                   FROM CTHD C 
                                   WHERE C.SOHD = D.SOHD)
              )
    BEGIN
        RAISERROR('Loi: Moi hoa don phai co it nhat mot chi tiet hoa don. Khong the xoa chi tiet cuoi cung.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

-- 14. Trị giá của một hóa đơn là tổng thành tiền (số lượng*đơn giá) của các chi tiết thuộc hóa đơn đó.
CREATE TRIGGER TRG_INS_CTHD
ON CTHD
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE HOADON
    SET TRIGIA = (
        SELECT ISNULL(SUM(CT.SL * SP.GIA), 0)
        FROM CTHD CT 
        JOIN SANPHAM SP ON CT.MASP = SP.MASP
        WHERE CT.SOHD = HOADON.SOHD
    )
    WHERE SOHD IN (
        SELECT DISTINCT SOHD FROM inserted
        UNION
        SELECT DISTINCT SOHD FROM deleted
    );
END
GO

-- 15. Doanh số của một khách hàng là tổng trị giá các hóa đơn mà khách hàng thành viên đó đã mua.
CREATE TRIGGER TRG_INS_HOADON_4
ON HOADON
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE KHACHHANG
    SET DOANHSO = (
        SELECT ISNULL(SUM(TRIGIA), 0) 
        FROM HOADON 
        WHERE MAKH = KHACHHANG.MAKH
    )
    WHERE MAKH IN (
        SELECT DISTINCT MAKH FROM inserted
        UNION
        SELECT DISTINCT MAKH FROM deleted
    );
END
GO

-- II. Ngôn ngữ thao tác dữ liệu (Data Manipulation Language)
-- 1. Nhập dữ liệu cho các quan hệ trên.
INSERT INTO NHANVIEN (MANV, HOTEN, SODT, NGVL)
VALUES
('NV01', 'Nguyen Nhu Nhut', '0927345678', '13/04/2006'),
('NV02', 'Le Thi Phi Yen', '0987567390', '21/04/2006'),
('NV03', 'Nguyen Van B', '0997047382', '27/04/2006'),
('NV04', 'Ngo Thanh Tuan', '0913758498', '24/06/2006'),
('NV05', 'Nguyen Thi Truc Thanh', '0918590387', '20/07/2006')

INSERT INTO KHACHHANG (MAKH, HOTEN, DCHI, SODT, NGSINH, DOANHSO, NGDK)
VALUES
('KH01', 'Nguyen Van A', '731 Tran Hung Dao, Q5, TpHCM', '08823451', '22/10/1960', 13060000, '22/07/2006'),
('KH02', 'Tran Ngoc Han', '23/5 Nguyen Trai, Q5, TpHCM', '0908256478', '03/04/1974', 280000, '30/07/2006'),
('KH03', 'Tran Ngoc Linh', '45 Nguyen Canh Chan, Q1, TpHCM', '0938776266', '12/06/1980', 3860000, '05/08/2006'),
('KH04', 'Tran Minh Long', '50/34 Le Dai Hanh, Q10, TpHCM', '0917325476', '09/03/1965', 250000, '02/10/2006'),
('KH05', 'Le Nhat Minh', '34 Truong Dinh, Q3, TpHCM', '08246108', '10/03/1950', 21000, '28/10/2006'),
('KH06', 'Le Hoai Thuong', '227 Nguyen Van Cu, Q5, TpHCM', '08631738', '31/12/1981', 915000, '24/11/2006'),
('KH07', 'Nguyen Van Tam', '32/3 Tran Binh Trong, Q5, TpHCM', '0916783565', '06/04/1971', 12500, '01/12/2006'),
('KH08', 'Phan Thi Thanh', '45/2 An Duong Vuong, Q5, TpHCM', '0938435756', '10/01/1971', 365000, '13/12/2006'),
('KH09', 'Le Ha Vinh', '873 Le Hong Phong, Q5, TpHCM', '08654763', '03/09/1979', 70000, '14/01/2007'),
('KH10', 'Ha Duy Lap', '34/34B Nguyen Trai, Q1, TpHCM', '08768904', '02/05/1983', 67500, '16/01/2007')

INSERT INTO SANPHAM (MASP, TENSP, DVT, NUOCSX, GIA)
VALUES
('BC01', 'But chi', 'cay', 'Singapore', 3000),
('BC02', 'But chi', 'cay', 'Singapore', 5000),
('BC03', 'But chi', 'cay', 'Viet Nam', 3500),
('BC04', 'But chi', 'hop', 'Viet Nam', 30000),
('BB01', 'But bi', 'cay', 'Viet Nam', 5000),
('BB02', 'But bi', 'cay', 'Trung Quoc', 7000),
('BB03', 'But bi', 'hop', 'Thai Lan', 100000),
('TV01', 'Tap 100 giay mong', 'quyen', 'Trung Quoc', 2500),
('TV02', 'Tap 200 giay mong', 'quyen', 'Trung Quoc', 4500),
('TV03', 'Tap 100 giay tot', 'quyen', 'Viet Nam', 3000),
('TV04', 'Tap 200 giay tot', 'quyen', 'Viet Nam', 5500),
('TV05', 'Tap 100 trang', 'chuc', 'Viet Nam', 23000),
('TV06', 'Tap 200 trang', 'chuc', 'Viet Nam', 53000),
('TV07', 'Tap 100 trang', 'chuc', 'Trung Quoc', 34000),
('ST01', 'So tay 500 trang', 'quyen', 'Trung Quoc', 40000),
('ST02', 'So tay loai 1', 'quyen', 'Viet Nam', 55000),
('ST03', 'So tay loai 2', 'quyen', 'Viet Nam', 51000),
('ST04', 'So tay', 'quyen', 'Thai Lan', 55000),
('ST05', 'So tay mong', 'quyen', 'Thai Lan', 20000),
('ST06', 'Phan viet bang', 'hop', 'Viet Nam', 5000),
('ST07', 'Phan khong bui', 'hop', 'Viet Nam', 7000),
('ST08', 'Bong bang', 'cai', 'Viet Nam', 1000),
('ST09', 'But long', 'cay', 'Viet Nam', 5000),
('ST10', 'But long', 'cay', 'Trung Quoc', 7000)

INSERT INTO HOADON (SOHD, NGHD, MAKH, MANV, TRIGIA)
VALUES
(1001, '23/07/2006', 'KH01', 'NV01', 320000),
(1002, '12/08/2006', 'KH01', 'NV02', 840000),
(1003, '23/08/2006', 'KH02', 'NV01', 100000),
(1004, '01/09/2006', 'KH02', 'NV01', 180000),
(1005, '20/10/2006', 'KH01', 'NV02', 3800000),
(1006, '16/10/2006', 'KH01', 'NV03', 2430000),
(1007, '28/10/2006', 'KH03', 'NV03', 510000),
(1008, '28/10/2006', 'KH01', 'NV03', 440000),
(1009, '28/10/2006', 'KH03', 'NV04', 200000),
(1010, '01/11/2006', 'KH01', 'NV01', 5200000),
(1011, '04/11/2006', 'KH04', 'NV03', 250000),
(1012, '30/11/2006', 'KH05', 'NV03', 21000),
(1013, '12/12/2006', 'KH06', 'NV01', 5000),
(1014, '31/12/2006', 'KH03', 'NV02', 3150000),
(1015, '01/01/2007', 'KH06', 'NV01', 910000),
(1016, '01/01/2007', 'KH07', 'NV02', 12500),
(1017, '02/01/2007', 'KH08', 'NV03', 35000),
(1018, '13/01/2007', 'KH08', 'NV03', 330000),
(1019, '13/01/2007', 'KH01', 'NV03', 30000),
(1020, '14/01/2007', 'KH09', 'NV04', 70000),
(1021, '16/01/2007', 'KH10', 'NV03', 67500),
(1022, '16/01/2007', NULL, 'NV03', 7000),
(1023, '17/01/2007', NULL, 'NV01', 330000)

INSERT INTO CTHD (SOHD, MASP, SL)
VALUES
(1001, 'TV02', 10),
(1001, 'ST01', 5),
(1001, 'BC01', 5),
(1001, 'BC02', 10),
(1001, 'ST08', 10),
(1002, 'BC04', 20),
(1002, 'BB01', 20),
(1002, 'BB02', 20),
(1003, 'BB03', 10),
(1004, 'TV01', 20),
(1004, 'TV02', 10),
(1004, 'TV03', 10),
(1004, 'TV04', 10),
(1005, 'TV05', 50),
(1005, 'TV06', 50),
(1006, 'TV07', 20),
(1006, 'ST01', 30),
(1006, 'ST02', 10),
(1007, 'ST03', 10),
(1008, 'ST04', 8),
(1009, 'ST05', 10),
(1010, 'TV07', 50),
(1010, 'ST07', 50),
(1010, 'ST08', 100),
(1010, 'ST04', 50),
(1010, 'TV03', 100),
(1011, 'ST06', 50),
(1012, 'ST07', 3),
(1013, 'ST08', 5),
(1014, 'BC02', 80),
(1014, 'BB02', 100),
(1014, 'BC04', 60),
(1014, 'BB01', 50),
(1015, 'BB02', 30),
(1015, 'BB03', 7),
(1016, 'TV01', 5),
(1017, 'TV02', 1),
(1017, 'TV03', 1),
(1017, 'TV04', 5),
(1018, 'ST04', 6),
(1019, 'ST05', 1),
(1019, 'ST06', 2),
(1020, 'ST07', 10),
(1021, 'ST08', 5),
(1021, 'TV01', 7),
(1021, 'TV02', 10),
(1022, 'ST07', 1),
(1023, 'ST04', 6)

-- 2a. Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM.
SELECT * INTO SANPHAM1 
FROM SANPHAM

-- 2b. Tạo quan hệ KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG.
SELECT * INTO KHACHHANG1 
FROM KHACHHANG

-- 3. Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất (cho quan hệ SANPHAM1).
UPDATE SANPHAM1
SET GIA = GIA * 1.05
WHERE NUOCSX = 'Thai Lan'

-- 4. Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống (cho quan hệ SANPHAM1).
UPDATE SANPHAM1
SET GIA = GIA * 0.95
WHERE NUOCSX = 'Trung Quoc' AND GIA <= 10000

-- 5. Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước 
--	  ngày 1/1/2007 có doanh số từ 10.000.000 trở lên hoặc khách hàng đăng ký thành viên từ 
--    1/1/2007 trở về sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG1).
UPDATE KHACHHANG1
SET LOAIKH = 'Vip'
WHERE (
    ( NGDK < '1/1/2007' AND DOANHSO >= 10000000 )
    OR
    ( NGDK >= '1/1/2007' AND DOANHSO >= 2000000 )
)

-- III. Ngôn ngữ truy vấn dữ liệu
-- 1. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'

-- 2. In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
SELECT MASP, TENSP
FROM SANPHAM
WHERE DVT IN ('cay', 'quyen')

-- 3. In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP LIKE 'B%01'

-- 4. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP
FROM SANPHAM
WHERE (NUOCSX = 'Trung Quoc') AND (GIA BETWEEN 30000 AND 40000)

-- 5. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP
FROM SANPHAM
WHERE (NUOCSX IN ('Trung Quoc', 'Thai Lan')) AND (GIA BETWEEN 30000 AND 40000)

-- 6. In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD IN ('1/1/2007', '2/1/2007')

-- 7. In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT SOHD, TRIGIA, NGHD
FROM HOADON
WHERE MONTH(NGHD) = 1 AND YEAR(NGHD) = 2007
ORDER BY NGHD ASC, TRIGIA DESC

-- 8. In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT DISTINCT MAKH, HOTEN
FROM KHACHHANG
WHERE MAKH IN ( SELECT MAKH
                FROM HOADON
                WHERE NGHD = '1/1/2007' )

-- 9. In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
SELECT SOHD, TRIGIA
FROM HOADON INNER JOIN NHANVIEN
ON HOADON.MANV = NHANVIEN.MANV
WHERE (HOTEN = 'Nguyen Van B') AND (NGHD = '28/10/2006')

-- 10. In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
SELECT DISTINCT HD.SOHD, SP.MASP, SP.TENSP, KH.HOTEN, HD.NGHD
FROM 
    SANPHAM SP INNER JOIN CTHD CT 
    ON SP.MASP = CT.MASP
    INNER JOIN HOADON HD 
    ON CT.SOHD = HD.SOHD
    INNER JOIN KHACHHANG KH 
    ON HD.MAKH = KH.MAKH
WHERE (KH.HOTEN = 'Nguyen Van A') 
  AND (MONTH(HD.NGHD) = 10) 
  AND (YEAR(HD.NGHD) = 2006)

-- 11. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT DISTINCT SOHD, MASP, SL
FROM CTHD
WHERE MASP IN ('BB01', 'BB02')

-- 12. Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT DISTINCT SOHD
FROM CTHD
WHERE MASP IN ('BB01', 'BB02') AND (SL BETWEEN 10 AND 20)

-- 13. Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD
FROM CTHD
WHERE MASP = 'BB01' AND (SL BETWEEN 10 AND 20)
INTERSECT
SELECT SOHD
FROM CTHD
WHERE MASP = 'BB02' AND (SL BETWEEN 10 AND 20)

-- 14. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
UNION
SELECT SP.MASP, TENSP
FROM SANPHAM SP INNER JOIN CTHD CT
ON SP.MASP = CT.MASP
INNER JOIN HOADON HD
ON CT.SOHD = HD.SOHD
WHERE NGHD = '1/1/2007'

-- 15. In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NOT EXISTS ( SELECT MASP
                   FROM CTHD
                   WHERE SANPHAM.MASP = CTHD.MASP )

-- 16. In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM SP
WHERE NOT EXISTS ( SELECT MASP
                   FROM CTHD CT INNER JOIN HOADON HD
                   ON CT.SOHD = HD.SOHD
                   WHERE SP.MASP = CT.MASP AND YEAR(NGHD) = '2006' )

-- 17. In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM SP
WHERE NUOCSX = 'Trung Quoc' AND 
      NOT EXISTS ( SELECT MASP
                   FROM CTHD CT INNER JOIN HOADON HD
                   ON CT.SOHD = HD.SOHD
                   WHERE SP.MASP = CT.MASP AND YEAR(NGHD) = '2006')

-- 18. Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
SELECT SOHD
FROM CTHD CT INNER JOIN SANPHAM SP
ON CT.MASP = SP.MASP
WHERE NUOCSX = 'Singapore'
GROUP BY SOHD
HAVING COUNT(DISTINCT CT.MASP) = ( SELECT COUNT(MASP)
                                   FROM SANPHAM
                                   WHERE NUOCSX = 'Singapore' )

-- 19. Tìm số hóa đơn trong năm 2006 đã mua ít nhất tất cả các sản phẩm do Singapore sản xuất.
SELECT CTHD.SOHD
FROM CTHD INNER JOIN HOADON 
ON CTHD.SOHD = HOADON.SOHD
WHERE YEAR(NGHD) = 2006 AND MASP IN ( SELECT MASP
                                      FROM SANPHAM
                                      WHERE NUOCSX = 'Singapore' )
GROUP BY CTHD.SOHD
HAVING COUNT(DISTINCT MASP) = ( SELECT COUNT(MASP)
                                FROM SANPHAM
                                WHERE NUOCSX = 'Singapore' )

-- 20. Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(*) SO_HOA_DON 
FROM HOADON
WHERE MAKH IS NULL

-- 21. Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT COUNT(DISTINCT MASP) SO_SAN_PHAM
FROM CTHD CT INNER JOIN HOADON HD 
ON CT.SOHD = HD.SOHD
WHERE YEAR(NGHD) = 2006

-- 22. Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
SELECT MAX(TRIGIA) TRI_GIA_CAO_NHAT, MIN(TRIGIA) TRI_GIA_THAP_NHAT
FROM HOADON

-- 23. Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) TRI_GIA_TRUNG_BINH
FROM HOADON
WHERE YEAR(NGHD) = 2006

-- 24. Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(TRIGIA) DOANH_THU_BAN_HANG
FROM HOADON
WHERE YEAR(NGHD) = 2006

-- 25. Tìm số hóa đơn có trị giá cao nhất trong năm 2006. 
SELECT SOHD
FROM HOADON
WHERE YEAR(NGHD) = 2006
AND TRIGIA = ( SELECT MAX(TRIGIA) 
               FROM HOADON 
               WHERE YEAR(NGHD) = 2006 )

-- 26. Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT HOTEN 
FROM KHACHHANG INNER JOIN HOADON
ON KHACHHANG.MAKH = HOADON.MAKH
WHERE YEAR(NGHD) = 2006
AND
TRIGIA = ( SELECT MAX(TRIGIA)
           FROM HOADON )

-- 27. In ra danh sách 3 khách hàng đầu tiên (MAKH, HOTEN) sắp xếp theo doanh số giảm dần.
SELECT TOP 3 MAKH, HOTEN 
FROM KHACHHANG 
ORDER BY DOANHSO DESC

-- 28. In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT MASP, TENSP 
FROM SANPHAM
WHERE GIA IN( SELECT DISTINCT TOP 3 GIA 
              FROM SANPHAM
              ORDER BY GIA DESC )

-- 29. In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT MASP, TENSP 
FROM SANPHAM
WHERE NUOCSX = 'Thai Lan' 
AND 
GIA IN( SELECT DISTINCT TOP 3 GIA 
        FROM SANPHAM
        ORDER BY GIA DESC )

-- 30. In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT MASP, TENSP 
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' 
AND 
GIA IN( SELECT DISTINCT TOP 3 GIA 
        FROM SANPHAM
        WHERE NUOCSX = 'Trung Quoc'
        ORDER BY GIA DESC )

-- 31. In ra danh sách khách hàng nằm trong 3 hạng cao nhất (xếp hạng theo doanh số).
SELECT TOP 3 WITH TIES MAKH, HOTEN
FROM KHACHHANG
ORDER BY DOANHSO DESC

-- 32. Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT COUNT(MASP) TONG_SO_SAN_PHAM_TQ_SAN_XUAT
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'

-- 33. Tính tổng số sản phẩm của từng nước sản xuất.
SELECT NUOCSX, COUNT(MASP) TONG_SO_SAN_PHAM
FROM SANPHAM
GROUP BY NUOCSX

-- 34. Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT NUOCSX, MAX(GIA) GIAMAX, MIN(GIA) GIAMIN, AVG(GIA) TRUNGBINH 
FROM SANPHAM 
GROUP BY NUOCSX

-- 35. Tính doanh thu bán hàng mỗi ngày.
SELECT NGHD, SUM(TRIGIA) DOANHTHU 
FROM HOADON 
GROUP BY NGHD

-- 36. Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT  CT.MASP, SUM(SL) SL
FROM CTHD CT INNER JOIN HOADON HD 
ON CT.SOHD = HD.SOHD
WHERE YEAR(NGHD) = '2006' AND MONTH(NGHD) = '10'
GROUP BY CT.MASP

-- 37. Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(NGHD) THANG, SUM(TRIGIA) DOANH_THU
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)

-- 38. Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
SELECT SOHD FROM CTHD
GROUP BY SOHD 
HAVING COUNT(DISTINCT MASP) >= 4

-- 39. Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
SELECT SOHD FROM CTHD CT INNER JOIN SANPHAM SP
ON CT.MASP = SP.MASP
WHERE NUOCSX = 'Viet Nam'
GROUP BY SOHD 
HAVING COUNT(DISTINCT CT.MASP) = 3

-- 40. Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất.
SELECT TOP 1 WITH TIES KH.MAKH, KH.HOTEN
FROM KHACHHANG KH INNER JOIN HOADON HD
ON KH.MAKH = HD.MAKH
GROUP BY KH.MAKH, KH.HOTEN
ORDER BY COUNT(HD.SOHD) DESC

-- 41. Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
SELECT TOP 1 WITH TIES MONTH(NGHD) AS THANG_DOANH_SO_CAO_NHAT
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY SUM(TRIGIA) DESC

-- 42. Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT TOP 1 WITH TIES SP.MASP, SP.TENSP
FROM SANPHAM SP 
INNER JOIN CTHD CT ON SP.MASP = CT.MASP
INNER JOIN HOADON HD ON CT.SOHD = HD.SOHD
WHERE YEAR(HD.NGHD) = 2006
GROUP BY SP.MASP, SP.TENSP
ORDER BY SUM(CT.SL) ASC

-- 43. Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
SELECT SP1.NUOCSX, MASP, TENSP
FROM SANPHAM SP1
WHERE SP1.GIA = ( SELECT MAX(GIA)
                  FROM SANPHAM SP2
                  WHERE SP2.NUOCSX = SP1.NUOCSX )

-- 44. Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
SELECT NUOCSX FROM SANPHAM 
GROUP BY NUOCSX
HAVING COUNT(DISTINCT GIA) >= 3

-- 45. Trong 10 khách hàng có doanh số cao nhất, tìm khách hàng có số lần mua hàng nhiều nhất.
SELECT TOP 1 WITH TIES KH.MAKH, KH.HOTEN
FROM KHACHHANG KH 
INNER JOIN HOADON HD ON KH.MAKH = HD.MAKH
WHERE KH.MAKH IN ( SELECT TOP 10 MAKH 
                   FROM KHACHHANG 
                   ORDER BY DOANHSO DESC )
GROUP BY KH.MAKH, KH.HOTEN
ORDER BY COUNT(HD.SOHD) DESC