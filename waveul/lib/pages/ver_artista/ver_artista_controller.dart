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

  late final int artistId;

  @override
  void onInit() {
    super.onInit();

    // 1) Leer el argumento que viene de Get.toNamed('/ver_artista', arguments: a.id)
    final arg = Get.arguments;
    if (arg is int) {
      artistId = arg;
    } else if (arg is Map) {
      artistId = arg['artistId'] as int;
    } else {
      errorMessage.value = 'No se recibió el id del artista';
      return;
    }

    // 2) Cargar datos
    loadArtistData();
  }

  /// Cargar artista + canciones + álbumes
  Future<void> loadArtistData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // --- Artista ---
      final GenericResponse<Artist> artistResp = await _artistService.fetchById(
        artistId,
      );

      if (artistResp.success && artistResp.data != null) {
        artist.value = artistResp.data;
      } else {
        errorMessage.value =
            artistResp.message ?? 'No se pudo cargar el artista';
      }

      // --- Canciones del artista ---
      final GenericResponse<List<SongFinal>> songsResp = await _songService
          .fetchByArtist(artistId);

      if (songsResp.success && songsResp.data != null) {
        songs.assignAll(songsResp.data!);
      } else {
        songs.clear();
      }

      // --- Álbumes del artista ---
      final GenericResponse<List<Album>> albumsResp = await _albumService
          .fetchByArtist(artistId);

      if (albumsResp.success && albumsResp.data != null) {
        albums.assignAll(albumsResp.data!);
      } else {
        albums.clear();
      }
    } catch (e, stack) {
      print('Error en loadArtistData: $e');
      print(stack);
      errorMessage.value = 'Error al cargar datos del artista';
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

      // Actualizar el objeto en memoria
      artist.update((a) {
        if (a != null) a.followed = follow;
      });
    } catch (e, stack) {
      print('Error al seguir/dejar de seguir artista: $e');
      print(stack);
    }
  }

  /// Like / unlike canción
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
