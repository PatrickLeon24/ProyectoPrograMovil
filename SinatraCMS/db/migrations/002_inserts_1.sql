-- Insertar publishers
INSERT INTO publishers (id, name, logo) VALUES
(3, 'Editorial Sudamericana', 'sudamericana_logo.png'),
(4, 'Editorial Planeta', 'planeta_logo.png'),
(5, 'Debolsillo', 'debolsillo_logo.png'),
(6, 'Editorial Losada', 'losada_logo.png'),
(7, 'Salamandra', 'salamandra_logo.png'),
(8, 'Umbriel', 'umbriel_logo.png'),
(9, 'Alfaguara', 'alfaguara_logo.png'),
(10, 'DeBolsillo', 'debolsillo_logo.png');

-- Insertar autores
INSERT INTO authors (id, full_name, birth_date, image) VALUES
(1, 'Gabriel García Márquez', '1927-03-06', 'gabriel_garcia_marquez.jpg'),
(2, 'Isabel Allende', '1942-08-02', 'isabel_allende_portrait.jpg'),
(4, 'J.K. Rowling', '1965-07-31', 'jk_rowling_author.jpg'),
(5, 'George Orwell', '1903-06-25', 'george_orwell.jpg'),
(6, 'Pablo Neruda', '1904-07-12', 'pablo_neruda.jpg'),
(7, 'Dan Brown', '1964-06-22', 'dan_brown.jpg'),
(8, 'Julio Cortázar', '1914-08-26', 'cortazar.jpg'),
(9, 'Ken Follett', '1949-06-05', 'ken_follett.jpg'),
(10, 'Carlos Ruiz Zafón', '1964-09-25', 'ruiz_zafon.jpg');

-- Insertar géneros
INSERT INTO genres (id, name) VALUES
(1, 'Realismo Mágico'),
(2, 'Ficción Literaria'),
(3, 'Novela'),
(4, 'Ciencia Ficción'),
(5, 'Fantasía'),
(6, 'Misterio'),
(7, 'Romance'),
(8, 'Thriller'),
(10, 'Histórica'),
(11, 'Poesía'),
(12, 'Aventura'),
(13, 'Experimental');

-- Insertar libros
INSERT INTO books (id, title, isbn, pages, publication_year, edition_year, synopsis, cover_image, pdf, publisher_id) VALUES
(1, 'Cien años de soledad', '978-84-376-0494-7', 471, 1967, 2020, 'La novela narra la historia de la familia Buendía a lo largo de siete generaciones en el pueblo ficticio de Macondo.', 'images/book1.png', 'cien_anos_soledad.pdf', 3),
(2, '1984', '978-84-9759-327-5', 326, 1949, 2019, 'Una distopía que presenta un estado totalitario que controla cada aspecto de la vida de los ciudadanos.', 'images/book2.png', '1984.pdf', 5),
(3, 'Cien sonetos de amor', '978-84-8365-383-7', 128, 1959, 2018, 'Colección de sonetos que expresan el amor más profundo y apasionado del poeta chileno.', 'images/book3.png', 'cien_sonetos.pdf', 6),
(4, 'Harry Potter y la piedra filosofal', '978-84-9838-465-7', 320, 1997, 2021, 'El primer libro de la saga del joven mago Harry Potter y sus aventuras en Hogwarts.', 'images/book4.png', 'harry_potter.pdf', 7),
(5, 'La casa de los espíritus', '978-84-204-8301-3', 432, 1982, 2020, 'Novela que narra la saga de la familia Trueba a lo largo de cuatro generaciones.', 'images/book5.png', 'casa_espiritus.pdf', 4),
(6, 'El código Da Vinci', '978-84-9759-748-8', 656, 2003, 2019, 'Thriller que mezcla misterio, conspiración y arte en una trepidante búsqueda del Santo Grial.', 'images/book6.png', 'codigo_davinci.pdf', 8),
(7, 'Rayuela', '978-84-339-0092-6', 736, 1963, 2017, 'Novela innovadora que puede leerse de forma lineal o siguiendo un tablero de dirección.', 'images/book7.png', 'rayuela.pdf', 9),
(8, 'Los pilares de la Tierra', '978-84-9759-882-9', 1056, 1989, 2020, 'Epica novela histórica sobre la construcción de una catedral en la Inglaterra medieval.', 'images/book8.png', 'pilares_tierra.pdf', 10),
(9, 'El amor en los tiempos del cólera', '978-84-397-2071-5', 464, 1985, 2018, 'Historia de amor que se desarrolla a lo largo de más de cincuenta años.', 'images/book9.png', 'amor_colera.pdf', 3),
(10, 'La sombra del viento', '978-84-204-8302-0', 576, 2001, 2019, 'Misterio literario ambientado en la Barcelona de posguerra.', 'images/book10.png', 'sombra_viento.pdf', 4);

-- Insertar relaciones libros-autores
INSERT INTO books_authors (book_id, author_id) VALUES
(1, 1),
(2, 5),
(3, 6),
(4, 4),
(5, 2),
(6, 7),
(7, 8),
(8, 9),
(9, 1),
(10, 10);

-- Insertar relaciones libros-géneros
INSERT INTO books_genres (book_id, genre_id) VALUES
-- Cien años de soledad
(1, 1), (1, 3),
-- 1984
(2, 4), (2, 8),
-- Cien sonetos de amor
(3, 11), (3, 7),
-- Harry Potter
(4, 5), (4, 12),
-- La casa de los espíritus
(5, 1), (5, 10),
-- El código Da Vinci
(6, 6), (6, 8),
-- Rayuela
(7, 2), (7, 13),
-- Los pilares de la Tierra
(8, 10), (8, 3),
-- El amor en los tiempos del cólera
(9, 3), (9, 7),
-- La sombra del viento
(10, 6), (10, 10);

-- Insertar algunas reseñas de ejemplo (opcional)
INSERT INTO reviews (rating, comment, user_id, book_id) VALUES
(5, 'Una obra maestra de la literatura latinoamericana', 1, 1),
(4, 'Inquietante y visionaria', 1, 2),
(5, 'Poesía que llega al alma', 1, 3),
(3, 'Buena historia para jóvenes', 1, 4),
(2, 'No cumplió mis expectativas', 1, 5),
(1, 'Muy decepcionante', 1, 6),
(5, 'Innovadora y fascinante', 1, 7),
(5, 'Epica e inolvidable', 1, 8),
(5, 'Amor que trasciende el tiempo', 1, 9),
(4, 'Misterio muy bien construido', 1, 10);