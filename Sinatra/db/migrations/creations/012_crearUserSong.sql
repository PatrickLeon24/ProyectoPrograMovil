-- 12. RELACIÓN USUARIO - CANCIÓN (historial y favoritos)
CREATE TABLE user_song (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    song_id INTEGER NOT NULL,
    play_count INTEGER NOT NULL DEFAULT 0,
    last_played DATETIME,
    favorite BOOLEAN NOT NULL DEFAULT 0,
    liked_at DATETIME,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
    UNIQUE(user_id, song_id)
);