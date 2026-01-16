-----------------------------------------
---------------- ĐỀ 101 -----------------
-----------------------------------------
--- 3.1. Liệt kê thông tin các phòng trọ (mã, tên phòng) cùng với thông tin cư dân (mã, họ tên) đã ký hợp đồng thuê các phòng có giá thuê trên 5 triệu VNĐ trong năm 2024.
SELECT PT.MAPT, HOTEN, CD.MACD, TENCD
FROM CUDAN CD, HOPDONG HD, PHONGTRO PT
WHERE CD.MACD = HD.MACD AND HD.MAPT = PT.MAPT
AND GIA > 5000000 AND YEAR(NGAYKY) = 2024

--- 3.2. Liệt kê các dịch vụ (mã, tên dịch vụ) đã được thanh toán trong các phiếu tính tiền của cả hai tháng 11 và tháng 12 năm 2024 cho hợp đồng có mã ‘HD002’.
SELECT DV.MADV, TENDV
FROM PHIEUTINHTIEN PTT, CHITIETTTDV CT, DICHVU DV
WHERE PTT.MaPTT = CT.MaPTT AND CT.MaDV = DV.MaDV
AND MAHD = 'HD002' AND TINHTRANGTT =  'Da thanh toan'
AND MONTH(NGAYTINHTIEN) = 11 AND YEAR(NGAYTINHTIEN) = 2024
INTERSECT
SELECT DV.MADV, TENDV
FROM PHIEUTINHTIEN PTT, CHITIETTTDV CT, DICHVU DV
WHERE PTT.MaPTT = CT.MaPTT AND CT.MaDV = DV.MaDV
AND MAHD = 'HD002' AND TINHTRANGTT =  'Da thanh toan'
AND MONTH(NGAYTINHTIEN) = 11 AND YEAR(NGAYTINHTIEN) = 2024

--- 3.3. Tìm thông tin các phiếu tính tiền (mã phiếu tính tiền, mã hợp đồng) trong năm 2024 và sử dụng tất cả các dịch vụ có đơn giá từ 150.000 VNĐ trở xuống.
SELECT MAPTT, MAHD
FROM PHIEUTINHTIEN PTT
WHERE YEAR(NGAYTINHTIEN) = 2024
AND NOT EXISTS 	(SELECT * 
                 FROM DICHVU DV 
                 WHERE DONGIA <= 150000
                 AND NOT EXISTS (SELECT *
                                 FROM CHITIETTTDV CT
                                 WHERE CT.MAPTT=PTT.MAPTT
                                 AND CT.MADV = DV.MADV))

--- 3.4. Với mỗi hợp đồng, hãy cho biết số lượng phiếu tính tiền đã được thanh toán bằng phương thức ‘Chuyển khoản’ trong năm 2024. Thông tin hiển thị: mã hợp đồng, mã cư dân, số lượng
SELECT HD.MAHD, MACD, COUNT(MAPTT) 
FROM HOPDONG HD, PHIEUTINHTIEN PTT
WHERE HD.MAHD = PTT.MAHD 
AND TINHTRANGTT = 'Da thanh toan' AND PHUONGTHUCTT = 'Chuyen khoan'
AND YEAR(NGAYTINHTIEN) = 2024
GROUP BY HD.MAHD, MACD

--- 3.5. Trong các cư dân có số lần ký hợp đồng nhiều nhất, tìm cư dân (mã, họ tên) có tổng số tiền đã thanh toán trong năm 2024 nhiều hơn 15,000,000 VNĐ.
SELECT CD.MACD, HOTEN, SUM(TONGTIENTT) 
FROM CUDAN CD, HOPDONG HD, PHIEUTINHTIEN PTT
WHERE HD.MACD = CD.MACD AND HD.MAHD = PTT.MAHD
AND YEAR(NGAYTINHTIEN) = 2024 AND TINHTRANGTT = 'Da thanh toan'
AND CD.MACD IN (SELECT TOP 1 WITH TIES MACD
                FROM HOPDONG HD
                GROUP BY MACD
                ORDER BY COUNT(MAHD) DESC)
