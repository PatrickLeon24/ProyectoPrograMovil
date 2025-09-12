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
    
    Crear proyecto con flutter: 
    flutter create waveul



## Requerimientos Funcionales

A continuación, se detallan los **requerimientos funcionales** de WaveUl, alineados con los casos de uso:  

### 1. Autenticación y Perfil  
- **RF-01**: El sistema debe permitir registrar una cuenta con email o autenticación mediante Google OAuth.  
- **RF-02**: El sistema debe validar credenciales y emitir un token JWT para la sesión.  
- **RF-03**: El sistema debe permitir la recuperación de contraseña mediante token enviado por correo (Gmail SMTP).  
- **RF-04**: El sistema debe permitir editar datos de perfil (nombre, foto, descripción, privacidad).  

### 2. Exploración y Descubrimiento  
- **RF-05**: El sistema debe mostrar un catálogo general de canciones, álbumes, playlists, artistas y géneros.  
- **RF-06**: El sistema debe permitir búsquedas avanzadas por nombre, artista, álbum o género.  
- **RF-07**: El sistema debe mostrar la discografía de un artista en su perfil.  
- **RF-08**: El sistema debe clasificar las canciones según género.  
- **RF-09**: El sistema debe mostrar playlists destacadas y públicas.  
- **RF-10**: El sistema debe permitir visitar perfiles de otros usuarios.  

### 3. Reproducción e Interacción  
- **RF-11**: El sistema debe permitir reproducir canciones con controles de play/pause, skip, repeat y volumen.  
- **RF-12**: El sistema debe permitir gestionar playlists (crear, editar, eliminar, compartir).  
- **RF-13**: El sistema debe permitir dar “me gusta” a canciones y reseñas.  
- **RF-14**: El sistema debe permitir a los usuarios crear reseñas con calificación y comentarios.  
- **RF-15**: El sistema debe mostrar las reseñas de cada canción.  
- **RF-16**: El sistema debe permitir seguir a artistas y usuarios.  
- **RF-17**: El sistema debe permitir reportar canciones, usuarios, playlists o reseñas.  

### 4. Biblioteca Personal  
- **RF-18**: El sistema debe registrar y mostrar el historial de canciones reproducidas.  
- **RF-19**: El sistema debe mostrar las canciones marcadas como favoritas.  
- **RF-20**: El sistema debe mostrar y permitir gestionar playlists creadas por el usuario.  
- **RF-21**: El sistema debe generar recomendaciones basadas en hábitos de escucha.  

### 5. Panel del Artista  
- **RF-22**: El sistema debe permitir a los artistas editar su perfil artístico (biografía, imágenes, redes sociales).  
- **RF-23**: El sistema debe permitir a los artistas subir nuevas canciones.  
- **RF-24**: El sistema debe permitir gestionar álbumes (crear, editar, eliminar).  
- **RF-25**: El sistema debe mostrar estadísticas de reproducciones, seguidores y demografía.  

### 6. Panel de Administración  
- **RF-26**: El sistema debe permitir a administradores gestionar usuarios (suspender, activar, eliminar).  
- **RF-27**: El sistema debe permitir gestionar el catálogo musical (canciones, álbumes, artistas).  
- **RF-28**: El sistema debe permitir moderar reseñas.  
- **RF-29**: El sistema debe permitir gestionar géneros musicales.  
- **RF-30**: El sistema debe mostrar un listado de reportes para revisión.  

---

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


## Casos de Uso - WaveUl

El sistema WaveUl se organiza en torno a tres tipos de actores principales:

- **Usuario** : oyente de música que explora, reproduce e interactúa con canciones, playlists y artistas.  
- **Artista** : creador de contenido musical, con acceso a herramientas para gestionar su perfil artístico, canciones y estadísticas.  
- **Administrador** : encargado de la moderación, gestión de usuarios y control del catálogo musical.  

![Casos de Uso](Docs/images/UseCases.png)  
**Figura 3: Diagrama de Casos de Uso de WaveUl**

---

###  Autenticación y Perfil
- **Registrar cuenta (UC1)**: permite a nuevos usuarios crear un perfil en la app.  
- **Iniciar sesión (UC2)**: acceso de usuarios, artistas y administradores a sus respectivos paneles.  
- **Recuperar contraseña (UC3)**: recuperación mediante correo/token de verificación.  
- **Gestionar perfil (UC4)**: actualización de información personal, foto de perfil y ajustes de seguridad.  

---

###  Exploración y Descubrimiento
- **Explorar canciones (UC5)**: navegar por el catálogo general.  
- **Buscar música (UC6)**: búsqueda avanzada por nombre, género, artista o álbum.  
- **Explorar artistas (UC7)**: consulta de perfiles artísticos y discografía.  
- **Explorar géneros (UC8)**: descubrimiento de música organizada por categorías musicales.  
- **Explorar álbumes (UC9)**: visualización de discos publicados por artistas.  
- **Explorar playlists (UC27)**: acceso a playlists públicas y destacadas.  
- **Explorar perfiles (UC28)**: posibilidad de visitar perfiles de otros usuarios.  

