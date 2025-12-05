import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ver_artista_controller.dart';
import 'package:waveul/components/albums_list.dart';
import 'package:waveul/components/songs_list.dart';

class VerArtistaPage extends StatelessWidget {
  VerArtistaPage({super.key});

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
                        onPressed: () => Get.back(),
                      ),
                      const Spacer(),
                      Text(
                        artist?.stageName ?? 'Artista',
                        style: TextStyle(
                          fontSize: 32,
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
              padding: const EdgeInsets.symmetric(horizontal: 40),
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
        ],
      );
    });
  }

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
        ],
      );
    });
  }

  Widget _contentBodyAlbums(BuildContext context) {
    return Obx(() {
      if (control.albums.isEmpty) return const SizedBox.shrink();

      return Column(
        children: [
          const SizedBox(height: 20),
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
        ],
      );
    });
  }

  Widget _buildBody(BuildContext context) {
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