GROUP BY CD.MACD, HOTEN
HAVING SUM(TONGTIENTT) >=15000000


-----------------------------------------
---------------- ĐỀ 102 -----------------
-----------------------------------------
--- 3.1. Liệt kê thông tin các cư dân (mã, họ tên) cùng thông tin phòng trọ (mã, tên phòng) mà cư dân đó đã ký hợp đồng với trạng thái hợp đồng ‘Đã hết hạn’ trong năm 2024.
SELECT CD.MACD, HOTEN, PT.MAPT, TENPT
FROM CUDAN CD, HOPDONG HD, PHONGTRO PT
WHERE CD.MACD = HD.MACD AND HD.MAPT = PT.MAPT
AND TrangThaiHD = ‘Da het han’ AND YEAR(NGAYKY) = 2024

--- 3.2. Tìm các hợp đồng (mã hợp đồng, mã phòng trọ) đã thanh toán các phiếu tính tiền trong năm 2024 nhưng không sử dụng dịch vụ nào có chỉ số từ 5 trở lên trong những chi tiết của phiếu tính tiền đó.
SELECT HD.MAHD, MAPT
FROM HOPDONG HD, PHIEUTINHTIEN PTT
WHERE HD.MAHD = PTT.MAHD
AND TINHTRANGTT =  'Da thanh toan' AND YEAR(NGAYTINHTIEN) = 2024
EXCEPT
SELECT HD.MAHD, MAPT
FROM HOPDONG HD, PHIEUTINHTIEN PTT, CHITIETTTDV CT
WHERE HD.MAHD = PTT.MAHD AND PTT.MaPTT = CT.MaPTT 
AND ChiSoDV >=5

--- 3.3. Tìm thông tin các dịch vụ (mã, tên dịch vụ) có đơn giá trên 10,000 VNĐ và có trong chi tiết của tất cả các phiếu tính tiền ngày 15/12/2024.
SELECT MADV, TENDV
FROM DICHVU DV 
WHERE DONGIA >10000 
AND NOT EXISTS (SELECT * 
                FROM PHIEUTINHTIEN PTT
                WHERE NGAYTINHTIEN = '2024-12-15'
                AND NOT EXISTS (SELECT *
                                 FROM CHITIETTTDV CT
                                 WHERE CT.MAPTT=PTT.MAPTT
									AND CT.MADV = DV.MADV))

--- 3.4. Với mỗi hợp đồng đã hết hạn, hãy cho biết số lượng phiếu tính tiền trong năm 2024 đã được thanh toán. Thông tin hiển thị: mã hợp đồng, mã cư dân, số lượng
FROM HOPDONG HD, PHIEUTINHTIEN PTT
WHERE HD.MAHD = PTT.MAHD 
AND TRANGTHAIHD = 'Da het han' AND TINHTRANGTT = 'Da thanh toan' 
AND YEAR(NGAYTINHTIEN) = 2024
GROUP BY HD.MAHD, MACD

--- 3.5. Trong các cư dân có số lần ký hợp đồng ít nhất, tìm cư dân (mã, họ tên) có tổng số tiền đã thanh toán trong năm 2024 nhiều hơn 5,000,000 VNĐ.

SELECT CD.MACD, HOTEN, SUM(TONGTIENTT) 
FROM CUDAN CD, HOPDONG HD, PHIEUTINHTIEN PTT
WHERE HD.MACD = CD.MACD AND HD.MAHD = PTT.MAHD
AND TINHTRANGTT = 'Da thanh toan'
AND YEAR(NGAYTINHTIEN) = 2024
AND CD.MACD IN (SELECT TOP 1 WITH TIES MACD
                FROM HOPDONG HD
                GROUP BY MACD
                ORDER BY COUNT(MAHD) ASC)
GROUP BY CD.MACD, HOTEN
HAVING SUM(TONGTIENTT) > 5000000


