-- Actualizar URLs de imágenes con URLs reales
-- Este archivo actualiza todas las imágenes para que tengan URLs válidas

-- Actualizar imágenes de artistas
UPDATE artists SET profile_image = 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop&crop=face' WHERE id = 1;  -- Luna Nova (cantautora pop)
UPDATE artists SET profile_image = 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop' WHERE id = 2;  -- Midnight Waves (banda rock)
UPDATE artists SET profile_image = 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300&h=300&fit=crop' WHERE id = 3;  -- Urban Flow (hip hop)
UPDATE artists SET profile_image = 'https://images.unsplash.com/photo-1534258936925-c58bed479fcb?w=300&h=300&fit=crop&crop=face' WHERE id = 4;  -- DJ Aurora (electrónica)
UPDATE artists SET profile_image = 'https://images.unsplash.com/photo-1516280440614-37939bbacd81?w=300&h=300&fit=crop' WHERE id = 5;  -- Ritmo Callejero (reggaetón)
UPDATE artists SET profile_image = 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300&h=300&fit=crop&crop=face' WHERE id = 6;  -- Soul Lights (R&B)
UPDATE artists SET profile_image = 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop&crop=face' WHERE id = 7;  -- Andes Indie (indie)
UPDATE artists SET profile_image = 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop&crop=face' WHERE id = 8;  -- Sabor Caribe (salsa)
UPDATE artists SET profile_image = 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=300&h=300&fit=crop' WHERE id = 9;  -- Galaxy Kids (K-Pop)
UPDATE artists SET profile_image = 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=300&h=300&fit=crop&crop=face' WHERE id = 10; -- Echo Minimal (ambient)

-- Actualizar imágenes de álbumes
UPDATE albums SET cover_image = 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=400&h=400&fit=crop' WHERE id = 1;  -- Noches de Ciudad
UPDATE albums SET cover_image = 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=400&fit=crop' WHERE id = 2;  -- Aurora Lo-Fi
UPDATE albums SET cover_image = 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=400&fit=crop' WHERE id = 3;  -- Ritmo en la Calle
UPDATE albums SET cover_image = 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=400&fit=crop' WHERE id = 4;  -- Ecos del Ande
UPDATE albums SET cover_image = 'https://images.unsplash.com/photo-1501594907352-04cda38ebc29?w=400&h=400&fit=crop' WHERE id = 5;  -- Sueños de Verano
UPDATE albums SET cover_image = 'https://images.unsplash.com/photo-1516280440614-37939bbacd81?w=400&h=400&fit=crop' WHERE id = 6;  -- Sabor a Medianoche
UPDATE albums SET cover_image = 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400&h=400&fit=crop' WHERE id = 7;  -- Galaxy Beat
UPDATE albums SET cover_image = 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=400&fit=crop' WHERE id = 8;  -- Rock Classics Vol. 1
UPDATE albums SET cover_image = 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400&h=400&fit=crop' WHERE id = 9;  -- Fiesta Urbana
UPDATE albums SET cover_image = 'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=400&h=400&fit=crop' WHERE id = 10; -- Minimal Nights

-- Actualizar imágenes de playlists
UPDATE playlists SET cover_image = 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=400&fit=crop' WHERE id = 1;  -- Daily Mix Pop
UPDATE playlists SET cover_image = 'https://images.unsplash.com/photo-1507838153414-b4b713384a76?w=400&h=400&fit=crop' WHERE id = 2;  -- Focus Lo-Fi
UPDATE playlists SET cover_image = 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=400&fit=crop' WHERE id = 3;  -- Workout Hits
UPDATE playlists SET cover_image = 'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=400&h=400&fit=crop' WHERE id = 4;  -- Night Coding
UPDATE playlists SET cover_image = 'https://images.unsplash.com/photo-1516280440614-37939bbacd81?w=400&h=400&fit=crop' WHERE id = 5;  -- Románticas R&B
UPDATE playlists SET cover_image = 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=400&h=400&fit=crop' WHERE id = 6;  -- Rock Classics
UPDATE playlists SET cover_image = 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=400&h=400&fit=crop' WHERE id = 7;  -- Fiesta Reggaetón
UPDATE playlists SET cover_image = 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400&h=400&fit=crop' WHERE id = 8;  -- Indie Descubrimientos
UPDATE playlists SET cover_image = 'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?w=400&h=400&fit=crop' WHERE id = 9;  -- K-Pop Favorites
UPDATE playlists SET cover_image = 'https://images.unsplash.com/photo-1516280440614-37939bbacd81?w=400&h=400&fit=crop' WHERE id = 10; -- Salsa para Bailar

-- Actualizar imágenes de perfil de usuarios
UPDATE users SET profile_image = 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop&crop=face' WHERE id = 1;  -- user
UPDATE users SET profile_image = 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop&crop=face' WHERE id = 2;  -- Carla
UPDATE users SET profile_image = 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop&crop=face' WHERE id = 3;  -- Jorge
UPDATE users SET profile_image = 'https://images.unsplash.com/photo-1534258936925-c58bed479fcb?w=300&h=300&fit=crop&crop=face' WHERE id = 4;  -- Lucía
UPDATE users SET profile_image = 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300&h=300&fit=crop&crop=face' WHERE id = 5;  -- Diego
UPDATE users SET profile_image = 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop&crop=face' WHERE id = 6;  -- María
UPDATE users SET profile_image = 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=300&h=300&fit=crop&crop=face' WHERE id = 7;  -- Sergio
UPDATE users SET profile_image = 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=300&h=300&fit=crop&crop=face' WHERE id = 8;  -- Ana
UPDATE users SET profile_image = 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop&crop=face' WHERE id = 9;  -- Pedro
UPDATE users SET profile_image = 'https://images.unsplash.com/photo-1534258936925-c58bed479fcb?w=300&h=300&fit=crop&crop=face' WHERE id = 10; -- Elena