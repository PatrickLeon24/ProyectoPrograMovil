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
  final UserFollowService _userService = UserFollowService();

  // Estado
  RxList<Artist> artists = <Artist>[].obs;
  RxList<SongFinal> songs = <SongFinal>[].obs;
  RxList<Album> albums = <Album>[].obs;
  RxList<PlaylistFinal> playlists = <PlaylistFinal>[].obs;
  RxList<User> profiles = <User>[].obs;

  RxBool isSearching = false.obs;
  RxString errorMessage = ''.obs;
  RxInt selectedTab = 0.obs;

  String _lastQuery = '';

  void changeTab(int index) {
    selectedTab.value = index;
  }

  // ----------------------------------------------------------
  // 🔍 BUSCAR EN TODA LA APP
  // ----------------------------------------------------------
  Future<void> searchAll(String query) async {
    _lastQuery = query.trim();

    if (_lastQuery.isEmpty) {
      artists.clear();
      songs.clear();
      albums.clear();
      playlists.clear();
      profiles.clear();
      isSearching.value = false;
      return;
    }

    isSearching.value = true;
    errorMessage.value = '';

    try {
      final results = await Future.wait([
        _artistService.search(_lastQuery),
        _songService.search(_lastQuery),
        _albumService.search(_lastQuery),
        _playlistService.search(_lastQuery),
        _userService.search(_lastQuery),
      ]);

      // ARTISTAS
      final artistResp = results[0] as GenericResponse<List<Artist>>;
      artists.assignAll(artistResp.data ?? []);

      // CANCIONES
      final songResp = results[1] as GenericResponse<List<SongFinal>>;
      songs.assignAll(songResp.data ?? []);

      // ÁLBUMES
      final albumResp = results[2] as GenericResponse<List<Album>>;
      albums.assignAll(albumResp.data ?? []);

      // PLAYLISTS
      final playlistResp = results[3] as GenericResponse<List<PlaylistFinal>>;
      playlists.assignAll(playlistResp.data ?? []);

      // PERFILES DE USUARIO
      final profileResp = results[4] as GenericResponse<List<User>>;
      profiles.assignAll(profileResp.data ?? []);
    } catch (e, st) {
      debugPrint(" Error en searchAll: $e\n$st");
      errorMessage.value = "Error al buscar información.";
    } finally {
      isSearching.value = false;
    }
  }

  // ----------------------------------------------------------
  //  LIKE / UNLIKE SONG
  // ----------------------------------------------------------
  Future<void> toggleLikeSong(int songId, bool like) async {
    try {
      if (like) {
        await _songService.likeSongFinal(songId);
      } else {
        await _songService.unlikeSongFinal(songId);
      }

      final index = songs.indexWhere((s) => s.id == songId);
      if (index != -1) {
        songs[index].liked = like;
        songs.refresh();
      }
    } catch (e) {
      print(" Error toggleLikeSong: $e");
    }
  }

  // ----------------------------------------------------------
  //  GUARDAR / QUITAR ÁLBUM
  // ----------------------------------------------------------
  Future<void> toggleSaveAlbum(int albumId, bool saved) async {
    try {
      if (saved) {
        await _albumService.saveAlbum(albumId);
      } else {
        await _albumService.unsaveAlbum(albumId);
      }

      final index = albums.indexWhere((a) => a.id == albumId);
      if (index != -1) {
        albums[index].saved = saved;
        albums.refresh();
      }
    } catch (e) {
      print(" Error toggleSaveAlbum: $e");
    }
  }

  // ----------------------------------------------------------
  // 🎵 GUARDAR / QUITAR PLAYLIST
  // ----------------------------------------------------------
  Future<void> toggleSavePlaylist(int playlistId, bool saved) async {
    try {
      if (saved) {
        await _playlistService.savePlaylist(playlistId);
      } else {
        await _playlistService.unsavePlaylist(playlistId);
      }

      final index = playlists.indexWhere((p) => p.id == playlistId);
      if (index != -1) {
        playlists[index].saved = saved;
        playlists.refresh();
      }
    } catch (e) {
      print(" Error toggleSavePlaylist: $e");
    }
  }

  // ----------------------------------------------------------
  // 👤 SEGUIR / NO SEGUIR PERFIL
  // ----------------------------------------------------------
  Future<void> toggleFollowUser(int userId, bool follow) async {
    try {
      if (follow) {
        await _userService.followUser(userId);
      } else {
        await _userService.unfollowUser(userId);
      }

      final index = profiles.indexWhere((u) => u.id == userId);
      if (index != -1) {
        profiles[index].following = follow;
        profiles.refresh();
      }
    } catch (e) {
      print(" Error toggleFollowUser: $e");
    }
  }

  // ----------------------------------------------------------
  //  SEGUIR / NO SEGUIR ARTISTA
  // ----------------------------------------------------------
  Future<void> toggleFollowArtist(int artistId, bool follow) async {
    try {
      if (follow) {
        await _artistService.followArtist(artistId);
      } else {
        await _artistService.unfollowArtist(artistId);
      }

      final index = artists.indexWhere((a) => a.id == artistId);
      if (index != -1) {
        artists[index].followed = follow;
        artists.refresh();
      }
    } catch (e) {
      print(" Error toggleFollowArtist: $e");
    }
  }
}