-----------------------------------------
---------------- ĐỀ 201 -----------------
-----------------------------------------
--- 3.1. Liệt kê thông tin các phiếu tính tiền (mã phiếu tính tiền, mã hợp đồng) trong năm 2024 cùng với thông tin chi tiết của dịch vụ (chỉ số, thành tiền) đã sử dụng có tên là ‘Điện’.
SELECT PTT.MaPTT, MaHD, ChiSoDV ThanhTien
FROM PHIEUTINHTIEN PTT, CHITIETTTDV CT, DICHVU DV
WHERE PTT.MaPTT = CT.MaPTT AND CT.MaDV = DV.MaDV
AND TenDV = 'Dien' AND YEAR(NGAYTINHTIEN) = 2024

--- 3.2. Tìm các phòng trọ (mã, tên phòng trọ) thuộc loại ‘Không gác xép’ được ký hợp đồng trong năm 2024 nhưng chưa có phiếu tính tiền nào có tổng tiền thanh toán lớn hơn 4 triệu VNĐ và thanh toán bằng phương thức ‘chuyển khoản’.
FROM HOPDONG HD, PHONGTRO PT
WHERE HD.MAPT = PT.MAPT 
AND LOAIPT = 'Khong gac xep' AND YEAR(NGAYKY) = 2024
EXCEPT
SELECT PT.MAPT, TENPT
FROM PHONGTRO PT, HOPDONG HD, PHIEUTINHTIEN PTT
WHERE HD.MAPT = PT.MAPT AND HD.MAHD = PTT.MAHD 
AND PHUONGTHUCTT = 'Chuyen khoan' AND TONGTIENTT > 4000000

--- 3.3. Tìm thông tin cư dân (mã, họ tên) đang ở và đã ký hợp đồng thuê tất cả các phòng trọ thuộc loại ‘Kiot’ và diện tích bằng 40 m2.
SELECT MACD, HOTEN
FROM CUDAN CD
WHERE TRANGTHAICD = 'Dang o'
AND NOT EXISTS (SELECT * 
                  FROM PHONGTRO PT
                  WHERE LOAIPT = 'Kiot' AND DIENTICH = 40
                AND NOT EXISTS (SELECT * 
                                    FROM HOPDONG HD
                                    WHERE HD.MACD = CD.MACD
                               		AND HD.MAPT = PT.MAPT))

--- 3.4. Với mỗi cư dân đã rời đi, hãy thống kê số lượng hợp đồng có ngày ký từ năm 2022 đến năm 2024. Thông tin hiển thị: mã cư dân, họ tên cư dân, số lượng hợp đồng.
SELECT CD.MACD, HOTEN, COUNT(MAHD) 
FROM HOPDONG HD, CUDAN CD
WHERE CD.MACD = HD.MACD
AND TRANGTHAICD = 'Da roi di' 
AND YEAR(NGAYKY) BETWEEN 2022 AND 2024
GROUP BY CD.MACD, HOTEN

--- 3.5. Trong các hợp đồng có số lượng phiếu tính tiền đã thanh toán từ 2 trở lên, tìm mã hợp đồng có tổng chỉ số đã sử dụng của dịch vụ có tên là ‘Điện’ ít nhất.
SELECT TOP 1 WITH TIES MAHD, SUM(CHISODV)
FROM PHIEUTINHTIEN PTT, CHITIETTTDV CT, DICHVU DV
WHERE PTT.MAPTT = CT.MAPTT AND CT.MADV = DV.MADV
AND TENDV = 'Dien'
AND MAHD IN (SELECT MAHD
             FROM PHIEUTINHTIEN PTT
             WHERE TINHTRANGTT = 'Da thanh toan'
             GROUP BY MAHD
             HAVING COUNT(MAPTT) = 2)
GROUP BY MAHD
ORDER BY SUM(CHISODV) ASC


