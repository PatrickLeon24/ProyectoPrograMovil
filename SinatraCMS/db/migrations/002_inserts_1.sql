-- Chicos aca ponemos nuestros propios inserts 
-- de cada tabla que estamos trabajando por pagina

-- Insertar generos
INSERT INTO genres (id, name, description, color) VALUES
(1, 'Pop', 'Género popular con melodías pegajosas y ritmos bailables.', '0xFF00B4D8'),
(2, 'Rock', 'Guitarras eléctricas, baterías intensas y fuerte presencia vocal.', '0xFF212121'),
(3, 'Hip Hop', 'Bases rítmicas con rap y elementos urbanos.', '0xFFFF9800'),
(4, 'Electrónica', 'Música producida principalmente con sintetizadores y computadoras.', '0xFF9C27B0'),
(5, 'Jazz', 'Improvisación y ritmo sofisticado con instrumentos de viento y cuerda.', '0xFF1A237E'),
(6, 'Clásico', 'Música orquestal y de cámara de los grandes compositores.', '0xFF2C3E50'),
(7, 'Reggaeton', 'Ritmos latinos urbanos con influencias caribeñas.', '0xFFF44336'),
(8, 'Alternativo', 'Producciones independientes con estilo alternativo.', '0xFF4CAF50'),
(9, 'Trap', 'Subgénero del hip hop con beats graves y letras urbanas.', '0xFF1A237E'),
(10,'Punk', 'Guitarras rápidas, letras rebeldes y actitud irreverente.', '0xFFD81B60');

--Insertar artistas
INSERT INTO artists (id, stage_name, is_band, biography, profile_image, formed_date) VALUES
(1, 'Luna Nova', 0, 'Cantautora de pop alternativo con influencias electrónicas.', 'Artist_icon.jpg', '2018-03-10'),
(2, 'Midnight Waves', 1, 'Banda de rock alternativo con sonidos atmosféricos.', 'Artist_icon.jpg', '2015-06-21'),
(3, 'Urban Flow', 1, 'Colectivo de hip hop y trap latino.', 'Artist_icon.jpg', '2019-01-15'),
(4, 'DJ Aurora', 0, 'Productora de música electrónica y lo-fi.', 'Artist_icon.jpg', '2017-09-01'),
(5, 'Ritmo Callejero', 1, 'Grupo de reggaetón y dancehall.', 'Artist_icon.jpg', '2020-02-10'),
(6, 'Soul Lights', 1, 'Banda de R&B y neo-soul.', 'Artist_icon.jpg', '2016-10-05'),
(7, 'Andes Indie', 1, 'Proyecto indie con fusiones de ritmos andinos.', 'Artist_icon.jpg', '2014-11-30'),
(8, 'Sabor Caribe', 1, 'Orquesta de salsa moderna.', 'Artist_icon.jpg', '2010-05-01'),
(9, 'Galaxy Kids', 1, 'Grupo juvenil de estilo K-Pop latino.', 'Artist_icon.jpg', '2021-04-18'),
(10,'Echo Minimal', 0, 'Productor de ambient y minimal electrónico.', 'Artist_icon.jpg', '2013-07-12');

--Insertar albums
INSERT INTO albums (id, name, release_date, cover_image, artist_id) VALUES
(1, 'Noches de Ciudad','2023-05-10', 'Album_icon.png',1),
(2, 'Aurora Lo-Fi',         '2022-11-20', 'Album_icon.png',4), 
(3, 'Ritmo en la Calle',    '2024-01-05', 'Album_icon.png',4),
(4, 'Ecos del Ande',        '2022-09-30', 'Album_icon.png',7),
(5, 'Sueños de Verano',     '2023-12-15', 'Album_icon.png',1),
(6, 'Sabor a Medianoche',   '2021-07-22', 'Album_icon.png',7),
(7, 'Galaxy Beat',          '2024-04-10', 'Album_icon.png',7),
(8, 'Rock Classics Vol. 1', '2020-06-01', 'Album_icon.png',2),
(9, 'Fiesta Urbana',        '2023-03-01', 'Album_icon.png',5),
(10,'Minimal Nights',       '2021-10-10', 'Album_icon.png',10);

