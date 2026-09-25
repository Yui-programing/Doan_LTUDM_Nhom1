# Module Client

Module đảm nhận **Presentation Layer** (Giao diện người dùng Desktop bằng JavaFX) và giao tiếp Socket với Server.

---

## 📁 Cấu trúc package & thư mục

```text
client/
├── pom.xml
└── src/
    └── main/
        ├── java/
        │   └── com/example/client/
        │       ├── ClientApplication.java  # Điểm khởi chạy ứng dụng JavaFX Client
        │       │
        │       ├── controller/             # Điều khiển sự kiện giao diện FXML
        │       │
        │       ├── socket/                 # Quản lý kết nối TCP Socket gửi/nhận dữ liệu với Server
        │       │   └── SocketClient.java   
        │       │
        │       ├── media/                  # Xử lý phát trực tuyến (Audio/Media preview) phía Client
        │       │
        │       └── util/                   # Các tiện ích hỗ trợ
        │           ├── ValidationUtil.java # Kiểm tra hợp lệ dữ liệu nhập từ giao diện (Input validation)
        │           └── FormatUtil.java     # Định dạng dữ liệu hiển thị (thời lượng mm:ss, ngày tháng,...)
        │
        └── resources/                  # Tài nguyên ứng dụng
            └── com/example/client/
                ├── fxml/
                │   └── Main.fxml           # Giao diện chính người dùng (JavaFX FXML)
                │
                ├── css/
                │   └── style.css           # Bảng định kiểu giao diện ứng dụng
                │
                └── images/                 # Tài nguyên hình ảnh, biểu tượng tĩnh
```

---

## 📌 Chức năng chi tiết

* **`ClientApplication.java`**: Kế thừa `javafx.application.Application`, nạp tệp `Main.fxml`, áp dụng `style.css` và hiển thị Stage chính.
* **`controller/`**: Chứa các Controller ánh xạ với từng FXML để xử lý tương tác người dùng (nhập từ khóa tìm kiếm, ấn nút play/pause, hiển thị bảng kết quả).
* **`socket/SocketClient.java`**: Kết nối TCP tới Socket Server, tuần tự hóa gói tin `Request` sang JSON để gửi đi, tiếp nhận và giải mã `Response` JSON trả về từ Server.
* **`media/`**: Chứa các lớp hỗ trợ phát âm thanh trực tuyến từ URL xem trước (preview URL).
* **`util/`**:
  * **`ValidationUtil.java`**: Kiểm tra từ khóa rỗng, định dạng đầu vào trước khi gửi đi.
  * **`FormatUtil.java`**: Chuyển đổi giây sang định dạng phút:giây (`mm:ss`), định dạng ngày phát hành, dung lượng.
* **`resources/`**: Lưu trữ các file thiết kế giao diện FXML, stylesheet CSS và hình ảnh giao diện.

---

## ⚠️ Nguyên tắc ràng buộc bắt buộc (Architectural Rules)

1. Client **chỉ** chịu trách nhiệm về giao diện (GUI) và giao tiếp qua TCP Socket.
2. Client **KHÔNG ĐƯỢC** kết nối trực tiếp đến cơ sở dữ liệu MySQL (không dùng JDBC tại client).
3. Client **KHÔNG ĐƯỢC** gọi trực tiếp các External API bên ngoài (toàn bộ truy vấn ngoài đều phải do Server đảm nhận).

---

## 🚀 Hướng dẫn khởi chạy Client

Từ thư mục gốc dự án:
```bash
# Cách 1: Sử dụng JavaFX Maven Plugin (Khuyến nghị)
mvn javafx:run -pl client

# Cách 2: Sử dụng Exec Maven Plugin
mvn exec:java -pl client
```
