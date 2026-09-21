# Module Server

Thư mục chứa mã nguồn phía **Server** của ứng dụng (Socket Server + Đa luồng + Truy vấn Database JDBC).

---

## 📁 Cấu trúc package & thư mục con

```text
server/
├── src/main/java/com/example/server/
│   ├── socket/          # Quản lý ServerSocket, Thread Pool & luồng ClientHandler
│   ├── controller/      # Phân loại và điều hướng yêu cầu (Request Router) từ Client
│   ├── service/         # Xử lý logic nghiệp vụ (Tìm kiếm bài hát, xác thực người dùng)
│   ├── repository/      # Thao tác với Cơ sở dữ liệu (JDBC DAO: Select, Insert, Update)
│   ├── model/           # Các lớp Entity ánh xạ với bảng trong Database (Song, User)
│   ├── config/          # Cấu hình hệ thống Server (Cổng Port, Database Connection)
│   ├── util/            # Các hàm tiện ích (Mã hóa, JWT/Token, Logger)
│   ├── cache/           #  Bộ nhớ đệm dữ liệu tạm thời
│   ├── external/        #  Kết nối API bên thứ ba nếu có
│   └── ServerApplication.java  # Lớp chính khởi chạy Socket Server
│
└── src/main/resources/
    ├── application.properties  # File cấu hình Port, thông tin kết nối MySQL
    └── logback.xml             # Cấu hình ghi nhật ký hệ thống (Log)
```

---

## 📌 Chức năng chi tiết

* **`socket/`**: Chứa `ServerManager` lắng nghe kết nối từ Client và `ClientHandler` (chạy trên các luồng riêng biệt - Multithreading) để xử lý đồng thời nhiều Client cùng lúc.
* **`repository/`**: Chứa các lớp DAO (Data Access Object) thực thi câu lệnh SQL qua JDBC để truy vấn danh sách bài hát từ MySQL.
* **`service/`**: Nhận yêu cầu từ `controller/` để xử lý logic, gọi `repository/` lấy dữ liệu và chuẩn bị `Response` gửi lại cho Client.
* **`resources/application.properties`**: Nơi bạn thiết lập `port` lắng nghe (ví dụ 8888) và thông tin `db.url`, `db.user`, `db.password`.