--Insertar canciones
INSERT INTO songs (
  id, name, duration, file_url, release_date, album_id, play_count_global
) VALUES
(1, 'Midnight City Lights', 210, '/music/midnight_city_lights.mp3', '2023-05-10', 1, 12000),
(2, 'Lluvia de Neón',       185, '/music/lluvia_de_neon.mp3',        '2023-08-01', 1,  8500),
(3, 'Horizonte Lo-Fi',      240, '/music/horizonte_lofi.mp3',        '2022-11-20', 2,  6400),
(4, 'Ritmo en la Calle',    200, '/music/ritmo_en_la_calle.mp3',     '2024-01-05', 5, 15200),
(5, 'Aurora Digital',       195, '/music/aurora_digital.mp3',        '2023-03-18', 2,  9800),
(6, 'Ecos del Ande',        230, '/music/ecos_del_ande.mp3',         '2022-09-30', 4,  4300),
(7, 'Sueños de Verano',     215, '/music/suenos_de_verano.mp3',      '2023-12-15', 5,  7700),
(8, 'Sabor a Medianoche',   210, '/music/sabor_a_medianoche.mp3',    '2021-07-22', 7, 15000),
(9, 'Galaxy Beat',          190, '/music/galaxy_beat.mp3',           '2024-04-10', 7, 22000),
(10,'Silencio Urbano',      250, '/music/silencio_urbano.mp3',       '2022-02-14', 10,  5600);

--Insertar usuarios (para perfiles, login, etc)
INSERT INTO users (
  id, name, last_name, username, password_hash, email,
  profile_image, birth_date, phone, created_at, is_verified,
  last_login, verification_token, reset_token, reset_token_expires
) VALUES
(1, 'user', 'prueba', 'user', 'hash_pw_1', 'user@example.com',
 'user.jpg', '1998-01-15', '+51 900000001', '2025-01-10 14:30:00', 1,
 '2025-11-01 09:10:00', NULL, NULL, NULL),
(2, 'Carla', 'Torres', 'carla_music', 'hash_pw_2', 'carla@example.com',
 'user.jpg', '2000-05-22', '+51 900000002', '2025-02-05 10:00:00', 1,
 '2025-10-30 19:20:00', NULL, NULL, NULL),
(3, 'Jorge', 'Paredes', 'jorge_lofi', 'hash_pw_3', 'jorge@example.com',
 'user.jpg', '1995-09-09', '+51 900000003', '2025-03-12 16:45:00', 0,
 NULL, 'verif_tok_3', NULL, NULL),
(4, 'Lucía', 'Ramos', 'lucia_pop', 'hash_pw_4', 'lucia@example.com',
 'user.jpg', '2001-11-30', '+51 900000004', '2025-04-01 08:15:00', 1,
 '2025-10-20 22:00:00', NULL, NULL, NULL),
(5, 'Diego', 'Fernández', 'diego_rock', 'hash_pw_5', 'diego@example.com',
 'user.jpg', '1997-07-07', '+51 900000005', '2025-04-18 12:00:00', 0,
 NULL, 'verif_tok_5', 'reset_tok_5', '2025-11-15 23:59:59'),
(6, 'María', 'Gómez', 'maria_rnb', 'hash_pw_6', 'maria@example.com',
 'user.jpg', '1999-02-10', '+51 900000006', '2025-05-02 13:20:00', 1,
 '2025-11-05 17:30:00', NULL, NULL, NULL),
(7, 'Sergio', 'López', 'sergio_indie', 'hash_pw_7', 'sergio@example.com',
 'user.jpg', '1996-03-03', '+51 900000007', '2025-06-09 09:40:00', 1,
 '2025-10-28 11:00:00', NULL, NULL, NULL),
(8, 'Ana', 'Huamán', 'ana_kpop', 'hash_pw_8', 'ana@example.com',
 'user.jpg', '2002-12-01', '+51 900000008', '2025-07-15 18:25:00', 1,
 '2025-11-08 21:10:00', NULL, NULL, NULL),
