import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waveul/models/song.dart';
import 'package:waveul/pages/music_player/player_controller.dart';
import 'package:waveul/pages/music_player/player_page.dart';

class PlaylistPage extends StatelessWidget {
  final String playlistName;
  final String playlistImage;
  final List<Song> songs;

  const PlaylistPage({
    super.key,
    required this.playlistName,
    required this.playlistImage,
    required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.put(PlayerController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // --- Contenido principal (Scroll)
          CustomScrollView(
            slivers: [
              // 🟢 Encabezado del playlist
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                backgroundColor: Colors.greenAccent[100],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    playlistName,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      (playlistImage.isNotEmpty)
                          ? Image.asset(
                              playlistImage,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              "assets/images/chill_playlist.jpg",
                              fit: BoxFit.cover,
                            ),
                      Container(color: Colors.black.withOpacity(0.25)),
                    ],
                  ),
                ),
              ),

              // 🟩 Botones tipo Spotify
              SliverToBoxAdapter(
                child: Container(
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 🔁 Botón Remix
                      ElevatedButton.icon(
                        onPressed: () {
                          songs.shuffle();
                          playerController.setSong(songs.first);
                          playerController.isPlaying.value = true;
                          Get.to(() => PlayerPage(song: songs.first));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Colors.green),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        icon: const Icon(Icons.shuffle, color: Colors.green),
                        label: Text(
                          "Remix",
                          style: GoogleFonts.poppins(
                            color: Colors.green[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // ▶ Botón Play All
                      ElevatedButton.icon(
                        onPressed: () {
                          playerController.setSong(songs.first);
                          playerController.isPlaying.value = true;
                          Get.to(() => PlayerPage(song: songs.first));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent[100],
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                        ),
                        icon: const Icon(Icons.play_arrow_rounded,
                            color: Colors.black, size: 30),
                        label: Text(
                          "Play",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 🎵 Lista de canciones
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final song = songs[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          song.localImage ?? "assets/images/default_song.jpg",
                          width: 55,
                          height: 55,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        song.title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        song.artist,
                        style: GoogleFonts.poppins(color: Colors.grey[700]),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.green,
                          size: 30,
                        ),
                        onPressed: () {
                          playerController.setSong(song);
                          playerController.isPlaying.value = true;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('▶ Reproduciendo: ${song.title}'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      onTap: () {
                        playerController.setSong(song);
                        Get.to(() => PlayerPage(song: song));
                      },
                    );
                  },
                  childCount: songs.length,
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 120)),
            ],
          ),

          // --- 🔊 Mini reproductor inferior ---
          Obx(() {
            final currentSong = playerController.currentSong;
            if (currentSong == null) return const SizedBox.shrink();

            return Align(
              alignment: Alignment.bottomCenter,
              child: _buildBottomPlayer(playerController),
            );
          }),
        ],
      ),
    );
  }

  // --- Mini reproductor (parte inferior) ---
  Widget _buildBottomPlayer(PlayerController controller) {
    final currentSong = controller.currentSong;

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
              child: currentSong?.localImage != null
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
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.skip_previous),
            ),
            IconButton(
              onPressed: controller.togglePlayPause,
              icon: Icon(
                controller.isPlaying.value
                    ? Icons.pause
                    : Icons.play_arrow_rounded,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.skip_next),
            ),
          ],
        ),
      ),
    );
  }
}
