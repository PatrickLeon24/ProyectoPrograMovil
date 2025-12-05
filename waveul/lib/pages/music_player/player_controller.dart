import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:waveul/models/song.dart';
import 'package:waveul/services/song_service.dart';

class PlayerController extends GetxController {
  late final ap.AudioPlayer _audioPlayer;
  final SongService _songService = SongService();
  
  RxBool isPlaying = false.obs;
  RxBool isLoading = false.obs;
  RxDouble progress = 0.0.obs;
  RxString currentTime = "0:00".obs;
  RxString totalTime = "0:00".obs;
  
  Song? currentSong;
  String? currentStreamingUrl;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer = ap.AudioPlayer();
    _setupAudioListeners();
  }
  
  void _setupAudioListeners() {
    // Escuchar cambios en el estado del reproductor
    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state.toString().contains('playing');
    });
    
    // Escuchar progreso de reproducción
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      totalTime.value = _formatDuration(duration);
    });
    
    _audioPlayer.onPositionChanged.listen((Duration position) {
      currentTime.value = _formatDuration(position);
      _audioPlayer.getDuration().then((duration) {
        if (duration != null && duration.inMilliseconds > 0) {
          progress.value = position.inMilliseconds / duration.inMilliseconds;
        }
      });
    });
    
    // Escuchar cuando termina la canción
    _audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false;
      progress.value = 0.0;
      currentTime.value = "0:00";
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  Future<void> setSong(Song song) async {
    currentSong = song;
    progress.value = 0.0;
    isLoading.value = true;
    
    try {
      // Obtener URL de streaming desde el backend
      final response = await _songService.getStreamingUrl(song.id);
      if (response.success && response.data != null) {
        currentStreamingUrl = response.data;
        await _audioPlayer.setSourceUrl(currentStreamingUrl!);
        print("🎵 Canción cargada: ${song.title} - URL: $currentStreamingUrl");
      } else {
        print("❌ Error al obtener URL de streaming: ${response.message}");
        Get.snackbar("Error", "No se pudo cargar la canción: ${response.message}");
      }
    } catch (e) {
      print("❌ Error al cargar canción: $e");
      Get.snackbar("Error", "No se pudo cargar la canción");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> togglePlayPause() async {
    if (currentStreamingUrl == null) {
      Get.snackbar("Error", "No hay canción cargada");
      return;
    }
    
    if (isPlaying.value) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
  }

  Future<void> seek(double value) async {
    final duration = await _audioPlayer.getDuration();
    if (duration != null) {
      final position = Duration(milliseconds: (duration.inMilliseconds * value).round());
      await _audioPlayer.seek(position);
    }
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
