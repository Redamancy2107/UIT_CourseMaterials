CREATE DATABASE QLGV
USE QLGV

SET DATEFORMAT DMY

-- I. Ngôn ngữ định nghĩa dữ liệu (Data Definition Language)
-- 1a. Tạo quan hệ và khai báo tất cả các ràng buộc khóa chính, khóa ngoại.

-- Quan hệ GIAOVIEN
CREATE TABLE GIAOVIEN
(
	MAGV CHAR(4),
	HOTEN VARCHAR(40),
	HOCVI VARCHAR(10),
	HOCHAM VARCHAR(10),
	GIOITINH VARCHAR(3),
	NGSINH SMALLDATETIME,
	NGVL SMALLDATETIME,
	HESO NUMERIC(4, 2),
	MUCLUONG MONEY,
	MAKHOA VARCHAR(4),
	CONSTRAINT PK_GIAOVIEN PRIMARY KEY (MAGV)
)

-- Quan hệ KHOA
CREATE TABLE KHOA
(
	MAKHOA VARCHAR(4),
	TENKHOA VARCHAR(40),
	NGTLAP SMALLDATETIME,
	TRGKHOA CHAR(4),
	CONSTRAINT PK_KHOA PRIMARY KEY (MAKHOA)
)

ALTER TABLE KHOA
ADD CONSTRAINT FK_KHOA_TRGKHOA
FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV)

ALTER TABLE GIAOVIEN
ADD CONSTRAINT FK_GIAOVIEN_MAKHOA
FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)

-- Quan hệ HOCVIEN
CREATE TABLE HOCVIEN
(
	MAHV CHAR(5),
	HO VARCHAR(40),
	TEN VARCHAR(10),
	NGSINH SMALLDATETIME,
	GIOITINH VARCHAR(3),
	NOISINH VARCHAR(40),
	MALOP CHAR(3),
	CONSTRAINT PK_HOCVIEN PRIMARY KEY (MAHV)
)

-- Quan hệ LOP
CREATE TABLE LOP
(
	MALOP CHAR(3),
	TENLOP VARCHAR(40),
	TRGLOP CHAR(5),
	SISO TINYINT,
	MAGVCN CHAR(4),
	CONSTRAINT PK_LOP PRIMARY KEY (MALOP)
)

ALTER TABLE LOP
ADD CONSTRAINT FK_LOP_TRGLOP
FOREIGN KEY (TRGLOP) REFERENCES HOCVIEN(MAHV)

ALTER TABLE LOP
ADD CONSTRAINT FK_LOP_MAGVCN
FOREIGN KEY (MAGVCN) REFERENCES GIAOVIEN(MAGV)

ALTER TABLE HOCVIEN
ADD CONSTRAINT FK_HOCVIEN_MALOP
FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)

-- Quan hệ MONHOC
CREATE TABLE MONHOC 
(
	MAMH VARCHAR(10),
	TENMH VARCHAR(40),
	TCLT TINYINT,
	TCTH TINYINT,
	MAKHOA VARCHAR(4),
	CONSTRAINT PK_MONHOC PRIMARY KEY (MAMH),
	CONSTRAINT FK_MONHOC_MAKHOA FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
)

-- Quan hệ DIEUKIEN
CREATE TABLE DIEUKIEN
(
	MAMH VARCHAR(10),
	MAMH_TRUOC VARCHAR(10),
	CONSTRAINT PK_DIEUKIEN PRIMARY KEY (MAMH, MAMH_TRUOC),
	CONSTRAINT FK_DIEUKIEN_MAMH FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
	CONSTRAINT FK_DIEUKIEN_MAMH_TRUOC FOREIGN KEY (MAMH_TRUOC) REFERENCES MONHOC(MAMH)
)

-- Quan hệ GIANGDAY
CREATE TABLE GIANGDAY
(
	MALOP CHAR(3),
	MAMH VARCHAR(10),
	MAGV CHAR(4),
	HOCKY TINYINT,
	NAM SMALLINT,
	TUNGAY SMALLDATETIME,
	DENNGAY SMALLDATETIME,
	CONSTRAINT PK_GIANGDAY PRIMARY KEY (MALOP, MAMH),
	CONSTRAINT FK_GIANGDAY_MALOP FOREIGN KEY (MALOP) REFERENCES LOP(MALOP),
	CONSTRAINT FK_GIANGDAY_MAMH FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH),
	CONSTRAINT FK_GIANGDAY_MAGV FOREIGN KEY (MAGV) REFERENCES GIAOVIEN(MAGV)
)

-- Quan hệ KETQUATHI
CREATE TABLE KETQUATHI
(
	MAHV CHAR(5),
	MAMH VARCHAR(10),
	LANTHI TINYINT,
	NGTHI SMALLDATETIME,
	DIEM NUMERIC(4, 2),
	KQUA VARCHAR(10),
	CONSTRAINT PK_KETQUATHI PRIMARY KEY (MAHV, MAMH, LANTHI),
	CONSTRAINT FK_KETQUATHI_MAHV FOREIGN KEY (MAHV) REFERENCES HOCVIEN(MAHV),
	CONSTRAINT FK_KETQUATHI_MAMH FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
)

-- 1b. Thêm vào 3 thuộc tính GHICHU, DIEMTB, XEPLOAI cho quan hệ HOCVIEN.
ALTER TABLE HOCVIEN
ADD GHICHU VARCHAR(50),
    DIEMTB NUMERIC(4, 2),
    XEPLOAI VARCHAR(10)

-- 2. Mã học viên là một chuỗi 5 ký tự, 3 ký tự đầu là mã lớp, 2 ký tự cuối cùng là số thứ tự học viên trong lớp. VD: “K1101”
ALTER TABLE HOCVIEN
ADD CONSTRAINT CHK_HOCVIEN_MAHV
CHECK ( LEN(MAHV) = 5 AND LEFT(MAHV, 3) = MALOP AND ISNUMERIC(RIGHT(MAHV, 2)) = 1 )