-----------------------------------------
---------------- ĐỀ 202 -----------------
-----------------------------------------
--- 3.1. Liệt kê thông tin các phòng trọ (mã, tên phòng trọ) của các phòng trọ có tình trạng ‘Đã cho thuê’ cùng thông tin phiếu tính tiền (mã phiếu tính tiền, tổng tiền thanh toán) trong năm 2024 của phòng trọ đó.
SELECT PT.MaPT, TenPT, MaPTT, TongTien
FROM PHIEUTINHTIEN PTT, PHONGTRO PT, HOPDONG HD
WHERE PTT.MaHD = HD.MaHD AND HD.MaPT = PT.MaPT
AND TinhTrangPT = 'Da cho thue' AND YEAR(NGAYTINHTIEN) = 2024

--- 3.2. Liệt kê các cư dân (mã, họ tên) đã ký hợp đồng thuê các phòng trọ có diện tích trên 20 m2 thuộc cả hai loại ‘Kiot’ và ‘Có gác xép’ trong năm 2024.
SELECT CD.MACD, HOTEN	
FROM CUDAN CD, HOPDONG HD, PHONGTRO PT
WHERE CD.MACD = HD.MACD AND HD.MAPT = PT.MAPT
AND LOAIPT= 'Kiot'
AND DIENTICH > 20 
AND YEAR(NGAYKY) = 2024
INTERSECT
SELECT CD.MACD, HOTEN
FROM CUDAN CD, HOPDONG HD, PHONGTRO PT
WHERE CD.MACD = HD.MACD AND HD.MAPT = PT.MAPT
AND LOAIPT= 'Co gac xep'
AND DIENTICH > 20 
AND YEAR(NGAYKY) = 2024

--- 3.3. Tìm thông tin các phiếu tính tiền (mã phiếu tính tiền, mã hợp đồng) có tổng tiền thanh toán trên 2,000,000 VNĐ, thanh toán bằng phương thức ‘tiền mặt’ và đã sử dụng tất cả các dịch vụ có đơn giá từ 50,000 trở xuống.
SELECT MAPTT, MAHD
FROM PHIEUTINHTIEN PTT
WHERE TONGTIENTT > 2000000 AND PHUONGTHUCTT= 'Tien mat'
AND NOT EXISTS (SELECT * 
                  FROM DICHVU DV 
                WHERE DONGIA <= 50000
                AND NOT EXISTS (SELECT *
                                 FROM CHITIETTTDV CT
                                 WHERE CT.MAPTT= PTT.MAPTT
                                 AND CT.MADV = DV.MADV))

--- 3.4. Với mỗi cư dân đang ở, hãy thống kê số lượng hợp đồng có trạng thái hợp đồng ‘Đã hết hạn’ và có ngày hết hạn trong năm 2024. Thông tin hiển thị: mã cư dân, họ tên cư dân, số lượng hợp đồng. 
SELECT CD.MACD, HOTEN, COUNT(MAHD) 
FROM HOPDONG HD, CUDAN CD
WHERE CD.MACD = HD.MACD
AND TRANGTHAICD = 'Dang o' AND TRANGTHAIHD = 'Da het han'
AND YEAR(NGAYHETHAN) = 2024
GROUP BY CD.MACD, HOTEN

--- 3.5. Trong các hợp đồng có tổng chỉ số đã sử dụng của dịch vụ có tên là ‘Điện’ ít nhất, tìm mã hợp đồng có số lượng phiếu tính tiền đã thanh toán từ 2 trở lên. 

SELECT MAHD, COUNT(MAPTT)
FROM PHIEUTINHTIEN PTT
WHERE TINHTRANGTT = 'Da thanh toan'
AND MAHD IN (SELECT TOP 1 WITH TIES MAHD
             FROM PHIEUTINHTIEN PTT, CHITIETTTDV CT, DICHVU DV
             WHERE PTT.MAPTT = CT.MAPTT AND CT.MADV = DV.MADV
             AND TENDV = 'Dien'
             GROUP BY MAHD
             ORDER BY SUM(CHISODV) ASC)
GROUP BY MAHD
ORDER BY COUNT(MAPTT) ASC
HAVING COUNT(MAPTT) >= 2

