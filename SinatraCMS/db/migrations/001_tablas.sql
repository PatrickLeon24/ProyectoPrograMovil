-- Tabla de países
CREATE TABLE countries (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(30) NOT NULL,
    male_demonym VARCHAR(40),
    female_demonym VARCHAR(40),
    flag_image VARCHAR(100)
);

-- Tabla de usuarios
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(30) NOT NULL UNIQUE,
    password VARCHAR(40) NOT NULL,
    first_names VARCHAR(50) NOT NULL,
    last_names VARCHAR(50) NOT NULL,
    email VARCHAR(30) NOT NULL,
    birth_date DATE,
    profile_picture VARCHAR(100),
    sex BOOLEAN,
    reset_key VARCHAR(30),
    country_id INTEGER NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries(id)
);

-- Tabla de dispositivos
CREATE TABLE devices (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    brand VARCHAR(30),
    type VARCHAR(30),
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Tabla de editoriales
CREATE TABLE publishers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(50),
    logo VARCHAR(100)
);

-- Tabla de libros
CREATE TABLE books (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(60) NOT NULL,
    isbn VARCHAR(30),
    pages INTEGER,
    publication_year INTEGER,
    edition_year INTEGER,
    synopsis TEXT,
    cover_image VARCHAR(100),
    pdf VARCHAR(100),
    publisher_id INTEGER,
    FOREIGN KEY (publisher_id) REFERENCES publishers(id)
);

-- Tabla de autores
CREATE TABLE authors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name VARCHAR(60) NOT NULL,
    birth_date DATE,
    image VARCHAR(100)
);

-- Tabla de géneros
CREATE TABLE genres (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(30) NOT NULL
);

-- Tabla de reseñas
CREATE TABLE reviews (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    rating INTEGER NOT NULL,
    comment TEXT,
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    user_id INTEGER NOT NULL,
    book_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (book_id) REFERENCES books(id)
);

-- Tabla de relación libros-autores (muchos a muchos)
CREATE TABLE books_authors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (author_id) REFERENCES authors(id),
    UNIQUE(book_id, author_id)
);

-- Tabla de relación libros-géneros (muchos a muchos)
CREATE TABLE books_genres (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    book_id INTEGER NOT NULL,
    genre_id INTEGER NOT NULL,
    FOREIGN KEY (book_id) REFERENCES books(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    UNIQUE(book_id, genre_id)
);