-- 3. Thuộc tính GIOITINH chỉ có giá trị là “Nam” hoặc “Nu”.
ALTER TABLE HOCVIEN
ADD CONSTRAINT CHK_HOCVIEN_GIOITINH
CHECK ( GIOITINH IN ('Nam', 'Nu') )

ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHK_GIAOVIEN_GIOITINH 
CHECK ( GIOITINH IN ('Nam', 'Nu') )

-- 4. Điểm số của một lần thi có giá trị từ 0 đến 10 và cần lưu đến 2 số lẽ (VD: 6.22).
ALTER TABLE KETQUATHI
ADD CONSTRAINT CHK_KETQUATHI_DIEM 
CHECK (DIEM BETWEEN 0 AND 10)

-- 5. Kết quả thi là “Dat” nếu điểm từ 5 đến 10  và “Khong dat” nếu điểm nhỏ hơn 5.
ALTER TABLE KETQUATHI
ADD CONSTRAINT CHK_KETQUATHI_KQUA CHECK (
    (KQUA = 'Dat' AND DIEM BETWEEN 5 AND 10) OR
    (KQUA = 'Khong dat' AND DIEM < 5)
)

-- 6. Học viên thi một môn tối đa 3 lần.
ALTER TABLE KETQUATHI
ADD CONSTRAINT CHK_KETQUATHI_LANTHI 
CHECK ( LANTHI BETWEEN 1 AND 3 )

-- 7. Học kỳ chỉ có giá trị từ 1 đến 3.
ALTER TABLE GIANGDAY
ADD CONSTRAINT CHK_GIANGDAY_HOCKY 
CHECK ( HOCKY BETWEEN 1 AND 3 )

-- 8. Học vị của giáo viên chỉ có thể là “CN”, “KS”, “Ths”, ”TS”, ”PTS”.
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHK_GIAOVIEN_HOCVI 
CHECK ( HOCVI IN ('CN','KS','Ths','TS','PTS') )

-- 9. Lớp trưởng của một lớp phải là học viên của lớp đó.
-- 10. Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”. 
-- 11. Học viên ít nhất là 18 tuổi.
ALTER TABLE HOCVIEN
ADD CONSTRAINT CHK_HOCVIEN_TUOI 
CHECK ( YEAR(GETDATE()) - YEAR(NGSINH) >= 18 )

-- 12. Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY).
ALTER TABLE GIANGDAY
ADD CONSTRAINT CHK_GIANGDAY_NGAY 
CHECK ( TUNGAY < DENNGAY )

-- 13. Giáo viên khi vào làm ít nhất là 22 tuổi.
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CHK_GIAOVIEN_TUOI 
CHECK ( YEAR(NGVL) - YEAR(NGSINH) >= 22 )

-- 14. Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3. 
ALTER TABLE MONHOC
ADD CONSTRAINT CHK_MONHOC_TINCHI 
CHECK ( ABS(TCLT - TCTH) <= 3 )
GO

