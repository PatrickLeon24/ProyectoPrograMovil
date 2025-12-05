-- Actualizar URLs de imágenes de artistas con URLs reales
UPDATE artists SET profile_image = CASE 
    WHEN id = 1 THEN 'https://images.unsplash.com/photo-1494790108755-2616c6b6e1d0?w=300&h=300&fit=crop&crop=face'  -- Luna Nova (mujer cantante)
    WHEN id = 2 THEN 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop'  -- Midnight Waves (banda rock)
    WHEN id = 3 THEN 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300&h=300&fit=crop&crop=face'  -- Urban Flow (hip hop)
    WHEN id = 4 THEN 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=300&h=300&fit=crop&crop=face'  -- DJ Aurora (mujer DJ)
    WHEN id = 5 THEN 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=300&h=300&fit=crop&crop=face'  -- Ritmo Callejero (reggaeton)
    WHEN id = 6 THEN 'https://images.unsplash.com/photo-1531259736756-6caccf485f81?w=300&h=300&fit=crop'  -- Soul Lights (R&B banda)
    WHEN id = 7 THEN 'https://images.unsplash.com/photo-1520637836862-4d197d17c89a?w=300&h=300&fit=crop'  -- Andes Indie (indie banda)
    WHEN id = 8 THEN 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop'  -- Sabor Caribe (salsa banda)
    WHEN id = 9 THEN 'https://images.unsplash.com/photo-1516280440614-37939bbacd81?w=300&h=300&fit=crop'  -- Galaxy Kids (K-Pop)
    WHEN id = 10 THEN 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=300&h=300&fit=crop&crop=face'  -- Echo Minimal (productor)
END;

-- Actualizar URLs de imágenes de álbumes con URLs reales
UPDATE albums SET cover_image = CASE 
    WHEN id = 1 THEN 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=300&h=300&fit=crop'  -- Noches de Ciudad
    WHEN id = 2 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=300&fit=crop'  -- Aurora Lo-Fi
    WHEN id = 3 THEN 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop'  -- Ritmo en la Calle
    WHEN id = 4 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=300&fit=crop'  -- Ecos del Ande
    WHEN id = 5 THEN 'https://images.unsplash.com/photo-1415201364774-f6f0bb35f28f?w=300&h=300&fit=crop'  -- Sueños de Verano
    WHEN id = 6 THEN 'https://images.unsplash.com/photo-1611532736597-de2d4265fba3?w=300&h=300&fit=crop'  -- Sabor a Medianoche
    WHEN id = 7 THEN 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop'  -- Galaxy Beat
    WHEN id = 8 THEN 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop'  -- Rock Classics Vol. 1
    WHEN id = 9 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=300&fit=crop'  -- Fiesta Urbana
    WHEN id = 10 THEN 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop'  -- Minimal Nights
END;

-- Actualizar URLs de imágenes de playlists con URLs reales
UPDATE playlists SET cover_image = CASE 
    WHEN id = 1 THEN 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop'  -- Daily Mix Pop
    WHEN id = 2 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=300&fit=crop'  -- Focus Lo-Fi
    WHEN id = 3 THEN 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=300&h=300&fit=crop'  -- Workout Hits
    WHEN id = 4 THEN 'https://images.unsplash.com/photo-1415201364774-f6f0bb35f28f?w=300&h=300&fit=crop'  -- Night Coding
    WHEN id = 5 THEN 'https://images.unsplash.com/photo-1611532736597-de2d4265fba3?w=300&h=300&fit=crop'  -- Románticas R&B
    WHEN id = 6 THEN 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop'  -- Rock Classics
    WHEN id = 7 THEN 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=300&h=300&fit=crop'  -- Fiesta Reggaetón
    WHEN id = 8 THEN 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=300&h=300&fit=crop'  -- Indie Descubrimientos
    WHEN id = 9 THEN 'https://images.unsplash.com/photo-1516280440614-37939bbacd81?w=300&h=300&fit=crop'  -- K-Pop Favorites
    WHEN id = 10 THEN 'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300&h=300&fit=crop'  -- Salsa para Bailar
END;