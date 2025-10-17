import 'package:get/get.dart';
import 'package:waveul/models/song.dart';
import 'package:waveul/models/playlist.dart';
import 'package:waveul/pages/music_player/player_controller.dart';

class PlaylistController extends GetxController {
  // Datos de la playlist
  final RxString playlistName = ''.obs;
  final RxString? playlistImage = RxString('');
  final RxList<Song> songs = <Song>[].obs;

  // Controlador del reproductor
  late final PlayerController playerController;

  @override
  void onInit() {
    super.onInit();
    // Se asegura de tener una instancia única del reproductor
    playerController = Get.put(PlayerController(), permanent: true);
  }

  /// Carga los datos de la playlist seleccionada
  void loadPlaylist(String name, List<Song> newSongs, {String? image}) {
    playlistName.value = name;
    playlistImage?.value = image ?? '';
    songs.assignAll(newSongs);
  }

  /// Reproduce una canción
  void playSong(Song song) {
    playerController.setSong(song);
  }

  /// Alternar favorito (solo local por ahora)
  void toggleFavorite(Song song) {}
}