-----------------------------------------
---------------- ĐỀ 301 -----------------
-----------------------------------------
--- 3.1. Liệt kê thông tin các bác sĩ (mã, họ tên) thuộc chuyên khoa ‘Tai mũi họng’ cùng với thông tin các bệnh nhân (mã, họ tên) mà bác sĩ đó khám bệnh trong năm 2024.

SELECT BS.MABS, HOTENBS, BN.MABN, HOTENBN
FROM BACSI BS, KHAMBENH KB, BENHNHAN BN
WHERE BS.MABS = KB.MABS AND KB.MABN = BN.MABN
AND CHUYENKHOA = 'Tai mui hong' AND YEAR(NGAYKHAM) = 2024

--- 3.2. Liệt kê các bệnh nhân (mã, họ tên) đã được khám bệnh trong năm 2024 nhưng không có đơn thuốc nào đã thanh toán có tổng tiền thanh toán từ 100,000 VNĐ trở lên.
SELECT BN.MABN, HOTENBN
FROM KHAMBENH KB, BENHNHAN BN
WHERE KB.MABN = BN.MABN AND YEAR(NGAYKHAM) = '2024'
EXCEPT
SELECT BN.MABN, HOTENBN
FROM KHAMBENH KB, BENHNHAN BN, DONTHUOC DT
WHERE KB.MABN = BN.MABN AND KB.MAKB = DT.MAKB
AND TINHTRANGDT = 'Da thanh toan' and TONGTIENTT >=100000

--- 3.3. Tìm thông tin các đơn thuốc (mã đơn thuốc, mã khám bệnh) cấp trong năm 2024, đã được thanh toán, và trong chi tiết đơn thuốc có kê tất cả các thuốc thuộc loại ‘Thuốc dị ứng’.
SELECT MADT, MAKB
FROM DONTHUOC DT
WHERE  YEAR(NGAYCAPTHUOC) = '2024' TINHTRANGDT = 'Da thanh toan'
AND NOT EXISTS (SELECT *
                FROM THUOC T
                WHERE LOAITHUOC = 'Thuoc di ung' 
                AND NOT EXISTS (SELECT *
                                FROM CHITIETDT CT
                                WHERE CT.MATHUOC = T.MATHUOC
                                AND CT.MADT = DT.MADT))

--- 3.4. Với mỗi bệnh nhân không có thẻ bảo hiểm y tế, hãy cho biết số lương đơn thuốc đã được thanh toán và cấp trong năm 2024. Thông tin hiển thị: mã bệnh nhân, họ tên bệnh nhân, số lượng
SELECT BN.MABN, HOTENBN, COUNT(MADT)
FROM BENHNHAN BN, KHAMBENH KB, DONTHUOC DT
WHERE BN.MABN = KB.MABN AND KB.MAKB = DT.MAKB
AND YEAR(NGAYCAPTHUOC) = '2024' AND SOBHYT IS NULL
GROUP BY BN.MABN, HOTENBN

--- 3.5. Trong các bệnh nhân có số lần khám bệnh ít nhất, tìm bệnh nhân có tổng số tiền đã thanh toán cho các đơn thuốc cấp trong năm 2024 ít hơn 100,000 VNĐ.

SELECT BN.MABN, HOTENBN, SUM(TONGTIENTT)
FROM BENHNHAN BN, KHAMBENH KB, DONTHUOC DT
WHERE BN.MABN = KB.MABN AND KB.MAKB = DT.MAKB
AND YEAR(NGAYCAPTHUOC) = '2024' 
and TINHTRANGDT = 'Da thanh toan'
AND BN.MABN IN (SELECT TOP 1 WITH TIES MABN
                FROM KHAMBENH KB                
                GROUP BY MABN
                ORDER BY COUNT(MAKB) ASC)
GROUP BY BN.MABN, HOTENBN
HAVING SUM(TONGTIENTT) < 100000


