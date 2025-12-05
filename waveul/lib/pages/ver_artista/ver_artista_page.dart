import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ver_artista_controller.dart';
// Importamos los componentes: SongsList y AlbumsList
import 'package:waveul/components/albums_list.dart';
import 'package:waveul/components/songs_list.dart';

class VerArtistaPage extends StatelessWidget {
  VerArtistaPage({super.key});

  // Registramos una sola vez el controller
  final VerArtistaController control = Get.put(VerArtistaController());

  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Image.asset(
            "assets/images/text1.png",
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _cover(BuildContext context) {
    return Obx(() {
      final artist = control.artist.value;

      return SizedBox(
        width: double.infinity,
        height: 220,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/Artist_background_cover.jpg',
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 12, right: 125),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed:
                            () => Navigator.pushNamed(
                              context,
                              '/explorar_musica',
                            ),
                      ),
                      const Spacer(),
                      Text(
                        artist?.stageName ?? "Artista",
                        style: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  /// Zona de info del artista: botón seguir + biografía
  Widget _overview(BuildContext context) {
    return Obx(() {
      final artist = control.artist.value;
      if (artist == null) return const SizedBox.shrink();

      return Column(
        children: [
          const SizedBox(height: 25),
          TextButton(
            onPressed: () {
              final newFollow = !artist.followed;
              control.toggleFollowArtist(newFollow);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                artist.followed ? "Siguiendo" : "+ Seguir",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                artist.biography.isNotEmpty
                    ? artist.biography
                    : "Este artista aún no tiene biografía registrada.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.shadow,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {},
            child: Text(
              "Mostrar Más",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );
    });
  }

  /// Lista de canciones del artista
  Widget _contentBodySongs(BuildContext context) {
    return Obx(() {
      if (control.songs.isEmpty) return const SizedBox.shrink();

      return Column(
        children: [
          const SizedBox(height: 5),
          Text(
            "Canciones",
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.shadow,
            ),
          ),
          const SizedBox(height: 12),
          SongsList(songs: control.songs, onToggleLike: control.toggleLikeSong),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {},
            child: Text(
              "Escuchar Todo",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 5),
        ],
      );
    });
  }

  /// Lista de álbumes del artista
  Widget _contentBodyAlbums(BuildContext context) {
    return Obx(() {
      if (control.albums.isEmpty) return const SizedBox.shrink();

      return Column(
        children: [
          const SizedBox(height: 10),
          Text(
            "Álbumes",
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.shadow,
            ),
          ),
          const SizedBox(height: 12),
          AlbumsList(
            albums: control.albums,
            onToggleSave: control.toggleSaveAlbum,
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {},
            child: Text(
              "Escuchar Todo",
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      );
    });
  }

  Widget _buildBody(BuildContext context) {
    // Cada vez que se construye la página, revisamos el artistId
    final args = Get.arguments as Map<String, dynamic>;
    final int artistId = args['artistId'] as int;

    // 👉 Forzamos al controller a cargar los datos de ese artista
    control.loadArtistData(artistId);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(() {
          if (control.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (control.errorMessage.isNotEmpty) {
            return Center(child: Text(control.errorMessage.value));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _header(context),
                _cover(context),
                _overview(context),
                _contentBodySongs(context),
                _contentBodyAlbums(context),
              ],
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _buildBody(context));
  }
}
