# Đồ án Lập trình ứng dụng mạng - Nhóm 1

Xây dựng ứng dụng tra cứu và phát nhạc trực tuyến theo kiến trúc Client - Server trên nền tảng Java.

---

## 📁 Cấu trúc thư mục dự án

```text
Doan_LTUDM_Nhom1/
├── client/       # Mã nguồn phía Client (Giao diện người dùng + Socket Client)
├── server/       # Mã nguồn phía Server (Socket Server + Xử lý dữ liệu & Database)
├── common/       # Mã nguồn dùng chung (Model dữ liệu, Request/Response Protocol)
├── database/     # Các script SQL khởi tạo cơ sở dữ liệu
└── pom.xml       # File cấu hình Maven tổng (Root Project)
```

---

## 📌 Chức năng chi tiết từng thư mục

* **`client/`**: Đảm nhận hiển thị giao diện người dùng (JavaFX), tiếp nhận thao tác tra cứu/phát nhạc và gửi/nhận gói tin với Server qua Socket Client.
* **`server/`**: Máy chủ ứng dụng. Lắng nghe kết nối từ Client qua Socket Server, xử lý đa luồng (Multithreading), thực hiện truy vấn Database (JDBC) và trả kết quả về cho Client.
* **`common/`**: Thư viện chứa các lớp dùng chung cho cả Client và Server (như `Song`, `User`, đối tượng gói tin `Request`/`Response`).
* **`database/`**: Chứa các file script `.sql` dùng để tạo Database, tạo bảng và chèn dữ liệu bài hát mẫu.
* **`pom.xml`**: File quản lý cấu hình Maven chung cho toàn bộ dự án, quản lý phiên bản Java (JDK 21) và các thư viện (JavaFX, MySQL, Jackson JSON,...).

---

## 🚀 Hướng dẫn khởi chạy nhanh

1. **Tạo Database**: Chạy các file script `.sql` trong thư mục `database/` trên MySQL.
2. **Cấu hình Server**: Cập nhật `username` và `password` MySQL trong file `server/src/main/resources/application.properties`.
3. **Mở dự án**: Mở trực tiếp thư mục `Doan_LTUDM_Nhom1` bằng IDE (IntelliJ IDEA / Eclipse / VS Code).
4. **Khởi chạy**: 
   - Chạy Server trước: `ServerApplication.java`
   - Chạy Client sau: `ClientApplication.java`