-- 15. Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này. 
CREATE TRIGGER TRG_KETQUATHI_NGAYTHI_HOCXONG
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM INSERTED I
        JOIN HOCVIEN HV ON I.MAHV = HV.MAHV
        JOIN GIANGDAY GD ON GD.MALOP = HV.MALOP AND GD.MAMH = I.MAMH
        WHERE I.NGTHI < GD.DENNGAY
    )
    BEGIN
        RAISERROR('Lỗi: Học viên chỉ được thi khi lớp đã học xong môn học.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

-- 16. Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn.
CREATE TRIGGER TRG_GIANGDAY_SOLUONGMON
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT MALOP, HOCKY, NAM
        FROM GIANGDAY
        GROUP BY MALOP, HOCKY, NAM
        HAVING COUNT(MAMH) > 3
    )
    BEGIN
        RAISERROR('Lỗi: Mỗi lớp chỉ được học tối đa 3 môn trong một học kỳ.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

-- 17. Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó.
CREATE TRIGGER TRG_HOCVIEN_UPDATESISO
ON HOCVIEN
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
    UPDATE LOP
    SET SISO = (SELECT COUNT(*) FROM HOCVIEN WHERE MALOP = LOP.MALOP)
    WHERE MALOP IN (SELECT MALOP FROM INSERTED UNION SELECT MALOP FROM DELETED);
END;

-- 18. Trong quan hệ DIEUKIEN giá trị của thuộc tính MAMH và MAMH_TRUOC trong cùng một bộ không được giống nhau (“A”,”A”) và cũng không tồn tại hai bộ (“A”,”B”) và (“B”,”A”). 
ALTER TABLE DIEUKIEN
ADD CONSTRAINT CHK_DIEUKIEN_MAMH 
CHECK (MAMH <> MAMH_TRUOC)
GO

CREATE TRIGGER TRG_DIEUKIEN_VONG
ON DIEUKIEN
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM INSERTED I
        JOIN DIEUKIEN D ON I.MAMH = D.MAMH_TRUOC AND I.MAMH_TRUOC = D.MAMH
    )
    BEGIN
        RAISERROR('Lỗi: Tồn tại tham chiếu vòng trong điều kiện tiên quyết.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

-- 19. Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau. 
CREATE TRIGGER TRG_GIAOVIEN_MUCLUONG
ON GIAOVIEN
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM INSERTED I
        JOIN GIAOVIEN GV ON I.HOCVI = GV.HOCVI 
                        AND I.HOCHAM = GV.HOCHAM 
                        AND I.HESO = GV.HESO
        WHERE I.MUCLUONG <> GV.MUCLUONG
    )
    BEGIN
        RAISERROR('Lỗi: Mức lương không nhất quán với học vị, học hàm và hệ số.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

-- 20. Học viên chỉ được thi lại (lần thi > 1) khi điểm của lần thi trước đó dưới 5. 
CREATE TRIGGER TRG_KETQUATHI_THILAI
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM INSERTED I
        JOIN KETQUATHI KQ_TRUOC ON I.MAHV = KQ_TRUOC.MAHV 
                                AND I.MAMH = KQ_TRUOC.MAMH 
                                AND KQ_TRUOC.LANTHI = I.LANTHI - 1
        WHERE I.LANTHI > 1 AND KQ_TRUOC.DIEM >= 5
    )
    BEGIN
        RAISERROR('Lỗi: Chỉ được thi lại khi lần thi trước dưới 5 điểm.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

-- 21. Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước (cùng học viên, cùng môn học). 
CREATE TRIGGER TRG_KETQUATHI_NGAYTHI_LANSAU
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM INSERTED I
        JOIN KETQUATHI KQ_TRUOC ON I.MAHV = KQ_TRUOC.MAHV 
                                AND I.MAMH = KQ_TRUOC.MAMH 
                                AND KQ_TRUOC.LANTHI = I.LANTHI - 1
        WHERE I.LANTHI > 1 AND I.NGTHI <= KQ_TRUOC.NGTHI
    )
    BEGIN
        RAISERROR('Lỗi: Ngày thi lần sau phải lớn hơn ngày thi lần trước.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

-- 22. Học viên chỉ được thi những môn mà lớp của học viên đó đã học xong.
CREATE TRIGGER TRG_KETQUATHI_NGAYTHI_HOCXONG1
ON KETQUATHI
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM INSERTED I
        JOIN HOCVIEN HV ON I.MAHV = HV.MAHV
        JOIN GIANGDAY GD ON GD.MALOP = HV.MALOP AND GD.MAMH = I.MAMH
        WHERE I.NGTHI < GD.DENNGAY
    )
    BEGIN
        RAISERROR('Lỗi: Học viên chỉ được thi khi lớp đã học xong môn học.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO
-- 23. Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước sau giữa các môn học (sau khi học xong những môn học phải học trước mới được học những môn liền sau). 
CREATE TRIGGER TRG_GIANGDAY_MONHOCTRUOC
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM INSERTED I
        JOIN DIEUKIEN DK ON I.MAMH = DK.MAMH
        -- Tìm xem lớp đã học môn trước chưa
        LEFT JOIN GIANGDAY GD_TRUOC ON I.MALOP = GD_TRUOC.MALOP 
                                    AND DK.MAMH_TRUOC = GD_TRUOC.MAMH
        WHERE GD_TRUOC.MAMH IS NULL OR GD_TRUOC.DENNGAY > I.TUNGAY
    )
    BEGIN
        RAISERROR('Lỗi: Lớp chưa học xong môn tiên quyết.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

-- 24. Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách.
CREATE TRIGGER TRG_GIANGDAY_GIAOVIEN_KHOA
ON GIANGDAY
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT * FROM INSERTED I
        JOIN MONHOC MH ON I.MAMH = MH.MAMH
        JOIN GIAOVIEN GV ON I.MAGV = GV.MAGV
        WHERE MH.MAKHOA <> GV.MAKHOA
    )
    BEGIN
        RAISERROR('Lỗi: Giáo viên chỉ được dạy môn thuộc khoa mình phụ trách.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END
GO

-- II. Ngôn ngữ thao tác dữ liệu (Data Manipulation Language)
-- 0. Nhập dữ liệu cho các quan hệ trên.

INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP) 
VALUES 
('KHMT', 'Khoa hoc may tinh', '7/6/2005'),
('HTTT', 'He thong thong tin', '7/6/2005'),
('CNPM', 'Cong nghe phan mem', '7/6/2005'),
('MTT',  'Mang va truyen thong', '20/10/2005'),
('KTMT', 'Ky thuat may tinh', '20/12/2005')

