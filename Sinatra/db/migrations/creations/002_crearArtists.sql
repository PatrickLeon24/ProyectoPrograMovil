-- 2. ARTISTAS
CREATE TABLE artists (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    stage_name VARCHAR(100) NOT NULL,
    is_band BOOLEAN NOT NULL DEFAULT 0,
    biography TEXT,
    profile_image VARCHAR(255),
    formed_date DATE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);