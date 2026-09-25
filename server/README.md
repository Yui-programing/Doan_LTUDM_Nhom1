# Module Server

Module máy chủ ứng dụng chịu trách nhiệm tiếp nhận kết nối Socket từ Client, xử lý toàn bộ **Business Logic** và truy xuất cơ sở dữ liệu **MySQL** thông qua **JDBC**.

---

## 📁 Cấu trúc package & thư mục

```text
server/
├── pom.xml
└── src/
    └── main/
        ├── java/
        │   └── com/example/server/
        │       ├── ServerApplication.java      # Điểm khởi chạy Socket Server
        │       │
        │       ├── socket/
        │       │   ├── SocketServer.java       # Khởi tạo ServerSocket và quản lý ThreadPool
        │       │   ├── ClientHandler.java      # Xử lý luồng giao tiếp I/O độc lập cho từng Client
        │       │   └── RequestRouter.java      # Điều hướng yêu cầu từ gói tin Socket đến Service phù hợp
        │       │
        │       ├── business/                   # Xử lý toàn bộ logic nghiệp vụ 
        │       │   └── SongService.java        
        │       │
        │       ├── data/
        │       │   └── DatabaseConnection.java # Quản lý kết nối JDBC đến MySQL
        │       │
        │       ├── config/
        │       │   └── AppConfig.java          # Đọc và quản lý thuộc tính cấu hình hệ thống
        │       │
        │       └── util/
        │           ├── VietnameseTextUtil.java # Tiện ích chuẩn hóa tiếng Việt không dấu
        │           └── SearchUtil.java         # Thuật toán tìm kiếm xấp xỉ (Fuzzy Search, Levenshtein)
        │
        └── resources/
            ├── application.properties          # Tệp cấu hình Port Socket, Thread Pool, MySQL
            └── logback.xml                     # Cấu hình ghi vết hệ thống (SLF4J + Logback)
```

---

## 📌 Chức năng chi tiết

* **`ServerApplication.java`**: Chứa hàm `main()` khởi chạy máy chủ, nạp cấu hình và kích hoạt `SocketServer`.
* **`socket/`**:
  * **`SocketServer.java`**: Lắng nghe tại cổng chỉ định trong cấu hình, tiếp nhận kết nối từ các Client và phân bổ xử lý vào Thread Pool.
  * **`ClientHandler.java`**: Triển khai `Runnable` để giao tiếp hai chiều với 1 Client thông qua `InputStream`/`OutputStream`.
  * **`RequestRouter.java`**: Phân tích nội dung gói tin `Request` và gọi Service nghiệp vụ tương ứng để sinh `Response`.
* **`business/SongService.java`**: Cung cấp các phương thức nghiệp vụ: tìm kiếm bài hát theo tên, tìm theo ca sĩ, kết hợp thuật toán tính điểm độ khớp và lấy thông tin chi tiết.
* **`data/DatabaseConnection.java`**: Quản lý `Connection` kết nối đến cơ sở dữ liệu MySQL thông qua JDBC Driver (`mysql-connector-j`).
* **`config/AppConfig.java`**: Nạp thông tin cấu hình từ `application.properties` (Port, Thread Pool size, Database URL, User, Password).
* **`util/`**:
  * **`VietnameseTextUtil.java`**: Loại bỏ dấu thanh, chuyển đổi ký tự tiếng Việt có dấu về ký tự chuẩn để hỗ trợ tìm kiếm không dấu.
  * **`SearchUtil.java`**: Tính toán khoảng cách Levenshtein, độ trùng khớp từ (token overlap) và chấm điểm tương đồng chuỗi.
* **`resources/`**:
  * **`application.properties`**: Cấu hình mạng và cơ sở dữ liệu.
  * **`logback.xml`**: Cấu hình định dạng và cấp độ nhật ký (INFO, WARN, ERROR).

---

## ⚠️ Nguyên tắc ràng buộc bắt buộc (Architectural Rules)

1. Server chịu trách nhiệm **toàn bộ Business Logic** của ứng dụng.
2. Server chịu trách nhiệm gọi External API (nếu cần mở rộng nguồn dữ liệu bên ngoài).
3. Server chịu trách nhiệm **duy nhất** việc truy cập và thao tác với MySQL qua JDBC.
4. Server **KHÔNG ĐƯỢC** phụ thuộc vào module `client`.
5. Không sử dụng Spring Boot hoặc Spring Framework.

---

## 🚀 Hướng dẫn khởi chạy Server

Từ thư mục gốc dự án:
```bash
mvn exec:java -pl server
```
Cổng mặc định lắng nghe là `8080` (có thể điều chỉnh trong `server/src/main/resources/application.properties`).