INSERT INTO GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGSINH, NGVL, HESO, MUCLUONG, MAKHOA) 
VALUES
('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '2/5/1950', '11/1/2004', 5.00, 2250000, 'KHMT'),
('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '17/12/1965', '20/4/2004', 4.50, 2025000, 'HTTT'),
('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '1/8/1950', '23/9/2004', 4.00, 1800000, 'CNPM'),
('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '22/2/1961', '12/1/2005', 4.50, 2025000, 'KTMT'),
('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '12/3/1958', '12/1/2005', 3.00, 1350000, 'HTTT'),
('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '11/3/1953', '12/1/2005', 4.50, 2025000, 'KHMT'),
('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '23/11/1971', '1/3/2005', 4.00, 1800000, 'KHMT'),
('GV08', 'Le Thi Tran', 'KS', NULL, 'Nu', '26/3/1974', '1/3/2005', 1.69, 760500, 'KHMT'),
('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '31/12/1966', '1/3/2005', 4.00, 1800000, 'HTTT'),
('GV10', 'Le Tran Anh Loan', 'KS', NULL, 'Nu', '17/7/1972', '1/3/2005', 1.86, 837000, 'CNPM'),
('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '12/1/1980', '15/5/2005', 2.67, 1201500, 'MTT'),
('GV12', 'Tran Van Anh', 'CN', NULL, 'Nu', '29/3/1981', '15/5/2005', 1.69, 760500, 'CNPM'),
('GV13', 'Nguyen Linh Dan', 'CN', NULL, 'Nu', '23/5/1980', '15/5/2005', 1.69, 760500, 'KTMT'),
('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '30/11/1976', '15/5/2005', 3.00, 1350000, 'MTT'),
('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '4/5/1978', '15/5/2005', 3.00, 1350000, 'KHMT')

UPDATE KHOA 
SET TRGKHOA = 'GV01' 
WHERE MAKHOA = 'KHMT'

UPDATE KHOA 
SET TRGKHOA = 'GV02' 
WHERE MAKHOA = 'HTTT'

UPDATE KHOA 
SET TRGKHOA = 'GV04' 
WHERE MAKHOA = 'CNPM'

UPDATE KHOA 
SET TRGKHOA = 'GV03' 
WHERE MAKHOA = 'MTT'

INSERT INTO LOP (MALOP, TENLOP, SISO, MAGVCN) 
VALUES
('K11', 'Lop 1 khoa 1', 11, 'GV07'),
('K12', 'Lop 2 khoa 1', 12, 'GV09'),
('K13', 'Lop 3 khoa 1', 12, 'GV14')

INSERT INTO HOCVIEN (MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALOP) 
VALUES
('K1101', 'Nguyen Van', 'A', '27/1/1986', 'Nam', 'TpHCM', 'K11'),
('K1102', 'Tran Ngoc', 'Han', '14/3/1986', 'Nu', 'Kien Giang', 'K11'),
('K1103', 'Ha Duy', 'Lap', '18/4/1986', 'Nam', 'Nghe An', 'K11'),
('K1104', 'Tran Ngoc', 'Linh', '30/3/1986', 'Nu', 'Tay Ninh', 'K11'),
('K1105', 'Tran Minh', 'Long', '27/2/1986', 'Nam', 'TpHCM', 'K11'),
('K1106', 'Le Nhat', 'Minh', '24/1/1986', 'Nam', 'TpHCM', 'K11'),
('K1107', 'Nguyen Nhu', 'Nhut', '27/1/1986', 'Nam', 'Ha Noi', 'K11'),
('K1108', 'Nguyen Manh', 'Tam', '27/2/1986', 'Nam', 'Kien Giang', 'K11'),
('K1109', 'Phan Thi Thanh', 'Tam', '27/1/1986', 'Nu', 'Vinh Long', 'K11'),
('K1110', 'Le Hoai', 'Thuong', '5/2/1986', 'Nu', 'Can Tho', 'K11'),
('K1111', 'Le Ha', 'Vinh', '25/12/1986', 'Nam', 'Vinh Long', 'K11'),
('K1201', 'Nguyen Van', 'B', '11/2/1986', 'Nam', 'TpHCM', 'K12'),
('K1202', 'Nguyen Thi Kim', 'Duyen', '18/1/1986', 'Nu', 'TpHCM', 'K12'),
('K1203', 'Tran Thi Kim', 'Duyen', '17/9/1986', 'Nu', 'TpHCM', 'K12'),
('K1204', 'Truong My', 'Hanh', '19/5/1986', 'Nu', 'Dong Nai', 'K12'),
('K1205', 'Nguyen Thanh', 'Nam', '17/4/1986', 'Nam', 'TpHCM', 'K12'),
('K1206', 'Nguyen Thi Truc', 'Thanh', '4/3/1986', 'Nu', 'Kien Giang', 'K12'),
('K1207', 'Tran Thi Bich', 'Thuy', '8/2/1986', 'Nu', 'Nghe An', 'K12'),
('K1208', 'Huynh Thi Kim', 'Trieu', '8/4/1986', 'Nu', 'Tay Ninh', 'K12'),
('K1209', 'Pham Thanh', 'Trieu', '23/2/1986', 'Nam', 'TpHCM', 'K12'),
('K1210', 'Ngo Thanh', 'Tuan', '14/2/1986', 'Nam', 'TpHCM', 'K12'),
('K1211', 'Do Thi', 'Xuan', '9/3/1986', 'Nu', 'Ha Noi', 'K12'),
('K1212', 'Le Thi Phi', 'Yen', '12/3/1986', 'Nu', 'TpHCM', 'K12'),
('K1301', 'Nguyen Thi Kim', 'Cuc', '9/6/1986', 'Nu', 'Kien Giang', 'K13'),
('K1302', 'Truong Thi My', 'Hien', '18/3/1986', 'Nu', 'Nghe An', 'K13'),
('K1303', 'Le Duc', 'Hien', '21/3/1986', 'Nam', 'Tay Ninh', 'K13'),
('K1304', 'Le Quang', 'Hien', '18/4/1986', 'Nam', 'TpHCM', 'K13'),
('K1305', 'Le Thi', 'Huong', '27/3/1986', 'Nu', 'TpHCM', 'K13'),
('K1306', 'Nguyen Thai', 'Huu', '30/3/1986', 'Nam', 'Ha Noi', 'K13'),
('K1307', 'Tran Minh', 'Man', '28/5/1986', 'Nam', 'TpHCM', 'K13'),
('K1308', 'Nguyen Hieu', 'Nghia', '8/4/1986', 'Nam', 'Kien Giang', 'K13'),
('K1309', 'Nguyen Trung', 'Nghia', '18/1/1987', 'Nam', 'Nghe An', 'K13'),
('K1310', 'Tran Thi Hong', 'Tham', '22/4/1986', 'Nu', 'Tay Ninh', 'K13'),
('K1311', 'Tran Minh', 'Thuc', '4/4/1986', 'Nam', 'TpHCM', 'K13'),
('K1312', 'Nguyen Thi Kim', 'Yen', '7/9/1986', 'Nu', 'TpHCM', 'K13')

UPDATE LOP 
SET TRGLOP = 'K1108'
WHERE MALOP = 'K11'

UPDATE LOP 
SET TRGLOP = 'K1205'
WHERE MALOP = 'K12'

UPDATE LOP 
SET TRGLOP = 'K1305'
WHERE MALOP = 'K13'

INSERT INTO MONHOC (MAMH, TENMH, TCLT, TCTH, MAKHOA) 
VALUES
('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT'),
('CTRR', 'Cau truc roi rac', 5, 2, 'KHMT'),
('CSDL', 'Co so du lieu', 3, 1, 'HTTT'),
('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT'),
('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT'),
('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT'),
('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT'),
('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT'),
('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT'),
('HDH', 'He dieu hanh', 4, 1, 'KTMT'),
('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM'),
('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM'),
('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM')

INSERT INTO DIEUKIEN (MAMH, MAMH_TRUOC) 
VALUES
('CSDL', 'CTRR'),
('CSDL', 'CTDLGT'),
('CTDLGT', 'THDC'),
('PTTKTT', 'THDC'),
('PTTKTT', 'CTDLGT'),
('DHMT', 'THDC'),
('LTHDT', 'THDC'),
('PTTKHTTT', 'CSDL')

INSERT INTO GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAM, TUNGAY, DENNGAY) 
VALUES
('K11', 'THDC', 'GV07', 1, 2006, '2/1/2006', '12/5/2006'),
('K12', 'THDC', 'GV06', 1, 2006, '2/1/2006', '12/5/2006'),
('K13', 'THDC', 'GV15', 1, 2006, '2/1/2006', '12/5/2006'),
('K11', 'CTRR', 'GV02', 1, 2006, '9/1/2006', '17/5/2006'),
('K12', 'CTRR', 'GV02', 1, 2006, '9/1/2006', '17/5/2006'),
('K13', 'CTRR', 'GV08', 1, 2006, '9/1/2006', '17/5/2006'),
('K11', 'CSDL', 'GV05', 2, 2006, '1/6/2006', '15/7/2006'),
('K12', 'CSDL', 'GV09', 2, 2006, '1/6/2006', '15/7/2006'),
('K13', 'CTDLGT', 'GV15', 2, 2006, '1/6/2006', '15/7/2006'),
('K13', 'CSDL', 'GV05', 3, 2006, '1/8/2006', '15/12/2006'),
('K13', 'DHMT', 'GV07', 3, 2006, '1/8/2006', '15/12/2006'),
('K11', 'CTDLGT', 'GV15', 3, 2006, '1/8/2006', '15/12/2006'),
('K12', 'CTDLGT', 'GV15', 3, 2006, '1/8/2006', '15/12/2006'),
('K11', 'HDH', 'GV04', 1, 2007, '2/1/2007', '18/2/2007'),
('K12', 'HDH', 'GV04', 1, 2007, '2/1/2007', '20/3/2007'),
('K11', 'DHMT', 'GV07', 1, 2007, '18/2/2007', '20/3/2007')

INSERT INTO KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA) 
VALUES
('K1101','CSDL',1,'20/7/2006',10.00, 'Dat'),
('K1101','CTDLGT',1,'28/12/2006',9.00, 'Dat'),
('K1101','THDC',1,'20/5/2006',9.00, 'Dat'),
('K1101','CTRR',1,'13/5/2006',9.50, 'Dat'),
('K1102','CSDL',1,'20/7/2006',4.00, 'Khong Dat'),
('K1102','CSDL',2,'27/7/2006',4.25, 'Khong Dat'),
('K1102','CSDL',3,'10/8/2006',4.50, 'Khong Dat'),
('K1102','CTDLGT',1,'28/12/2006',4.50, 'Khong Dat'),
('K1102','CTDLGT',2,'5/1/2007',4.00, 'Khong Dat'),
('K1102','CTDLGT',3,'15/1/2007',6.00, 'Dat'),
('K1102','THDC',1,'20/5/2006',5.00, 'Dat'),
('K1102','CTRR',1,'13/5/2006',7.00, 'Dat'),
('K1103','CSDL',1,'20/7/2006',3.50, 'Khong Dat'),
('K1103','CSDL',2,'27/7/2006',8.25, 'Dat'),
('K1103','CTDLGT',1,'28/12/2006',7.00, 'Dat'),
('K1103','THDC',1,'20/5/2006',8.00, 'Dat'),
('K1103','CTRR',1,'13/5/2006',6.50, 'Dat'),
('K1104','CSDL',1,'20/7/2006',3.75, 'Khong Dat'),
('K1104','CTDLGT',1,'28/12/2006',4.00, 'Khong Dat'),
('K1104','THDC',1,'20/5/2006',4.00, 'Khong Dat'),
('K1104','CTRR',1,'13/5/2006',4.00, 'Khong Dat'),
('K1104','CTRR',2,'20/5/2006',3.50, 'Khong Dat'),
('K1104','CTRR',3,'30/6/2006',4.00, 'Khong Dat'),
('K1201','CSDL',1,'20/7/2006',6.00, 'Dat'),
('K1201','CTDLGT',1,'28/12/2006',5.00, 'Dat'),
('K1201','THDC',1,'20/5/2006',8.50, 'Dat'),
('K1201','CTRR',1,'13/5/2006',9.00, 'Dat'),
('K1202','CSDL',1,'20/7/2006',8.00, 'Dat'),
('K1202','CTDLGT',1,'28/12/2006',4.00, 'Khong Dat'),
('K1202','CTDLGT',2,'5/1/2007',5.00, 'Dat'),
('K1202','THDC',1,'20/5/2006',4.00, 'Khong Dat'),
('K1202','THDC',2,'27/5/2006',4.00, 'Khong Dat'),
('K1202','CTRR',1,'13/5/2006',3.00, 'Khong Dat'),
('K1202','CTRR',2,'20/5/2006',4.00, 'Khong Dat'),
('K1202','CTRR',3,'30/6/2006',6.25, 'Dat'),
('K1203','CSDL',1,'20/7/2006',9.25, 'Dat'),
('K1203','CTDLGT',1,'28/12/2006',9.50, 'Dat'),
('K1203','THDC',1,'20/5/2006',10.00, 'Dat'),
('K1203','CTRR',1,'13/5/2006',10.00, 'Dat'),
('K1204','CSDL',1,'20/7/2006',8.50, 'Dat'),
('K1204','CTDLGT',1,'28/12/2006',6.75, 'Dat'),
('K1204','THDC',1,'20/5/2006',4.00, 'Khong Dat'),
('K1204','CTRR',1,'13/5/2006',6.00, 'Dat'),
('K1301','CSDL',1,'20/12/2006',4.25, 'Khong Dat'),
('K1301','CTDLGT',1,'25/7/2006',8.00, 'Dat'),
('K1301','THDC',1,'20/5/2006',7.75, 'Dat'),
('K1301','CTRR',1,'13/5/2006',8.00, 'Dat'),
('K1302','CSDL',1,'20/12/2006',6.75, 'Dat'),
('K1302','CTDLGT',1,'25/7/2006',5.00, 'Dat'),
('K1302','THDC',1,'20/5/2006',8.00, 'Dat'),
('K1302','CTRR',1,'13/5/2006',8.50, 'Dat'),
('K1303','CSDL',1,'20/12/2006',4.00, 'Khong Dat'),
('K1303','CTDLGT',1,'25/7/2006',4.50, 'Khong Dat'),
('K1303','CTDLGT',2,'7/8/2006',4.00, 'Khong Dat'),
('K1303','CTDLGT',3,'15/8/2006',4.25, 'Khong Dat'),
('K1303','THDC',1,'20/5/2006',4.50, 'Khong Dat'),
('K1303','CTRR',1,'13/5/2006',3.25, 'Khong Dat'),
('K1303','CTRR',2,'20/5/2006',5.00, 'Dat'),
('K1304','CSDL',1,'20/12/2006',7.75, 'Dat'),
('K1304','CTDLGT',1,'25/7/2006',9.75, 'Dat'),
('K1304','THDC',1,'20/5/2006',5.50, 'Dat'),
('K1304','CTRR',1,'13/5/2006',5.00, 'Dat'),
('K1305','CSDL',1,'20/12/2006',9.25, 'Dat'),
('K1305','CTDLGT',1,'25/7/2006',10.00, 'Dat'),
('K1305','THDC',1,'20/5/2006',8.00, 'Dat'),
('K1305','CTRR',1,'13/5/2006',10.00, 'Dat')

-- 1. Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa.
UPDATE GIAOVIEN
SET HESO = HESO + 0.2
WHERE MAGV IN ( SELECT TRGKHOA
                FROM KHOA
                WHERE TRGKHOA IS NOT NULL )

-- 2. Cập nhật giá trị điểm trung bình tất cả các môn học  (DIEMTB) của mỗi học viên 
-- (tất cả các môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng).
UPDATE HOCVIEN
SET DIEMTB = (
    SELECT AVG(KQ.DIEM)
    FROM KETQUATHI KQ
    WHERE KQ.MAHV = HOCVIEN.MAHV
      AND KQ.LANTHI = (
          SELECT MAX(LANTHI)
          FROM KETQUATHI
          WHERE MAHV = HOCVIEN.MAHV
            AND MAMH = KQ.MAMH
      )
)

-- 3. Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất kỳ thi 
-- lần thứ 3 dưới 5 điểm.
UPDATE HOCVIEN
SET GHICHU = 'Cam thi'
WHERE EXISTS ( SELECT 1
               FROM KETQUATHI K
               WHERE K.MAHV = HOCVIEN.MAHV
                 AND K.LANTHI >= 3
                 AND K.DIEM < 5 )

-- 4. Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN như sau: 
--      o Nếu DIEMTB >= 9 thì XEPLOAI =”XS” 
--      o Nếu 8 <= DIEMTB < 9 thì XEPLOAI = “G” 
--      o Nếu 6.5 <= DIEMTB < 8 thì XEPLOAI = “K” 
--      o Nếu 5 <= DIEMTB < 6.5 thì XEPLOAI = “TB” 
--      o Nếu DIEMTB < 5 thì XEPLOAI = ”Y”
UPDATE HOCVIEN
SET XEPLOAI = 
    CASE 
        WHEN DIEMTB >= 9 THEN 'XS'
        WHEN DIEMTB >= 8 THEN 'G'
        WHEN DIEMTB >= 6.5 THEN 'K'
        WHEN DIEMTB >= 5 THEN 'TB'
        ELSE 'Y'
    END

-- III. Ngôn ngữ truy vấn dữ liệu
-- 1. In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp.
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN, HV.NGSINH, L.MALOP
FROM HOCVIEN HV
JOIN LOP L ON HV.MAHV = L.TRGLOP

-- 2. In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên.
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN, KQ.LANTHI, KQ.DIEM
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE HV.MALOP = 'K12' AND KQ.MAMH = 'CTRR'
ORDER BY HV.TEN, HV.HO

-- 3. In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt.
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN, MH.TENMH
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
JOIN MONHOC MH ON KQ.MAMH = MH.MAMH
WHERE KQ.LANTHI = 1 AND KQ.KQUA = 'Dat'

-- 4. In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1).
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE HV.MALOP = 'K11' 
  AND KQ.MAMH = 'CTRR' 
  AND KQ.LANTHI = 1 
  AND KQ.KQUA = 'Khong Dat'

-- 5. Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi).
SELECT DISTINCT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE HV.MALOP LIKE 'K%' 
  AND KQ.MAMH = 'CTRR'
  AND NOT EXISTS ( SELECT 1 
                   FROM KETQUATHI KQ2 
                   WHERE KQ2.MAHV = KQ.MAHV 
                   AND KQ2.MAMH = 'CTRR' 
                   AND KQ2.KQUA = 'Dat' )

-- 6. Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006.
SELECT DISTINCT MH.TENMH
FROM MONHOC MH
JOIN GIANGDAY GD ON MH.MAMH = GD.MAMH
JOIN GIAOVIEN GV ON GD.MAGV = GV.MAGV
WHERE GV.HOTEN = 'Tran Tam Thanh' 
  AND GD.HOCKY = 1 
  AND GD.NAM = 2006

-- 7. Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006.
SELECT DISTINCT MH.MAMH, MH.TENMH
FROM MONHOC MH
JOIN GIANGDAY GD ON MH.MAMH = GD.MAMH
WHERE GD.MAGV = (SELECT MAGVCN FROM LOP WHERE MALOP = 'K11')
  AND GD.HOCKY = 1 
  AND GD.NAM = 2006

-- 8. Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”.
SELECT HV.HO + ' ' + HV.TEN AS HOTEN_LOPTRUONG
FROM HOCVIEN HV
JOIN LOP L ON HV.MAHV = L.TRGLOP
JOIN GIANGDAY GD ON L.MALOP = GD.MALOP
JOIN GIAOVIEN GV ON GD.MAGV = GV.MAGV
JOIN MONHOC MH ON GD.MAMH = MH.MAMH
WHERE GV.HOTEN = 'Nguyen To Lan' AND MH.TENMH = 'Co so du lieu'

-- 9. In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”.
SELECT MH.MAMH, MH.TENMH
FROM MONHOC MH
JOIN DIEUKIEN DK ON MH.MAMH = DK.MAMH_TRUOC
JOIN MONHOC MH_SAU ON DK.MAMH = MH_SAU.MAMH
WHERE MH_SAU.TENMH = 'Co So Du Lieu'

-- 10. Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào.
SELECT MH.MAMH, MH.TENMH
FROM MONHOC MH
JOIN DIEUKIEN DK ON MH.MAMH = DK.MAMH
JOIN MONHOC MH_TRUOC ON DK.MAMH_TRUOC = MH_TRUOC.MAMH
WHERE MH_TRUOC.TENMH = 'Cau truc roi rac'

-- 11. Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006.
SELECT GV.HOTEN
FROM GIAOVIEN GV
JOIN GIANGDAY GD1 ON GV.MAGV = GD1.MAGV
JOIN GIANGDAY GD2 ON GV.MAGV = GD2.MAGV
WHERE GD1.MAMH = 'CTRR' AND GD1.MALOP = 'K11' AND GD1.HOCKY = 1 AND GD1.NAM = 2006
  AND GD2.MAMH = 'CTRR' AND GD2.MALOP = 'K12' AND GD2.HOCKY = 1 AND GD2.NAM = 2006

-- 12. Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này.
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE KQ.MAMH = 'CSDL' 
  AND KQ.LANTHI = 1 
  AND KQ.KQUA = 'Khong Dat'
  AND NOT EXISTS ( SELECT 1 
                   FROM KETQUATHI KQ2 
                   WHERE KQ2.MAHV = KQ.MAHV 
                   AND KQ2.MAMH = 'CSDL' 
                   AND KQ2.LANTHI > 1 )

-- 13. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào.
SELECT MAGV, HOTEN
FROM GIAOVIEN
WHERE MAGV NOT IN ( SELECT DISTINCT MAGV
                    FROM GIANGDAY )

-- 14. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách.
SELECT GV.MAGV, GV.HOTEN
FROM GIAOVIEN GV
WHERE NOT EXISTS ( SELECT 1 
                   FROM GIANGDAY GD
                   JOIN MONHOC MH ON GD.MAMH = MH.MAMH
                   WHERE GD.MAGV = GV.MAGV AND MH.MAKHOA = GV.MAKHOA )

-- 15. Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm.
SELECT DISTINCT HV.HO + ' ' + HV.TEN AS HOTEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE HV.MALOP = 'K11'
  AND (
      (KQ.LANTHI > 3 AND KQ.KQUA = 'Khong Dat')
      OR 
      (KQ.MAMH = 'CTRR' AND KQ.LANTHI = 2 AND KQ.DIEM = 5)
      )

-- 16. Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học.
SELECT GV.HOTEN
FROM GIAOVIEN GV
JOIN GIANGDAY GD ON GV.MAGV = GD.MAGV
WHERE GD.MAMH = 'CTRR'
GROUP BY GV.HOTEN, GD.HOCKY, GD.NAM
HAVING COUNT(GD.MALOP) >= 2

-- 17. Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN, KQ.DIEM
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE KQ.MAMH = 'CSDL'
  AND KQ.LANTHI = ( SELECT MAX(LANTHI) 
                    FROM KETQUATHI KQ2 
                    WHERE KQ2.MAHV = KQ.MAHV AND KQ2.MAMH = 'CSDL' )

-- 18. Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN, MAX(KQ.DIEM) AS DIEM_CAO_NHAT
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
JOIN MONHOC MH ON KQ.MAMH = MH.MAMH
WHERE MH.TENMH = 'Co so du lieu'
GROUP BY HV.MAHV, HV.HO, HV.TEN

-- 19. Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
SELECT TOP 1 WITH TIES MAKHOA, TENKHOA
FROM KHOA
ORDER BY NGTLAP ASC

-- 20. Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
SELECT COUNT(*) AS SO_LUONG
FROM GIAOVIEN
WHERE HOCHAM IN ('GS', 'PGS')

-- 21. Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa.
SELECT MAKHOA, HOCVI, COUNT(*) AS SO_LUONG
FROM GIAOVIEN
GROUP BY MAKHOA, HOCVI
ORDER BY MAKHOA

-- 22. Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
SELECT MAMH, KQUA, COUNT(*) AS SO_LUONG
FROM KETQUATHI
GROUP BY MAMH, KQUA
ORDER BY MAMH

-- 23. Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học.
SELECT DISTINCT GV.MAGV, GV.HOTEN
FROM GIAOVIEN GV
JOIN LOP L ON GV.MAGV = L.MAGVCN
JOIN GIANGDAY GD ON GV.MAGV = GD.MAGV AND L.MALOP = GD.MALOP

-- 24. Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
SELECT TOP 1 WITH TIES HV.HO + ' ' + HV.TEN AS HOTEN_LOPTRUONG
FROM LOP L
JOIN HOCVIEN HV ON L.TRGLOP = HV.MAHV
ORDER BY L.SISO DESC

-- 25. Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi).
SELECT HV.HO + ' ' + HV.TEN AS HOTEN
FROM HOCVIEN HV
JOIN LOP L ON HV.MAHV = L.TRGLOP
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE KQ.KQUA = 'Khong Dat' 
  AND NOT EXISTS ( SELECT 1 FROM KETQUATHI KQ2 
                   WHERE KQ2.MAHV = KQ.MAHV 
                     AND KQ2.MAMH = KQ.MAMH 
                     AND KQ2.KQUA = 'Dat' )
GROUP BY HV.MAHV, HV.HO, HV.TEN
HAVING COUNT(DISTINCT KQ.MAMH) > 3

-- 26. Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT TOP 1 WITH TIES HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE KQ.DIEM BETWEEN 9 AND 10
GROUP BY HV.MAHV, HV.HO, HV.TEN
ORDER BY COUNT(DISTINCT KQ.MAMH) DESC

-- 27. Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT HV.MALOP, HV.HO + ' ' + HV.TEN AS HOTEN
FROM KETQUATHI KQT, HOCVIEN HV
WHERE HV.MAHV = KQT.MAHV 
  AND ( DIEM =9  OR DIEM = 10 ) 
GROUP BY HV.MALOP, HV.HO, HV.TEN
HAVING COUNT(MAMH) >= ALL( SELECT COUNT(MAMH)
                         FROM KETQUATHI KQT, HOCVIEN HV2
	                     WHERE KQT.MAHV = HV2.MAHV AND HV.MALOP = HV2.MALOP AND (DIEM=9 OR DIEM=10)
	                     GROUP BY HV2.MAHV )

-- 28. Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp.
SELECT MAGV, NAM, HOCKY, 
       COUNT(DISTINCT MAMH) AS SO_MON, 
       COUNT(DISTINCT MALOP) AS SO_LOP
FROM GIANGDAY
GROUP BY MAGV, NAM, HOCKY

-- 29. Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất.
SELECT NAM, HOCKY, GV.MAGV, HOTEN, COUNT(MALOP) AS SL_LOP
FROM GIANGDAY GD, GIAOVIEN GV
WHERE GD.MAGV = GV.MAGV
GROUP BY HOCKY, NAM, GV.MAGV, HOTEN
HAVING COUNT(MALOP) >= ALL( SELECT COUNT(MALOP)
	                        FROM GIANGDAY GD2
	                        WHERE GD2.HOCKY = GD.HOCKY AND GD2.NAM = GD2.NAM
	                        GROUP BY GD2.MAGV )


-- 30. Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
SELECT TOP 1 WITH TIES MH.MAMH, MH.TENMH
FROM MONHOC MH
JOIN KETQUATHI KQ ON MH.MAMH = KQ.MAMH
WHERE KQ.LANTHI = 1 AND KQ.KQUA = 'Khong Dat'
GROUP BY MH.MAMH, MH.TENMH
ORDER BY COUNT(*) DESC

-- 31. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE KQ.LANTHI = 1 AND KQ.KQUA = 'Dat'
GROUP BY HV.MAHV, HV.HO, HV.TEN
HAVING COUNT(DISTINCT KQ.MAMH) = ( SELECT COUNT(*) 
                                   FROM MONHOC )

-- 32. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
SELECT DISTINCT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
FROM KETQUATHI KQT, HOCVIEN HV
WHERE KQT.MAHV = HV.MAHV 
  AND HV.MAHV NOT IN ( SELECT MAHV
			           FROM KETQUATHI KQT2
			           WHERE KQUA = 'Khong Dat' 
                         AND LANTHI = ( SELECT MAX(LANTHI)
                                        FROM KETQUATHI KQT3
				                        WHERE KQT2.MAHV = KQT3.MAHV )
		             )

-- 33. Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi thứ 1).
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN
FROM HOCVIEN HV
JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE KQ.LANTHI = 1 AND KQ.KQUA = 'Dat'
GROUP BY HV.MAHV, HV.HO, HV.TEN
HAVING COUNT(DISTINCT KQ.MAMH) = ( SELECT COUNT(*) 
                                   FROM MONHOC )

-- 34. Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt  (chỉ xét lần thi sau cùng).
SELECT HV.MAHV, HV.HO + ' ' + HV.TEN AS HOTEN 
FROM HOCVIEN AS HV 
WHERE NOT EXISTS ( SELECT * 
                   FROM MONHOC AS MH 
                   WHERE NOT EXISTS ( SELECT * 
                                      FROM KETQUATHI AS KQ 
                                      WHERE KQ.MAHV = HV.MAHV 
                                        AND MH.MAMH = KQ.MAMH
                                        AND LANTHI = ( SELECT MAX(LANTHI) 
                                                       FROM KETQUATHI 
                                                       WHERE MAHV = HV.MAHV 
                                                         AND MAMH = MH.MAMH )
	                                )
                 )

-- 35. Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng).
SELECT MH.TENMH, HV.HO + ' ' + HV.TEN AS HOTEN, KQ.DIEM
FROM KETQUATHI KQ
JOIN HOCVIEN HV ON KQ.MAHV = HV.MAHV
JOIN MONHOC MH ON KQ.MAMH = MH.MAMH
WHERE KQ.LANTHI = ( SELECT MAX(LANTHI) 
                    FROM KETQUATHI 
                    WHERE MAHV = KQ.MAHV 
                      AND MAMH = KQ.MAMH )
  AND KQ.DIEM = ( SELECT MAX(KQ2.DIEM)
                  FROM KETQUATHI KQ2
                  WHERE KQ2.MAMH = KQ.MAMH 
                    AND KQ2.LANTHI = ( SELECT MAX(LANTHI) 
                                       FROM KETQUATHI 
                                       WHERE MAHV = KQ2.MAHV 
                                         AND MAMH = KQ2.MAMH ) 
                )