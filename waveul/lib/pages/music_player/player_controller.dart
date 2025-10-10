import 'package:get/get.dart';
import 'package:waveul/models/song.dart';

class PlayerController extends GetxController {
  RxBool isPlaying = false.obs;
  RxDouble progress = 0.0.obs;
  Song? currentSong;

  void setSong(Song song) {
    currentSong = song;
    progress.value = 0.0;
    isPlaying.value = false;
  }

  void togglePlayPause() {
    isPlaying.value = !isPlaying.value;
  }

  void seek(double value) {
    progress.value = value;
  }
}
