import 'package:get/get.dart';
import 'package:waveul/models/song.dart';

class PlayerController extends GetxController {
  var isPlaying = true.obs;
  var progress = 0.3.obs; // Progreso simulado
  late Song currentSong;

  void setSong(Song song) {
    currentSong = song;
  }

  void togglePlayPause() {
    isPlaying.value = !isPlaying.value;
  }

  void seek(double value) {
    progress.value = value;
  }
}