-----------------------------------------
---------------- ĐỀ 302 -----------------
-----------------------------------------
--- 3.1. Liệt kê thông tin các bệnh nhân (mã bệnh nhân, họ tên) có địa chỉ ở ‘Tp.HCM’ cùng thông tin đơn thuốc (mã đơn thuốc, tổng tiền thanh toán) cấp trong năm 2024 của bệnh nhân đó.
SELECT BN.MABN, HOTENBN, MADT, TONGTIENTT
FROM BENHNHAN BN, KHAMBENH KB, DONTHUOC DT
WHERE KB.MABN = BN.MABN AND KB.MAKB = DT.MAKB
AND DIACHI = 'Tp.HCM' AND YEAR(NGAYCAPTHUOC) = 2024

--- 3.2. Liệt kê các bệnh nhân (mã, họ tên) có tỷ lệ chi phí do bảo hiểm y tế chi trả từ 0.1 trở lên và được khám bởi bác sĩ thuộc cả hai chuyên khoa ‘Nội khoa’ và ‘Tai mũi họng’ trong năm 2024.
SELECT BN.MABN, HOTENBN
FROM BACSI BS, KHAMBENH KB, BENHNHAN BN
WHERE BS.MABS = KB.MABS AND KB.MABN = BN.MABN
AND CHUYENKHOA = 'Noi khoa' AND YEAR(NGAYKHAM) = 2024
AND BHYTCHITRA >=0.1
INTERSECT
SELECT BN.MABN, HOTENBN
FROM BACSI BS, KHAMBENH KB, BENHNHAN BN
WHERE BS.MABS = KB.MABS AND KB.MABN = BN.MABN
AND CHUYENKHOA = 'Tai mui hong' AND YEAR(NGAYKHAM) = 2024
AND BHYTCHITRA >=0.1

--- 3.3. Tìm thông tin các thuốc (mã, tên thuốc) thuộc loại ‘Thuốc giảm đau’ được kê trong tất cả các đơn thuốc đã thanh toán và cấp vào ngày 01/12/2024. 
SELECT MATHUOC, TENTHUOC
FROM THUOC T
WHERE LOAITHUOC = 'Thuoc giam dau' 
AND NOT EXISTS (SELECT *
                FROM  DONTHUOC DT
                WHERE NGAYCAPTHUOC = '2024-12-01' AND TINHTRANGDT = 'Da thanh toan'
                AND NOT EXISTS (SELECT *
                                FROM CHITIETDT CT
                                WHERE CT.MATHUOC = T.MATHUOC
                                AND CT.MADT = DT.MADT))

--- 3.4. Với mỗi bác sĩ, hãy cho biết số lượt bệnh nhân có thẻ bảo hiểm y tế mà bác sĩ đó đã khám trong năm 2024. Thông tin hiển thị: mã bác sĩ, họ tên bác sĩ, số lượt. 
SELECT BS.MABS, HOTENBS, COUNT(BN.MABN)
FROM BENHNHAN BN, KHAMBENH KB, BACSI BS
WHERE BN.MABN = KB.MABN AND KB.MABS = BS.MABS
AND YEAR(NGAYKHAM) = '2024' AND SOBHYT IS NOT NULL
GROUP BY BS.MABS, HOTENBS

--- 3.5. TTrong các bệnh nhân có số lần khám bệnh nhiều nhất, tìm bệnh nhân có tổng số tiền đã thanh toán cho các đơn thuốc cấp trong năm 2024 nhiều hơn 250,000 VNĐ.
SELECT BN.MABN, HOTENBN, SUM(TONGTIENTT)
FROM BENHNHAN BN, KHAMBENH KB, DONTHUOC DT
WHERE BN.MABN = KB.MABN AND KB.MAKB = DT.MAKB
AND YEAR(NGAYCAPTHUOC) = '2024' 
and TINHTRANGDT = 'Da thanh toan'
AND BN.MABN IN (SELECT TOP 1 WITH TIES MABN
                FROM KHAMBENH KB                
                GROUP BY MABN
                ORDER BY COUNT(MAKB) DESC)
GROUP BY BN.MABN, HOTENBN
HAVING SUM(TONGTIENTT) > 250000