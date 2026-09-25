# Module Common

Module thư viện **dùng chung** giữa `client` và `server` trong mô hình phân tán Client - Server.

---

## 📁 Cấu trúc package

```text
common/
├── pom.xml
└── src/
    └── main/
        └── java/
            └── com/example/common/
                ├── model/       # Các đối tượng thực thể dữ liệu dùng chung (Song, Artist,...)
                └── protocol/    # Định nghĩa giao thức gói tin truyền thông điệp Socket (Request, Response, Status,...)
```

---

## 📌 Chức năng chi tiết

* **`model/`**: Định nghĩa các lớp dữ liệu chung biểu diễn thông tin bài hát, ca sĩ, danh sách phát... được trao đổi tuần tự hóa giữa Client và Server.
* **`protocol/`**: Định nghĩa chuẩn khung gói tin trao đổi qua TCP Socket:
  * Kiểu thông điệp/yêu cầu (ví dụ: `SEARCH_BY_TITLE`, `SEARCH_BY_ARTIST`,...).
  * Đối tượng yêu cầu (`Request`) và đối tượng phản hồi (`Response`).
  * Trạng thái phản hồi (`ResponseStatus` như `SUCCESS`, `ERROR`, `NOT_FOUND`).

---

## ⚠️ Nguyên tắc ràng buộc bắt buộc (Architectural Rules)

1. **CHỈ được chứa**:
   * Data Model
   * Protocol
2. **TUYỆT ĐỐI KHÔNG chứa**:
   * Thư viện JavaFX hoặc mã liên quan đến GUI.
   * JDBC Driver, kết nối MySQL hoặc truy vấn cơ sở dữ liệu.
   * Cài đặt kết nối Socket (`Socket`, `ServerSocket`).
   * Logic nghiệp vụ (Business Logic).
