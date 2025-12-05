import 'package:get/get.dart';
import 'package:flutter/foundation.dart';

import 'package:waveul/models/artist.dart';
import 'package:waveul/models/song_final.dart';
import 'package:waveul/models/album.dart';
import 'package:waveul/models/playlist_final.dart';
import 'package:waveul/models/user.dart';

import 'package:waveul/services/artist_service.dart';
import 'package:waveul/services/song_service.dart';
import 'package:waveul/services/album_service.dart';
import 'package:waveul/services/playlist_service.dart';
import 'package:waveul/services/users_follow_service.dart';
import 'package:waveul/configs/generic_response.dart';

class ExplorarMusicaController extends GetxController {
  // Servicios
  final ArtistService _artistService = ArtistService();
  final SongService _songService = SongService();
  final AlbumService _albumService = AlbumService();
  final PlaylistService _playlistService = PlaylistService();
  final UserFollowService _userFollowService = UserFollowService();

  // Estado
  RxList<Artist> artists = <Artist>[].obs;
  RxList<SongFinal> songs = <SongFinal>[].obs;
  RxList<Album> albums = <Album>[].obs;
  RxList<PlaylistFinal> playlists = <PlaylistFinal>[].obs;
  RxList<User> profiles = <User>[].obs;

  RxBool isSearching = false.obs;
  RxString errorMessage = ''.obs;
  RxInt selectedTab = 0.obs;

  // Para no spamear al backend si borras todo
  String _lastQuery = '';

  void changeTab(int index) {
    selectedTab.value = index;
  }

  Future<void> searchAll(String query) async {
    _lastQuery = query;

    // Si está vacío, limpiamos y no llamamos al backend
    if (query.trim().isEmpty) {
      artists.clear();
      songs.clear();
      albums.clear();
      playlists.clear();
      profiles.clear();
      errorMessage.value = '';
      isSearching.value = false;
      return;
    }

    isSearching.value = true;
    errorMessage.value = '';

    try {
      // Llamamos a todos los servicios en paralelo
      final results = await Future.wait<GenericResponse<dynamic>>([
        _artistService.search(query), // 0
        _songService.search(query), // 1
        _albumService.search(query), // 2
        _playlistService.search(query), // 3
        _userFollowService.search(query), // 4
      ]);

      // 1) Artistas
      final artistResp = results[0] as GenericResponse<List<Artist>>;
      if (artistResp.success && artistResp.data != null) {
        artists.assignAll(artistResp.data!);
      } else {
        artists.clear();
      }

      // 2) Canciones
      final songResp = results[1] as GenericResponse<List<SongFinal>>;
      if (songResp.success && songResp.data != null) {
        songs.assignAll(songResp.data!);
      } else {
        songs.clear();
      }

      // 3) Álbumes
      final albumResp = results[2] as GenericResponse<List<Album>>;
      if (albumResp.success && albumResp.data != null) {
        albums.assignAll(albumResp.data!);
      } else {
        albums.clear();
      }

      // 4) Playlists
      final playlistResp = results[3] as GenericResponse<List<PlaylistFinal>>;
      if (playlistResp.success && playlistResp.data != null) {
        playlists.assignAll(playlistResp.data!);
      } else {
        playlists.clear();
      }

      // 5) Perfiles (usuarios)
      final profilesResp = results[4] as GenericResponse<List<User>>;
      if (profilesResp.success && profilesResp.data != null) {
        profiles.assignAll(profilesResp.data!);
      } else {
        profiles.clear();
      }
    } catch (e, st) {
      debugPrint('❌ Error en searchAll: $e\n$st');
      errorMessage.value = 'Error al buscar. Inténtalo de nuevo.';
    } finally {
      // ESTE finally es la clave para que deje de mostrar el loader
      isSearching.value = false;
    }
  }
}
