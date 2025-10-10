import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waveul/models/song.dart';
import 'package:waveul/pages/music_player/player_controller.dart';

class PlayerPage extends StatelessWidget {
  final Song song;
  final PlayerController control = Get.put(PlayerController());

  PlayerPage({super.key, required this.song}) {
    control.setSong(song);
  }

  // Barra turquesa superior
  Widget _topBar(BuildContext context) {
    const turquoise = Color(0xFF0EA79A); // puedes ajustar el tono
    return Container(
      decoration: const BoxDecoration(
        color: turquoise,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                onPressed: () => Get.back(),
              ),
              const Spacer(),
              // Título centrado visualmente
              Text(
                song.artist,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Portada centrada
  Widget _cover() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: song.localImage != null
              ? Image.asset(
                  song.localImage!,
                  width: 260,
                  height: 260,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 260,
                  height: 260,
                  color: Colors.grey[800],
                  child: const Icon(Icons.music_note, color: Colors.white54, size: 100),
                ),
        ),
      ),
    );
  }

  // Información (título + artista)
  Widget _songInfo() {
    return Column(
      children: [
        Text(
          song.title,
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          song.artist,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
      ],
      
    );
  }

 

  // Nueva barra de reproducción tipo ondas suaves (como la imagen)
Widget _progress() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: GestureDetector(
      onHorizontalDragUpdate: (details) {
        final delta = details.primaryDelta ?? 0;
        double newProgress = control.progress.value + (delta / 300);
        newProgress = newProgress.clamp(0.0, 1.0);
        control.seek(newProgress);
      },
      child: Obx(() {
        final progress = control.progress.value.clamp(0.0, 1.0);
        final totalBars = 40;
        final activeBars = (progress * totalBars).floor();

        return Column(
          children: [
            // --- Ondas visuales ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalBars, (i) {
                // Patrón suave de alturas (onda simétrica)
                double heightFactor = [
                  0.25, 0.4, 0.55, 0.75, 0.95, 1.1, 0.9, 0.7, 0.5, 0.35,
                ][i % 10];

                final color = i < activeBars
                    ? Colors.white.withOpacity(0.95 - (i % 8) * 0.05)
                    : Colors.white24;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 5,
                  height: 36 * heightFactor,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            // --- Tiempos ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("0:12",
                    style: TextStyle(color: Colors.white60, fontSize: 12)),
                Text("4:26",
                    style: TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            )
          ],
        );
      }),
    ),
  );
}


  // Controles principales
  Widget _controls() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.shuffle, size: 26, color: Colors.white70),
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.skip_previous_rounded, size: 36, color: Colors.white),
              onPressed: () {},
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: Icon(
                control.isPlaying.value ? Icons.pause_circle_filled : Icons.play_circle_fill,
                size: 78,
                color: Colors.white,
              ),
              onPressed: () => control.togglePlayPause(),
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.skip_next_rounded, size: 36, color: Colors.white),
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.repeat, size: 26, color: Colors.white70),
              onPressed: () {},
            ),
          ],
        ));
  }

  // Row inferior con acciones
  Widget _bottomRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.favorite_border, color: Colors.white, size: 26),
          Icon(Icons.queue_music, color: Colors.white, size: 26),
          Icon(Icons.share_outlined, color: Colors.white, size: 26),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // fondo oscuro general
      backgroundColor: const Color(0xFF0F0F0F),
      body: Column(
        children: [
          // Barra turquesa superior
          _topBar(context),
          // Contenido principal en fondo oscuro
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  _cover(),
                  const SizedBox(height: 6),
                  _songInfo(),
                  
                  _progress(),
                  _controls(),
                  const SizedBox(height: 10),
                  _bottomRow(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
