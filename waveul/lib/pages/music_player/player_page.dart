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

  // 🔹 Header con back y menú
  Widget _header(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.keyboard_arrow_down, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }

  // 🔹 Portada
  Widget _cover() {
    return Expanded(
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: song.localImage != null
              ? Image.asset(
                  song.localImage!,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                )
              : Container(
                  width: 300,
                  height: 300,
                  color: Colors.grey[300],
                  child: const Icon(Icons.music_note, size: 100),
                ),
        ),
      ),
    );
  }

  // 🔹 Info de canción
  Widget _songInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            song.title,
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 5),
          Text(
            song.artist,
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // 🔹 Barra de progreso
  Widget _progressBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Obx(() => Column(
            children: [
              Slider(
                value: control.progress.value,
                onChanged: (value) => control.seek(value),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("1:25", style: TextStyle(fontSize: 12)),
                  Text("3:45", style: TextStyle(fontSize: 12)),
                ],
              )
            ],
          )),
    );
  }

  // 🔹 Controles de música
  Widget _controls() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous, size: 40),
              onPressed: () {},
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: Icon(
                control.isPlaying.value
                    ? Icons.pause_circle
                    : Icons.play_circle,
                size: 60,
                color: Colors.teal,
              ),
              onPressed: () => control.togglePlayPause(),
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: const Icon(Icons.skip_next, size: 40),
              onPressed: () {},
            ),
          ],
        ));
  }

  // 🔹 Botones extra
  Widget _extraButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.favorite_border, size: 28),
          Icon(Icons.download_for_offline, size: 28),
          Icon(Icons.share, size: 28),
        ],
      ),
    );
  }

  // 🔹 Cuerpo principal
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _header(context),
          const SizedBox(height: 20),
          _cover(),
          const SizedBox(height: 20),
          _songInfo(),
          const SizedBox(height: 30),
          _progressBar(),
          const SizedBox(height: 20),
          _controls(),
          const SizedBox(height: 20),
          _extraButtons(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: _buildBody(context),
      ),
    );
  }
}
