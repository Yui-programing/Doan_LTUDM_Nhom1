-- ==============================================================
-- Database Schema for Song & Artist Search Application
-- ==============================================================

CREATE DATABASE IF NOT EXISTS song_search_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE song_search_db;

-- 1. Users Table
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 2. Artists Table
CREATE TABLE IF NOT EXISTS artists (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    genre VARCHAR(100),
    country VARCHAR(100),
    avatar_url VARCHAR(500),
    biography TEXT,
    INDEX idx_artist_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 3. Songs Table
CREATE TABLE IF NOT EXISTS songs (
    id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    artist VARCHAR(150) NOT NULL,
    album VARCHAR(150),
    duration INT DEFAULT 0,
    preview_url VARCHAR(500),
    cover_url VARCHAR(500),
    release_date VARCHAR(50),
    genre VARCHAR(100),
    lyrics TEXT,
    source VARCHAR(50) DEFAULT 'LOCAL',
    INDEX idx_song_title (title),
    INDEX idx_song_artist (artist),
    INDEX idx_song_genre (genre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 4. Playlists Table
CREATE TABLE IF NOT EXISTS playlists (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_playlist_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 5. Playlist Songs Table (Many-to-Many)
CREATE TABLE IF NOT EXISTS playlist_songs (
    playlist_id BIGINT NOT NULL,
    song_id VARCHAR(50) NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (playlist_id, song_id),
    FOREIGN KEY (playlist_id) REFERENCES playlists(id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 6. Song Cache Table (for caching external API search results)
CREATE TABLE IF NOT EXISTS song_cache (
    id VARCHAR(50) PRIMARY KEY,
    query_keyword VARCHAR(255) NOT NULL,
    title VARCHAR(200) NOT NULL,
    artist VARCHAR(150) NOT NULL,
    song_json TEXT NOT NULL,
    cached_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_cache_keyword (query_keyword)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ==============================================================
-- Sample Data
-- ==============================================================

-- Sample Users (Passwords in real app can be hashed)
INSERT INTO users (id, username, password, full_name, email) VALUES
(1, 'demo_user', '123456', 'Nguyen Van Demo', 'demo@example.com'),
(2, 'admin', 'admin123', 'System Administrator', 'admin@example.com')
ON DUPLICATE KEY UPDATE username=username;

-- Sample Artists
INSERT INTO artists (id, name, genre, country, avatar_url, biography) VALUES
('art_001', 'Sơn Tùng M-TP', 'V-Pop / R&B', 'Việt Nam', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Son_Tung_M-TP_2017.png/640px-Son_Tung_M-TP_2017.png', 'Ca sĩ kiêm nhạc sĩ hàng đầu Việt Nam, nổi tiếng với nhiều hit đình đám.'),
('art_002', 'Đen Vâu', 'Hip-hop / Rap', 'Việt Nam', 'https://upload.wikimedia.org/wikipedia/vi/f/f6/%C4%90en_V%C3%A2u.jpg', 'Rapper nổi tiếng với lời bài hát mộc mạc, triết lý và giàu cảm xúc đời thường.'),
('art_003', 'Vũ.', 'Indie Pop', 'Việt Nam', 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Vu_singer.jpg/640px-Vu_singer.jpg', 'Hoàng tử Indie Việt Nam với chất giọng trầm ấm, các bản tình ca da diết.'),
('art_004', 'Taylor Swift', 'Pop / Country', 'United States', 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/191125_Taylor_Swift_at_the_2019_American_Music_Awards.png/640px-191125_Taylor_Swift_at_the_2019_American_Music_Awards.png', 'Ca sĩ nhạc sĩ người Mỹ có lượng fan và giải thưởng Grammy đông đảo bậc nhất.')
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- Sample Songs
INSERT INTO songs (id, title, artist, album, duration, preview_url, cover_url, release_date, genre, lyrics, source) VALUES
('song_001', 'Nơi Này Có Anh', 'Sơn Tùng M-TP', 'Single', 260, 'https://audio-samples.github.io/samples/mp3/blizzard_biased/sample-1.mp3', 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4', '2017-02-14', 'V-Pop', 'Khắp thế gian này dẫu gió mênh mang...', 'LOCAL'),
('song_002', 'Lạc Trôi', 'Sơn Tùng M-TP', 'Single', 233, 'https://audio-samples.github.io/samples/mp3/blizzard_biased/sample-2.mp3', 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745', '2017-01-01', 'V-Pop', 'Người theo hương hoa mây mù giăng lối...', 'LOCAL'),
('song_003', 'Đưa Nhau Đi Trốn', 'Đen Vâu', 'Single', 242, 'https://audio-samples.github.io/samples/mp3/blizzard_biased/sample-1.mp3', 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f', '2015-09-08', 'Rap', 'Đi cùng anh qua muôn ngàn đèo dốc...', 'LOCAL'),
('song_004', 'Lối Nhỏ', 'Đen Vâu', 'Single', 255, 'https://audio-samples.github.io/samples/mp3/blizzard_biased/sample-2.mp3', 'https://images.unsplash.com/photo-1465847899084-d164df4dedc6', '2019-10-21', 'Rap', 'Em vào đời bằng đại lộ còn anh vào đời bằng lối nhỏ...', 'LOCAL'),
('song_005', 'Bước Qua Mùa Cô Đơn', 'Vũ.', 'Một Vạn Năm', 280, 'https://audio-samples.github.io/samples/mp3/blizzard_biased/sample-1.mp3', 'https://images.unsplash.com/photo-1445985543468-79496ba8887f', '2020-11-12', 'Indie', 'Mùa thu rơi vào em, mùa thu nghiêng bàn chân...', 'LOCAL'),
('song_006', 'Blank Space', 'Taylor Swift', '1989', 231, 'https://audio-samples.github.io/samples/mp3/blizzard_biased/sample-2.mp3', 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819', '2014-10-27', 'Pop', 'Nice to meet you, where you been?...', 'LOCAL')
ON DUPLICATE KEY UPDATE title=VALUES(title);

-- Sample Playlists
INSERT INTO playlists (id, user_id, name, description) VALUES
(1, 1, 'Nhạc Trẻ Yêu Thích', 'Danh sách các bài hát V-Pop được nghe nhiều nhất.'),
(2, 1, 'Chill Cuối Tuần', 'Giai điệu nhẹ nhàng thư giãn.')
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- Sample Playlist Songs
INSERT INTO playlist_songs (playlist_id, song_id) VALUES
(1, 'song_001'),
(1, 'song_002'),
(2, 'song_004'),
(2, 'song_005')
ON DUPLICATE KEY UPDATE playlist_id=playlist_id;
