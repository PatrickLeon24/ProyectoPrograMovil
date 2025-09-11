# App WaveUl

## Descripción

WaveUl es una aplicación móvil desarrollada en Flutter para Android que funciona como una plataforma de streaming musical integral, permitiendo a los usuarios explorar, escuchar y gestionar sus canciones y playlists favoritas online. La aplicación ofrece una experiencia personalizada donde los oyentes pueden mantener un perfil detallado, descubrir nuevos artistas y álbumes a través de un catálogo organizado por géneros, y valorar sus canciones con funciones de “me gusta” e historial de reproducciones. El caso de negocio se centra en democratizar el acceso a la música, proporcionando una plataforma centralizada y fácil de usar que fomente la interacción musical y sirva como puente entre artistas, productores y el público final.

El backend, construido con Ruby y el framework Sinatra, junto con una base de datos SQLite3, sirve como el núcleo robusto y eficiente que soporta todas las operaciones de la aplicación. Gestiona de forma ágil la autenticación de usuarios, las transacciones de datos de canciones, álbumes, artistas y playlists, además del procesamiento de estadísticas de reproducción. Este sistema está diseñado para ser escalable y de alto rendimiento, garantizando una experiencia fluida y responsiva para el usuario final, mientras que su simplicidad y bajo costo de operación se alinean con el objetivo de negocio de ofrecer un servicio sostenible y de calidad.

## Configuración del Ambiente de Desarrollo

1. Configuración del backend en Ruby

    Descargar Ruby Windows Installer del <a href="https://rubyinstaller.org/downloads/">Sitio Oficial</a> como se aprecia en la Imagen 1.
    ![Sitio Web de RWI](Docs/images/Imagen1.png)
    <b>Figura 1: Sitio Web de RWI</b>

    -Instalar Ruby y asegurarse de marcar la opción para instalar MSYS2.

    -Verificar la instalación con el siguiente comando: ruby -v
    ![comando1](Docs/images/Imagen2.png)
    -Instalar Sinatra y las dependencias necesarias:
    gem install sinatra sqlite3

2. Configuración del Entorno Flutter

    Descargar Flutter SDK desde el <a href="https://docs.flutter.dev/get-started/install">sitio oficial</a>.

    Extraer el SDK en una carpeta de fácil acceso (ejemplo: C:\src\flutter).

    Configurar la variable de entorno PATH agregando la ruta a la carpeta flutter\bin.

    Verificar la instalación ejecutando:
    ![comando1](Docs/images/Imagen3.png)


## 🗄️ Modelo Relacional (ERD)

A continuación, se presenta el modelo relacional de **WaveUl**, que organiza la información en torno a usuarios, artistas, canciones, playlists y sus interacciones.  

![Modelo Relacional](Docs/images/ERD.png)  
<b>Figura 2: Modelo Relacional de WaveUl</b>  

### 🔹 Entidades Principales  
- **users** 🧑: Información de los usuarios (perfil, autenticación, verificación, actividad).  
- **artists** 🎤: Solistas o bandas, con nombre artístico, biografía e imagen.  
- **albums** 💿: Agrupaciones de canciones publicadas por artistas.  
- **songs** 🎶: Pistas musicales con duración, archivo y metadatos.  
- **genres** 🎼: Clasificación de canciones por género.  
- **playlists** 📂: Listas de reproducción creadas por usuarios, públicas o privadas.  
- **reviews** ⭐: Opiniones y valoraciones de canciones.  
- **follows** 👥: Permite seguir tanto a artistas como a otros usuarios.  

### 🔹 Entidades de Relación  
- **album_song**: Relación entre álbumes y canciones (recopilatorios).  
- **song_genre**: Relación entre canciones y géneros.  
- **song_artist**: Relación entre canciones y artistas (colaboraciones).  
- **user_song**: Registro de interacciones usuario–canción (reproducciones, favoritos).  
- **playlist_song**: Canciones dentro de una playlist, con orden y fecha de adición.  
- **playlist_user**: Relación de colaboración en playlists compartidas.


## Descripción de Casos de Uso - WaveUl