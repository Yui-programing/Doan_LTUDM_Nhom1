# Module Common

Thư mục chứa **mã nguồn dùng chung** được đóng gói thành thư viện và phụ thuộc bởi cả 2 module `client` và `server`.

---

## 📁 Cấu trúc package & thư mục con

```text
common/
└── src/main/java/com/example/common/
    ├── dto/             # Data Transfer Objects (Các đối tượng dữ liệu truyền nhận)
    ├── protocol/        # Quy định cấu trúc gói tin giao tiếp giữa Client & Server
    ├── request/         # Chứa các lớp biểu diễn yêu cầu từ Client (Request objects)
    └── response/        # Chứa các lớp biểu diễn phản hồi từ Server (Response objects)
```

---

## 📌 Chức năng chi tiết

* **`protocol/`**: Định nghĩa các mã lệnh/hành động (Action Types như `SEARCH_SONG`, `STREAM_SONG`, `LOGIN`) và cấu trúc khung gói tin chung.
* **`request/`**: Các lớp Java chứa dữ liệu Client gửi lên Server.    
  *Ví dụ:* `SearchSongRequest` (chứa tên bài hát cần tìm).
* **`response/`**: Các lớp Java chứa dữ liệu Server trả về cho Client.  
  *Ví dụ:* `SearchSongResponse` (chứa danh sách kết quả bài hát tìm thấy và mã trạng thái success/failed).
* **`dto/`**: Các đối tượng dữ liệu nhẹ truyền tải qua mạng (ví dụ `SongDTO`, `UserDTO`) giúp dễ dàng chuyển đổi thành JSON hoặc Serialize truyền qua Socket.
