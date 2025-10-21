-- 6. CANCIONES (depende de albums)
CREATE TABLE songs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(150) NOT NULL,
    duration INTEGER NOT NULL,
    file_url VARCHAR(255) NOT NULL,
    release_date DATE,
    album_id INTEGER,
    play_count_global INTEGER NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE SET NULL
);