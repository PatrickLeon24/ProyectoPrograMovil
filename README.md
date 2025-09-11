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


## Modelo Relacional (ERD)

A continuación, se presenta el modelo relacional de **WaveUl**, que organiza la información en torno a usuarios, artistas, canciones, playlists y sus interacciones.  

![Modelo Relacional](Docs/images/ERD.png)  
<b>Figura 2: Modelo Relacional de WaveUl</b>  

### Entidades Principales  
- **users** : Información de usuarios (perfil, credenciales, verificación, actividad).  
- **admins** : Subtipo de usuario con roles de administración (ej. superadmin, moderador).  
- **artists** : Artistas solistas o bandas con nombre artístico, biografía, imagen y fecha de formación.  
- **albums** : Colecciones de canciones asociadas a artistas.  
- **songs** : Pistas musicales con duración, archivo, metadatos y fecha de lanzamiento.  
- **genres** : Clasificación musical de canciones por género.  
- **playlists** : Listas de reproducción creadas por usuarios, públicas o privadas.  
- **reviews** : Opiniones y valoraciones de canciones con calificación y comentarios.  
- **follows** : Permite seguir tanto a artistas como a otros usuarios.  
- **reports** : Registros de reportes de contenido inapropiado (canciones, playlists, reseñas). 

### Entidades de Relación  
- **album_song**: Relación N:M entre álbumes y canciones (soporta recopilatorios).  
- **song_genre**: Relación N:M entre canciones y géneros musicales.  
- **song_artist**: Relación N:M entre canciones y artistas (para colaboraciones y feats).  
- **user_song**: Registro de interacciones usuario–canción (reproducciones, favoritos, última vez escuchada).  
- **playlist_song**: Canciones dentro de una playlist, con orden y fecha de adición.  
- **playlist_user**: Relación de colaboración en playlists compartidas entre usuarios.  
- **review_likes**: Relación usuario–reseña que almacena likes en opiniones. 


## Descripción de Casos de Uso - WaveUl