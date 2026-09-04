# 🚀 URMYFOOD Installation Guide

Tài liệu này hướng dẫn chi tiết các bước cài đặt cấu hình, build và khởi chạy hệ thống **URMYFOOD** (bao gồm Backend Spring Boot và 3 ứng dụng Android Client: User, Shop, Admin), đồng thời cung cấp các thông tin cấu hình môi trường (.env, local.properties) và các tài khoản thử nghiệm của hệ thống.

---

## 🛠 Yêu Cầu Hệ Thống (Prerequisites)

Trước khi bắt đầu, hãy đảm bảo máy tính của bạn đã cài đặt các công cụ sau:
1. **Java Development Kit (JDK)**: Phiên bản **21** hoặc mới hơn.
2. **Android Studio**: Phiên bản mới nhất (Koala trở lên được khuyến nghị).
3. **Android SDK**: API Level 36 (Android 14/15) và API Level 29 (Android 10) là mức tối thiểu.
4. **Git**: Để clone mã nguồn.
5. **Maven** (đã tích hợp sẵn wrapper trong thư mục backend).

---

## ⚙️ Hướng Dẫn Cài Đặt & Cấu Hình

### Bước 1: Clone Mã Nguồn Dự Án
Mở terminal và chạy lệnh sau để tải project về máy:
```bash
git clone https://github.com/Redamancy2107/URMYFOOD.git
cd URMYFOOD
```

---

### Bước 2: Thiết Lập & Khởi Chạy Backend (Spring Boot)

1. **Cấu hình môi trường Backend**:
   - Tạo file `.env` tại thư mục gốc của dự án `URMYFOOD/` (xem nội dung chi tiết bên dưới).

2. **Chạy Backend**:
   - Di chuyển vào thư mục `backend`:
     ```bash
     cd backend
     ```
   - Build và chạy ứng dụng:
     - Trên Windows:
       ```bash
       mvnw.cmd spring-boot:run
       ```
     - Trên macOS/Linux:
       ```bash
       ./mvnw spring-boot:run
       ```
   - Mặc định backend sẽ khởi chạy tại cổng `http://localhost:8080`.

---

### Bước 3: Thiết Lập & Khởi Chạy Frontend (Android Client)

Thư mục `frontend` chứa 3 ứng dụng Android dạng Gradle multi-module: `:app-user`, `:app-shop`, và `:app-admin`.

1. **Mở dự án trong Android Studio**:
   - Khởi động Android Studio.
   - Chọn **Open** và dẫn tới thư mục `frontend` trong project `URMYFOOD`.

2. **Cấu hình kết nối API & Google Auth**:
   - Tạo một file tên là `local.properties` tại thư mục `frontend/` (nếu chưa có, xem mẫu bên dưới).
   - Thêm các cấu hình tương tự mẫu và điều chỉnh đường dẫn `sdk.dir` phù hợp với máy tính của bạn.

3. **Sync Gradle**:
   - Bấm vào biểu tượng **Sync Project with Gradle Files** (hình con voi) ở góc trên bên phải Android Studio và chờ quá trình đồng bộ hoàn tất.

4. **Khởi chạy ứng dụng**:
   - Trên thanh công cụ Android Studio, chọn module bạn muốn khởi chạy ở ô chọn Run Configuration:
     - `:app-user` (Ứng dụng cho Khách hàng)
     - `:app-shop` (Ứng dụng cho Chủ quán)
     - `:app-admin` (Ứng dụng cho Quản trị viên)
   - Chọn thiết bị máy ảo (Emulator) hoặc thiết bị thật (qua USB Debugging/Wireless Debugging).
   - Nhấn nút **Run** (hình tam giác xanh) để cài đặt và khởi chạy.

---

## 🔍 Kiểm Tự Kết Nối (Troubleshooting)

- **Lỗi không kết nối được API**: Đảm bảo rằng thiết bị Android của bạn cùng kết nối chung mạng Wi-Fi với máy tính chạy Backend (nếu dùng thiết bị thật) và cấu hình đúng địa chỉ IP trong `local.properties`.

---

## 📄 File Cấu Hình Môi Trường (Environment Config Files)

### 1. File `.env`
Đặt file này tại **thư mục gốc** của dự án (`URMYFOOD/`):

```env
# Database Configuration
DB_URL=jdbc:postgresql://aws-1-ap-northeast-1.pooler.supabase.com:5432/postgres
DB_USERNAME=postgres.yfdhsoilpawzhxbftlbe
DB_PASSWORD=urmyfood.uit.vnuhcm

# Security Configuration
JWT_SECRET=404E635266556A586E3272357538782F413F4428472B4B6250645367566B5970
JWT_EXPIRATION=86400000
JWT_REFRESH_EXPIRATION=604800000

# Social Login & Gmail API Configuration
GOOGLE_CLIENT_ID=your_google_client_id_here
GOOGLE_CLIENT_SECRET=your_google_client_secret_here
GOOGLE_REFRESH_TOKEN=your_google_refresh_token_here

SUPABASE_URL=https://yfdhsoilpawzhxbftlbe.supabase.co
SUPABASE_ANON_KEY=sb_publishable_JmmDh_osEt0VgNJSjU2EJA_cR5GMS8I
SUPABASE_STORAGE_BUCKET=urmyfood-bucket
SUPABASE_PROFILE_IMAGE_MAX_SIZE=1048576
```

### 2. File `local.properties`
Đặt file này tại **thư mục `frontend/`** (`URMYFOOD/frontend/local.properties`):

```properties
# Location of the SDK. This is only used by Gradle.
# Thay đổi đường dẫn sdk.dir cho đúng với môi trường máy của bạn (sử dụng dấu hai chấm thoát \\ và hai gạch chéo \\)
sdk.dir=E\:\\ProgramFiles\\Android\\Sdk

GOOGLE_SERVER_CLIENT_ID=your_google_client_id_here
base_url=http://10.0.2.2:8080
# base_url=https://urmyfood-backend-dev.onrender.com
```

---

## 🔑 Tài khoản đăng nhập:

### Customer:

| Account | Password |
| :--- | :--- |
| `statistics_customer@urmyfood.com` | `Urmyfood@1` |

### Shop:

| Account | Password |
| :--- | :--- |
| `cali_nguyenhue@urmyfood.com` | `Urmyfood@1` |

### Admin:

| Account | Password |
| :--- | :--- |
| `webarebear1000@gmail.com` | `12345678` |