---

###  Reproducción e Interacción
- **Reproducir canciones (UC10)**: incluye controles de play/pause, skip, volumen, repeat y añadir a playlists.  
- **Gestionar playlists (UC11)**: crear, editar, eliminar, compartir y organizar playlists.  
- **Dar like/me gusta (UC12)**: marcar canciones o reseñas como favoritas.  
- **Crear reseñas (UC13)**: permitir a los usuarios opinar y valorar canciones.  
- **Ver reseñas (UC31)**: lectura de comentarios y puntuaciones de la comunidad.  
- **Seguir artistas/usuarios (UC14)**: suscripción a contenido de interés.  
- **Reportar/Ocultar contenido (UC29)**: denunciar o bloquear canciones, usuarios, reseñas o playlists.  

---

###  Biblioteca Personal
- **Ver historial de reproducción (UC15)**: acceso al registro de canciones escuchadas.  
- **Ver canciones favoritas (UC16)**: listado de temas marcados con “me gusta”.  
- **Ver playlists creadas (UC17)**: gestión de playlists propias.  
- **Ver nuevas recomendaciones (UC30)**: sugerencias personalizadas basadas en hábitos de escucha.  

---

###  Panel del Artista
- **Gestionar perfil artístico (UC18)**: edición de biografía, imágenes, redes sociales y datos de la banda/solista.  
- **Subir canciones (UC19)**: carga de pistas nuevas al catálogo.  
- **Gestionar álbumes (UC20)**: creación y edición de álbumes.  
- **Ver estadísticas (UC21)**: análisis de reproducciones, seguidores, demografía y tendencias.  

---

###  Panel de Administración
- **Gestionar usuarios (UC22)**: alta, baja o suspensión de cuentas.  
- **Gestionar contenido (UC23)**: control sobre canciones, álbumes y artistas cargados.  
- **Moderar reseñas (UC24)**: validación y moderación de opiniones de la comunidad.  
- **Gestionar géneros (UC25)**: administración de categorías musicales.  
- **Ver reportes (UC26)**: análisis y seguimiento de contenido denunciado.  

---



# Requerimientos No Funcionales - WaveUl

## Rendimiento y Escalabilidad
- **RNF1**: El sistema debe responder a las solicitudes API en un tiempo menor a **2 segundos** en condiciones normales de carga.  
- **RNF2**: La plataforma debe soportar al menos **500 usuarios concurrentes** en su versión inicial, con posibilidad de escalar horizontalmente.  
- **RNF3**: El backend debe ser capaz de manejar al menos **10.000 reproducciones diarias** sin degradación significativa del rendimiento.  

---

## Seguridad
- **RNF4**: Todo intercambio de datos entre cliente y servidor debe realizarse mediante **HTTPS**.  
- **RNF5**: El sistema debe manejar la autenticación usando **OAuth 2.0 (Google Sign-In)** y **tokens JWT** con expiración configurable.  
- **RNF6**: Los datos sensibles (contraseñas, correos, tokens) deben almacenarse usando técnicas de **hashing y encriptación**.  
- **RNF7**: Los reportes y logs deben registrar actividad de **moderadores y administradores** para trazabilidad.  

---

## Disponibilidad y Fiabilidad
- **RNF8**: El servicio de envío de correos (SMTP) debe tener una tasa de entrega mayor al **95%** para correos de verificación y recuperación.  
- **RNF9**: El backend debe garantizar al menos un **99% de disponibilidad mensual**.  
- **RNF10**: En caso de error en la base de datos, las operaciones críticas (registro, login, recuperación) deben reintentarse al menos **3 veces** antes de fallar.  

---

## Mantenibilidad y Escalabilidad Técnica
- **RNF11**: El backend debe estar **desacoplado (API REST)** para permitir integración futura con versiones web o de escritorio.  
- **RNF12**: El código debe seguir un estilo estándar (ej. **Rubocop para Ruby**) y estar documentado.  
- **RNF13**: El sistema debe permitir migrar de **SQLite3 a PostgreSQL/MySQL** sin cambios drásticos en la lógica.  

---

## Usabilidad
- **RNF14**: La app debe cargar la **pantalla inicial en menos de 3 segundos**.  
- **RNF15**: El flujo de autenticación debe requerir como máximo **3 pasos** (login, verificación, acceso).  
- **RNF16**: Los mensajes de error deben ser claros, indicando la acción a seguir (ejemplo: *“Correo no registrado, intente nuevamente”*).  

---

## Monitoreo y Logs
- **RNF17**: El sistema debe registrar **logs de errores, accesos y reproducciones**, con retención mínima de **90 días**.  
- **RNF18**: Los administradores deben poder consultar **reportes de actividad en tiempo real** (usuarios activos, canciones más reproducidas, reportes pendientes).
REportes: especificar bien como seria la relacion polimorfica
SUPERADMIN: usuarios comunes y artistas
Moderador : solo actividad de los usuarios 