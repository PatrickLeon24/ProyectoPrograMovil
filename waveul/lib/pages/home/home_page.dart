import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waveul/pages/home/home_controller.dart';
import 'package:waveul/components/song_item_card.dart';
import 'package:waveul/components/app_bar_wrapper.dart';
import 'package:waveul/components/playlist_item_card.dart';
import 'package:waveul/components/genre_card.dart';
import 'package:waveul/models/sample_data.dart';
import 'package:waveul/models/song.dart';
import 'package:waveul/models/album.dart';
import 'package:waveul/models/artist.dart';
import 'package:waveul/pages/music_player/player_page.dart';
import "package:waveul/pages/lista_reproduccion/playlist_page.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeController controller;
  final ScrollController _scrollController = ScrollController();
  Song? currentSong; // Canción actual reproduciéndose

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomeController());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Contenido principal scrolleable
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.only(
              bottom: 80,
            ), // Espacio para el player
            child: Column(
              children: [
                _buildHeader(),
                _buildFeaturedSection(),
                _buildSongsOfTheMoment(),
                _buildPlaylistsForYou(),
                _buildGenresToExplore(),
                _buildAlbumsToExplore(),
                _buildArtistsOfTheMoment(),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Player fijo en la parte inferior
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomPlayer()),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const SizedBox(width: 2),
          // Barra de búsqueda
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/explorar_genero'),
            icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
          ),
          const Spacer(),
          Image.asset(
            'assets/images/text1.png',
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.access_time_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
          // Botón de configuración
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/editar_perfil'),
            icon: Icon(Icons.settings, color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        32,
      ), // Más margen abajo para la imagen
      child: Stack(
        clipBehavior: Clip.none, // Permite que la imagen sobresalga
        children: [
          // Contenedor principal verde
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF4ECDC4),
                  Theme.of(context).colorScheme.surface,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Nuevo Álbum',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Happier Than\nEver',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Billie Eilish',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  // Espacio para la imagen que estará posicionada
                  const SizedBox(width: 100),
                ],
              ),
            ),
          ),
          // Imagen posicionada que sobresale
          Positioned(
            right: 20,
            bottom: 0,
            child: Container(
              width: 170,
              height: 170,
              child: Image.asset('assets/images/billie.png', fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSongsOfTheMoment() {
    return _buildSection(
      title: 'CANCIONES DEL MOMENTO',
      child: Obx(() {
        if (controller.isLoading.value) {
          return const SizedBox(
            height: 220,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (controller.errorMessage.isNotEmpty) {
          return SizedBox(
            height: 220,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 40),
                  const SizedBox(height: 8),
                  Text(controller.errorMessage.value),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => controller.refreshData(),
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          );
        }
        
        final songs = controller.popularSongsForUI;
        if (songs.isEmpty) {
          return const SizedBox(
            height: 220,
            child: Center(child: Text('No hay canciones disponibles')),
          );
        }
        
        return SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return SongItemCard(
                song: song,
                onTap: () {
                  print('Tocado: ${song.title} - ${song.artist}');
                  setState(() {
                    currentSong = song;
                  });
                  Get.to(
                    () => PlayerPage(song: song),
                    transition: Transition.downToUp,
                  );
                },
                onPlay: () {
                  setState(() {
                    currentSong = song;
                  });
                  Get.to(
                    () => PlayerPage(song: song),
                    transition: Transition.downToUp,
                  );
                },
                onFavorite: () {
                  print('Favorito toggled: ${song.title}');
                  // Aquí puedes agregar la lógica para manejar favoritos
                },
                initialFavorite: false, // Por ahora todos como no favoritos
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildPlaylistsForYou() {
    return _buildSection(
      title: 'Playlists Para Ti',
      child: Obx(() {
        if (controller.isLoadingPlaylists.value) {
          return const SizedBox(
            height: 140,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        
        final playlistsUI = controller.playlistsForUI;
        if (playlistsUI.isEmpty) {
          return const SizedBox(
            height: 140,
            child: Center(child: Text('No hay playlists disponibles')),
          );
        }
        
        return SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: playlistsUI.length,
            itemBuilder: (context, index) {
              final playlist = playlistsUI[index];

              return Container(
                width: 350,
                margin: const EdgeInsets.only(right: 16),
                child: PlaylistItemCard(
                  playlist: playlist,
                  onTap: () {
                    try {
                      Get.to(
                        () => PlaylistPage(
                          playlistName: playlist.name,
                          playlistImage: "assets/images/chill_playlist.jpg",
                          songs: controller.popularSongsForUI, // Usar canciones populares por ahora
                        ),
                      );
                    } catch (e, stackTrace) {
                      print('❌ Error al navegar a PlaylistPage: $e');
                      print('🧱 Stacktrace:\n$stackTrace');
                    }
                  },
                  onPlay: () {
                    print('Reproduciendo playlist: ${playlist.name}');
                    // Aquí puedes agregar lógica para reproducir la primera canción
                  },
                  onAdd: () {
                    print('Playlist agregada: ${playlist.name}');
                    // Aquí puedes agregar lógica para guardar/agregar playlist
                  },
                  isAdded: false,
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildGenresToExplore() {
    return _buildSection(
      title: 'Géneros Para Explorar',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio:
                160 / 135, // Proporción exacta: 160 ancho / 135 alto ≈ 1.18
          ),
          itemCount: SampleData.exploreGenres.length,
          itemBuilder: (context, index) {
            final genre = SampleData.exploreGenres[index];
            return GenreCard(
              genre: genre,
              onTap: () {
                // TODO: Navegar a la página del género
                print('Género seleccionado: ${genre.name}');
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildAlbumsToExplore() {
    return _buildSection(
      title: 'Álbumes Para Explorar',
      child: Obx(() {
        if (controller.isLoadingAlbums.value) {
          return const SizedBox(
            height: 180,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (controller.albums.isEmpty) {
          return const SizedBox(
            height: 180,
            child: Center(child: Text('No hay álbumes disponibles')),
          );
        }
        
        return SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.albums.length,
            itemBuilder: (context, index) {
              final album = controller.albums[index];
              return _buildAlbumCard(album);
            },
          ),
        );
      }),
    );
  }

  Widget _buildArtistsOfTheMoment() {
    return _buildSection(
      title: 'Artistas Del Momento',
      child: Obx(() {
        if (controller.isLoadingArtists.value) {
          return const SizedBox(
            height: 100,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        
        if (controller.artists.isEmpty) {
          return const SizedBox(
            height: 100,
            child: Center(child: Text('No hay artistas disponibles')),
          );
        }
        
        return SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: controller.artists.length,
            itemBuilder: (context, index) {
              final artist = controller.artists[index];
              return _buildArtistCard(artist);
            },
          ),
        );
      }),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 22, // Más grande
                      fontWeight: FontWeight.w700, // Más bold
                      color: Colors.black87, // Color más suave
                      letterSpacing: 0.5, // Espaciado entre letras
                      shadows: [
                        Shadow(
                          offset: Offset(1.0, 1.0),
                          blurRadius: 0.0,
                          color: Colors.greenAccent[100]!,
                        ),
                        Shadow(
                          offset: Offset(2.0, 2.0),
                          blurRadius: 0.0,
                          color: Colors.greenAccent[100]!,
                        ),
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 2.0,
                          color: Colors.greenAccent[100]!,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3), // ← Control exacto de separación
                  Container(
                    height: 4,
                    width: 80, // ← Control del ancho del subrayado
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(
                        2,
                      ), // Bordes redondeados
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
        child,
      ],
    );
  }

  Widget _buildAlbumCard(Album album) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: album.coverImage.isNotEmpty 
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      album.coverImage,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.album, size: 40);
                      },
                    ),
                  )
                : const Icon(Icons.album, size: 40),
          ),
          const SizedBox(height: 8),
          Text(
            album.name,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            album.artist?.stageName ?? 'Artista desconocido',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildArtistCard(Artist artist) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300],
            backgroundImage: artist.profileImage.isNotEmpty 
                ? NetworkImage(artist.profileImage)
                : null,
            child: artist.profileImage.isEmpty 
                ? const Icon(Icons.person, size: 30)
                : null,
          ),
          const SizedBox(height: 8),
          Text(
            artist.stageName,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPlayer() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Imagen del álbum
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  currentSong?.localImage != null
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          currentSong!.localImage!,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                        ),
                      )
                      : const Icon(Icons.music_note),
            ),
            const SizedBox(width: 12),
            // Información de la canción
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    currentSong?.title ?? 'Selecciona una canción',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    currentSong?.artist ?? 'Artista desconocido',
                    style: GoogleFonts.roboto(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Controles
            IconButton(onPressed: () {}, icon: const Icon(Icons.skip_previous)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.play_arrow)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.skip_next)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBarWrapper(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: _buildBody(context),
      ),
    );
  }
}
