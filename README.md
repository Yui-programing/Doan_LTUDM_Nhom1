# Đồ án Lập trình ứng dụng mạng - Nhóm 1

Ứng dụng tìm kiếm thông tin bài hát và ca sĩ theo mô hình **Client - Server** trên nền tảng **Java 21**.

---

## 🏗️ Kiến trúc tổng thể

```text
                    ┌──────────────────────┐
                    │      JAVA FX CLIENT  │
                    │                      │
                    │   Presentation Layer │
                    └──────────┬───────────┘
                               │
                         TCP Socket
                               │
                    ┌──────────▼───────────┐
                    │        SERVER        │
                    │                      │
                    │ Socket               │
                    │      ↓               │
                    │ Business Logic       │
                    │      ↓               │
                    │ Data Access          │
                    └──────────┬───────────┘
                               │
                               ▼
                           MySQL
```

### 10 Nguyên tắc kiến trúc bắt buộc:
1. **Client** chỉ chịu trách nhiệm GUI và giao tiếp Socket.
2. **Client KHÔNG ĐƯỢC** kết nối trực tiếp MySQL.
3. **Client KHÔNG ĐƯỢC** gọi External API.
4. **Server** chịu trách nhiệm toàn bộ Business Logic.
5. **Server** chịu trách nhiệm gọi External API.
6. **Server** chịu trách nhiệm truy cập MySQL.
7. **Common** chỉ chứa model dùng chung và protocol.
8. **Không** đưa JavaFX vào common.
9. **Không** đưa MySQL/JDBC vào common.
10. **Không** để server phụ thuộc vào client.

---

## 🛠️ Công nghệ sử dụng

* **Java Version**: **Java 21 (JDK 21)**
* **Quản lý dự án**: **Apache Maven** (Multi-Module Project: `common`, `client`, `server`)
* **Giao diện người dùng (Client)**: **JavaFX 21** (`javafx-controls`, `javafx-fxml`)
* **Giao tiếp mạng**: **TCP Socket** thuần (`java.net.Socket`, `java.net.ServerSocket`), Lập trình đa luồng (`ThreadPoolExecutor`)
* **Cơ sở dữ liệu (Server)**: **MySQL 8.0** & **JDBC** (`mysql-connector-j`)
* **Định dạng dữ liệu**: **Jackson JSON** (`jackson-databind`, `jackson-datatype-jsr310`)
* **Ghi nhật ký (Logging)**: **SLF4J** & **Logback Classic**
* **Lưu ý**: Tuyệt đối **không** sử dụng Spring Boot hoặc Spring Framework.

---

## 📁 Cấu trúc thư mục dự án

```text
song-search-app/
│
├── pom.xml
│
├── common/
│   ├── pom.xml
│   └── src/
│       └── main/
│           └── java/
│               └── com/example/common/
│                   ├── model/
│                   └── protocol/
│
├── client/
│   ├── pom.xml
│   └── src/
│       └── main/
│           ├── java/
│           │   └── com/example/client/
│           │       ├── ClientApplication.java
│           │       │
│           │       ├── controller/
│           │       │
│           │       ├── socket/
│           │       │   └── SocketClient.java
│           │       │
│           │       ├── media/
│           │       │
│           │       └── util/
│           │           ├── ValidationUtil.java
│           │           └── FormatUtil.java
│           │
│           └── resources/
│               └── com/example/client/
│                   ├── fxml/
│                   │   └── Main.fxml
│                   │
│                   ├── css/
│                   │   └── style.css
│                   │
│                   └── images/
│
├── server/
│   ├── pom.xml
│   └── src/
│       └── main/
│           ├── java/
│           │   └── com/example/server/
│           │       ├── ServerApplication.java
│           │       │
│           │       ├── socket/
│           │       │   ├── SocketServer.java
│           │       │   ├── ClientHandler.java
│           │       │   └── RequestRouter.java
│           │       │
│           │       ├── business/
│           │       │   ├── SongService.java
│           │       │
│           │       ├── data/
│           │       │   ├── DatabaseConnection.java
│           │       │
│           │       ├── config/
│           │       │   └── AppConfig.java
│           │       │
│           │       └── util/
│           │           ├── VietnameseTextUtil.java
│           │           └── SearchUtil.java
│           │
│           └── resources/
│               ├── application.properties
│               └── logback.xml
│
└── database/
    └── schema.sql
```

---

## 🗄️ Cơ sở dữ liệu (Database)

Tệp [schema.sql](file:///e:/Hoc%20Tap/L%E1%BA%ADp%20tr%C3%ACnh%20%E1%BB%A9ng%20d%E1%BB%A5ng%20m%E1%BA%A1ng/Doan_LTUDM_Nhom1/database/schema.sql) trong thư mục `database/` đã định nghĩa sẵn:
1. `users`: Bảng người dùng hệ thống.
2. `artists`: Bảng thông tin ca sĩ, thể loại, tiểu sử.
3. `songs`: Bảng thông tin bài hát, thời lượng, URL phát thử nghiệm, lời bài hát.
4. `playlists` & `playlist_songs`: Bảng danh sách bài hát yêu thích.
5. `song_cache`: Bảng bộ nhớ đệm kết quả tìm kiếm.
6. Dữ liệu mẫu (Sample data) bài hát V-Pop & quốc tế.

---

## 🚀 Hướng dẫn biên dịch và khởi chạy

### 1. Biên dịch toàn bộ dự án
Mở Terminal tại thư mục gốc và chạy:
```bash
mvn clean compile
```

### 2. Thiết lập cơ sở dữ liệu
* Tạo cơ sở dữ liệu MySQL bằng script:
```bash
mysql -u root -p < database/schema.sql
```
* Kiểm tra và cập nhật cấu hình kết nối tại `server/src/main/resources/application.properties`.

### 3. Khởi chạy Server
```bash
mvn exec:java -pl server
```

### 4. Khởi chạy Client
```bash
# Cách 1: Sử dụng JavaFX plugin (Khuyến nghị)
mvn javafx:run -pl client

# Cách 2: Sử dụng Exec plugin
mvn exec:java -pl client
```
