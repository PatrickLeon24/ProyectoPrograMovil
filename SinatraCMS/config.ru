require_relative 'controllers/application_controller'
require_relative 'controllers/book_controller'
require_relative 'controllers/user_controller'
require_relative 'controllers/session_controller'
require_relative 'controllers/registro_controller'
require_relative 'controllers/genre_controller'
require_relative 'controllers/artist_controller'
require_relative 'controllers/song_controller'
require_relative 'controllers/album_controller'
require_relative 'controllers/playlist_controller'
require_relative 'controllers/editarusuario_controller'
require_relative 'controllers/password_controller'

# Recuperación de contraseña (los 3 endpoints)
require_relative 'controllers/forgot_controller'
require_relative 'controllers/verify-code_controller'
require_relative 'controllers/reset_controller'

# Registrar los nuevos controllers
use PasswordRecoveryRequestController
use PasswordRecoveryVerifyController
use PasswordRecoveryResetController

use BookController
use UserController
use SessionController
use RegistrationController
use GenreController
use ArtistController
use SongController
use AlbumController
use PlaylistController
use EditUserController
use PasswordController

run ApplicationController