(9, 'Pedro', 'Rivas', 'pedro_salsa', 'hash_pw_9', 'pedro@example.com',
 'user.jpg', '1994-04-19', '+51 900000009', '2025-08-03 20:00:00', 0,
 NULL, 'verif_tok_9', NULL, NULL),
(10,'Elena', 'Castro', 'elena_mix', 'hash_pw_10', 'elena@example.com',
 'user.jpg', '1993-06-25', '+51 900000010', '2025-09-10 07:55:00', 1,
 '2025-11-09 10:05:00', NULL, NULL, NULL);

--Insertar playlists
INSERT INTO playlists (
  id, user_id, name, description, cover_image,
  is_public, save_in, created_at
) VALUES
(1, 1, 'Daily Mix Pop', 'Selección diaria de pop y hits suaves.', '/covers/pl_daily_mix_pop.jpg', 1, 0, '2025-10-01 09:00:00'),
(2, 1, 'Focus Lo-Fi', 'Playlist para estudiar y concentrarse.', '/covers/pl_focus_lofi.jpg', 1, 0, '2025-10-02 14:30:00'),
(3, 2, 'Workout Hits', 'Música enérgica para entrenar.', '/covers/pl_workout_hits.jpg', 1, 0, '2025-09-20 07:00:00'),
(4, 3, 'Night Coding', 'Pistas electrónicas y lo-fi para programar.', '/covers/pl_night_coding.jpg', 0, 0, '2025-08-15 23:15:00'),
(5, 4, 'Románticas R&B', 'Baladas y R&B suave para relajarse.', '/covers/pl_romanticas_rnb.jpg', 1, 0, '2025-07-05 21:00:00'),
(6, 5, 'Rock Classics', 'Clásicos del rock alternativo y moderno.', '/covers/pl_rock_classics.jpg', 1, 0, '2025-06-10 16:45:00'),
(7, 6, 'Fiesta Reggaetón', 'Temas urbanos para encender la fiesta.', '/covers/pl_fiesta_reggaeton.jpg', 1, 0, '2025-05-27 22:10:00'),
(8, 7, 'Indie Descubrimientos', 'Nuevas bandas indie recomendadas.', '/covers/pl_indie_descubrimientos.jpg', 0, 0, '2025-04-03 18:30:00'),
(9, 8, 'K-Pop Favorites', 'Los mejores temas de K-Pop.', '/covers/pl_kpop_favorites.jpg', 1, 0, '2025-03-19 12:20:00'),
(10,9, 'Salsa para Bailar', 'Salsa clásica y moderna para bailar.', '/covers/pl_salsa_para_bailar.jpg', 1, 0, '2025-02-11 20:40:00');

--Tablas asociativas
--Insertar Albumes y canciones
INSERT INTO album_song (id, album_id, song_id) VALUES
(1, 1, 1),  -- Noches de Ciudad      - Midnight City Lights
(2, 1, 2),  -- Noches de Ciudad      - Lluvia de Neón
(3, 2, 3),  -- Aurora Lo-Fi          - Horizonte Lo-Fi
(4, 2, 5),  -- Aurora Lo-Fi          - Aurora Digital
(5, 4, 6),  -- Ecos del Ande         - Ecos del Ande
(6, 5, 4),  -- Sueños de Verano      - Ritmo en la Calle
(7, 5, 7),  -- Sueños de Verano      - Sueños de Verano
(8, 7, 8),  -- Galaxy Beat (álbum)   - Sabor a Medianoche
(9, 7, 9),  -- Galaxy Beat (álbum)   - Galaxy Beat
(10,10,10); -- Minimal Nights        - Silencio Urbano
-- Canciones repetidas en otros álbumes (compilados / especiales)
INSERT INTO album_song (id, album_id, song_id) VALUES
(11,8, 2),  -- Rock Classics Vol.1   - Lluvia de Neón
(12,8, 4),  -- Rock Classics Vol.1   - Ritmo en la Calle
(13,9, 4),  -- Fiesta Urbana         - Ritmo en la Calle
(14,9, 8);  -- Fiesta Urbana         - Sabor a Medianoche

