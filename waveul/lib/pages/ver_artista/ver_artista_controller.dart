import 'package:get/get.dart';
import 'package:waveul/models/artist.dart';
import 'package:waveul/models/song_final.dart';
import 'package:waveul/models/album.dart';

import 'package:waveul/services/artist_service.dart';
import 'package:waveul/services/song_service.dart';
import 'package:waveul/services/album_service.dart';
import 'package:waveul/configs/generic_response.dart';

class VerArtistaController extends GetxController {
  final ArtistService _artistService = ArtistService();
  final SongService _songService = SongService();
  final AlbumService _albumService = AlbumService();

  Rx<Artist?> artist = Rx<Artist?>(null);
  RxList<SongFinal> songs = <SongFinal>[].obs;
  RxList<Album> albums = <Album>[].obs;

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  int? _artistId; // se actualiza cuando cambias de artista

  @override
  void onInit() {
    super.onInit();

    // Primer artista al entrar por primera vez
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args['artistId'] is int) {
      loadArtistData(args['artistId'] as int);
    }
  }

  /// Cargar artista + canciones + álbumes
  Future<void> loadArtistData(int artistId) async {
    // Si ya cargaste ese artista, no vuelvas a pegarle al backend
    if (_artistId == artistId && artist.value != null) return;

    _artistId = artistId;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      // 1) Detalle del artista
      GenericResponse<Artist> artistResp = await _artistService.fetchById(
        artistId,
      );

      if (artistResp.success && artistResp.data != null) {
        artist.value = artistResp.data;
      } else {
        errorMessage.value =
            artistResp.message ?? 'No se pudo cargar el artista';
      }

      // 2) Canciones del artista
      GenericResponse<List<SongFinal>> songsResp = await _songService
          .fetchByArtist(artistId);

      if (songsResp.success && songsResp.data != null) {
        songs.assignAll(songsResp.data!);
      } else {
        songs.clear();
      }

      // 3) Álbumes del artista
      GenericResponse<List<Album>> albumsResp = await _albumService
          .fetchByArtist(artistId);

      if (albumsResp.success && albumsResp.data != null) {
        albums.assignAll(albumsResp.data!);
      } else {
        albums.clear();
      }
    } catch (e, stack) {
      errorMessage.value = 'Error al cargar datos del artista';
      print(e);
      print(stack);
    } finally {
      isLoading.value = false;
    }
  }

  /// Seguir / dejar de seguir artista
  Future<void> toggleFollowArtist(bool follow) async {
    final current = artist.value;
    if (current == null) return;

    try {
      if (follow) {
        await _artistService.followArtist(current.id);
      } else {
        await _artistService.unfollowArtist(current.id);
      }

      artist.update((a) {
        if (a != null) a.followed = follow;
      });
    } catch (e, stack) {
      print('Error al seguir/dejar de seguir artista: $e');
      print(stack);
    }
  }

  /// Like / Unlike canción
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
    } catch (e, stack) {
      print('Error al like/unlike canción: $e');
      print(stack);
    }
  }

  /// Guardar / quitar álbum
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
    } catch (e, stack) {
      print('Error al guardar/quitar álbum: $e');
      print(stack);
    }
  }
}
