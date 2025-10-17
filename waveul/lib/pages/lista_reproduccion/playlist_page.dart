import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waveul/models/song.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
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
                      Image.asset(
                        playlistImage.isNotEmpty
                            ? playlistImage
                            : "assets/images/chill_playlist.jpg",
                        fit: BoxFit.cover,
                      ),
                      Container(color: Colors.black.withOpacity(0.25)),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          songs.shuffle();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlayerPage(song: songs.first),
                            ),
                          );
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
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PlayerPage(song: songs.first),
                            ),
                          );
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
                        icon: const Icon(
                          Icons.play_arrow_rounded,
                          color: Colors.black,
                          size: 30,
                        ),
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

              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final song = songs[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PlayerPage(song: song),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlayerPage(song: song),
                        ),
                      );
                    },
                  );
                }, childCount: songs.length),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