--Insertar songs-artists
INSERT INTO song_artist (id, song_id, artist_id) VALUES
(1, 1, 1),  -- Midnight City Lights   - Luna Nova
(2, 2, 1),  -- Lluvia de Neón         - Luna Nova
(3, 3, 4),  -- Horizonte Lo-Fi        - DJ Aurora
(4, 4, 3),  -- Ritmo en la Calle      - Urban Flow
(5, 5, 4),  -- Aurora Digital         - DJ Aurora
(6, 6, 7),  -- Ecos del Ande          - Andes Indie
(7, 7, 1),  -- Sueños de Verano       - Luna Nova
(8, 8, 8),  -- Sabor a Medianoche     - Sabor Caribe
(9, 9, 9),  -- Galaxy Beat            - Galaxy Kids
(10,10,3),  -- Silencio Urbano        - Urban Flow
-- Colaboraciones / feats entre artistas
(11,4,5),   -- Ritmo en la Calle      + Ritmo Callejero
(12,8,5),   -- Sabor a Medianoche     + Ritmo Callejero
(13,9,4);   -- Galaxy Beat            + DJ Aurora

--Insertar canciones y generos
INSERT INTO song_genre (id, song_id, genre_id) VALUES
(1, 1, 1),  -- Midnight City Lights   - Pop
(2, 1, 4),  --                        - Electrónica
(3, 2, 1),  -- Lluvia de Neón         - Pop
(4, 2, 8),  --                        - Alternativo
(5, 3, 4),  -- Horizonte Lo-Fi        - Electrónica
(6, 3, 5),  --                        - Jazz
(7, 4, 3),  -- Ritmo en la Calle      - Hip Hop
(8, 4, 7),  --                        - Reggaeton
(9, 4, 9),  --                        - Trap
(10,5, 4),  -- Aurora Digital         - Electrónica
(11,6, 8),  -- Ecos del Ande          - Alternativo
(12,7, 1),  -- Sueños de Verano       - Pop
(13,8, 5),  -- Sabor a Medianoche     - Jazz
(14,9, 1),  -- Galaxy Beat            - Pop
(15,9, 4),  --                        - Electrónica
(16,10,3),  -- Silencio Urbano        - Hip Hop
(17,10,9);  --                        - Trap

-- Insertar playlists y usuarios
INSERT INTO playlist_user (id, playlist_id, user_id) VALUES
-- Dueños (coinciden con playlists.user_id)
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 3),
(5, 5, 4),
(6, 6, 5),
(7, 7, 6),
(8, 8, 7),
(9, 9, 8),
(10,10,9),
-- Colaboradores extra
(11,1,2),
(12,1,3),
(13,2,4),
(14,3,1),
(15,4,6),
(16,5,6),
(17,7,1),
(18,8,3),
(19,9,10),
(20,10,8);

--Insertar playlists y canciones
INSERT INTO playlist_song (id, playlist_id, song_id, added_at, "order") VALUES
-- 1: Daily Mix Pop
(1, 1, 1, '2025-10-01 09:05:00', 1),
(2, 1, 2, '2025-10-01 09:06:00', 2),
(3, 1, 7, '2025-10-01 09:07:00', 3),

-- 2: Focus Lo-Fi
(4, 2, 3, '2025-10-02 14:31:00', 1),
(5, 2, 5, '2025-10-02 14:32:00', 2),
(6, 2, 10,'2025-10-02 14:33:00', 3),

-- 3: Workout Hits
(7, 3, 4, '2025-09-20 07:01:00', 1),
(8, 3, 9, '2025-09-20 07:02:00', 2),
(9, 3, 1, '2025-09-20 07:03:00', 3),

-- 4: Night Coding
(10,4, 3, '2025-08-15 23:16:00', 1),
(11,4, 5, '2025-08-15 23:17:00', 2),
(12,4, 1, '2025-08-15 23:18:00', 3),

