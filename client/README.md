# Module Client

Thư mục chứa mã nguồn phía **Client** của ứng dụng (Giao diện người dùng JavaFX + Socket Client).

---

## 📁 Cấu trúc package & thư mục con

```text
client/
├── src/main/java/com/example/client/
│   ├── controller/      # Quản lý sự kiện giao diện (Gắn với các file .fxml)
│   ├── socket/          # Quản lý kết nối Socket TCP/UDP gửi/nhận dữ liệu với Server
│   ├── service/         # Xử lý nghiệp vụ phía Client (Xử lý âm thanh, logic hiển thị)
│   ├── model/           # Các đối tượng dữ liệu lưu trữ tạm tại Client
│   ├── util/            # Các hàm tiện ích (Format time, Helper chuyển màn hình,...)
│   └── ClientApplication.java  # Lớp chính khởi chạy ứng dụng Client (JavaFX Main)
│
└── src/main/resources/com/example/client/
    ├── fxml/            # Chứa các file giao diện JavaFX (.fxml)
    ├── css/             # Chứa file stylesheet làm đẹp giao diện (.css)
    └── assets/          # Chứa các hình ảnh, icon, logo của ứng dụng
```

---

## 📌 Chức năng chi tiết

* **`controller/`**: Mỗi màn hình JavaFX (`.fxml`) có 1 Controller tương ứng (ví dụ: `MainController`, `SearchController`) để bắt sự kiện click nút, nhập ô tìm kiếm.
* **`socket/`**: Chứa lớp `ClientSocketManager` mở kết nối Socket đến Server, gửi các đối tượng `Request` và lắng nghe `Response` trả về từ Server.
* **`service/`**: Nhận dữ liệu từ Controller, gọi `socket` để gửi đi Server và xử lý phát nhạc (Audio Player).
* **`resources/`**: Lưu trữ toàn bộ tài nguyên tĩnh (Giao diện FXML, CSS, Icon nút ,...).