-- 5: Románticas R&B
(13,5, 7, '2025-07-05 21:01:00', 1),
(14,5, 1, '2025-07-05 21:02:00', 2),
(15,5, 2, '2025-07-05 21:03:00', 3),

-- 6: Rock Classics
(16,6, 4, '2025-06-10 16:46:00', 1),
(17,6,10, '2025-06-10 16:47:00', 2),
(18,6, 2, '2025-06-10 16:48:00', 3),

-- 7: Fiesta Reggaetón
(19,7, 4, '2025-05-27 22:11:00', 1),
(20,7, 8, '2025-05-27 22:12:00', 2),
(21,7, 9, '2025-05-27 22:13:00', 3),

-- 8: Indie Descubrimientos
(22,8, 6, '2025-04-03 18:31:00', 1),
(23,8, 7, '2025-04-03 18:32:00', 2),
(24,8, 3, '2025-04-03 18:33:00', 3),

-- 9: K-Pop Favorites
(25,9, 9, '2025-03-19 12:21:00', 1),
(26,9, 1, '2025-03-19 12:22:00', 2),
(27,9, 2, '2025-03-19 12:23:00', 3),

-- 10: Salsa para Bailar
(28,10,8, '2025-02-11 20:41:00', 1),
(29,10,4, '2025-02-11 20:42:00', 2),
(30,10,6, '2025-02-11 20:43:00', 3);

--Insertar playlists y los likes realizados
INSERT INTO playlist_likes (id, user_id, playlist_id, created_at) VALUES
-- Likes a Daily Mix Pop (playlist 1)
(1,  1, 1, '2025-10-01 09:10:00'),  -- el propio dueño
(2,  2, 1, '2025-10-01 10:00:00'),
(3,  3, 1, '2025-10-01 11:30:00'),
(4,  4, 1, '2025-10-01 12:15:00'),

-- Likes a Focus Lo-Fi (playlist 2)
(5,  1, 2, '2025-10-02 15:00:00'),
(6,  3, 2, '2025-10-02 15:10:00'),
(7,  6, 2, '2025-10-02 16:20:00'),

-- Likes a Workout Hits (playlist 3)
(8,  2, 3, '2025-09-20 07:30:00'),  -- dueño
(9,  1, 3, '2025-09-20 08:00:00'),
(10, 5, 3, '2025-09-20 09:15:00'),

-- Likes a Night Coding (playlist 4)
(11, 3, 4, '2025-08-15 23:30:00'),  -- dueño
(12, 1, 4, '2025-08-16 00:10:00'),
(13, 6, 4, '2025-08-16 01:05:00'),

-- Likes a Románticas R&B (playlist 5)
(14, 4, 5, '2025-07-05 21:30:00'),  -- dueña
(15, 6, 5, '2025-07-05 22:00:00'),
(16, 10,5, '2025-07-06 09:45:00'),

-- Likes a Rock Classics (playlist 6)
(17, 5, 6, '2025-06-10 17:00:00'),  -- dueño
(18, 2, 6, '2025-06-10 17:20:00'),
(19, 7, 6, '2025-06-11 10:10:00'),

-- Likes a Fiesta Reggaetón (playlist 7)
(20, 6, 7, '2025-05-27 22:30:00'),  -- dueña
(21, 1, 7, '2025-05-27 23:00:00'),
(22, 5, 7, '2025-05-28 00:15:00'),
(23, 8, 7, '2025-05-28 09:00:00'),

-- Likes a Indie Descubrimientos (playlist 8)
(24, 7, 8, '2025-04-03 18:40:00'),  -- dueño
(25, 3, 8, '2025-04-03 19:10:00'),

-- Likes a K-Pop Favorites (playlist 9)
(26, 8, 9, '2025-03-19 12:30:00'),  -- dueña
(27, 1, 9, '2025-03-19 13:00:00'),
(28, 9, 9, '2025-03-19 14:20:00'),

-- Likes a Salsa para Bailar (playlist 10)
(29, 9, 10, '2025-02-11 20:50:00'), -- dueño
(30, 4, 10, '2025-02-11 21:10:00'),
(31, 2, 10, '2025-02-12 09:25:00');