import 'package:get/get.dart';
import 'package:waveul/models/Song_final.dart';
import 'package:waveul/models/song.dart';
import 'package:waveul/models/playlist.dart';
import 'package:waveul/models/playlist_final.dart';
import 'package:waveul/models/album.dart';
import 'package:waveul/models/artist.dart';
import 'package:waveul/services/song_service.dart';
import 'package:waveul/services/playlist_service.dart';
import 'package:waveul/services/album_service.dart';
import 'package:waveul/services/artist_service.dart';

class HomeController extends GetxController {
  final SongService _songService = SongService();
  final PlaylistService _playlistService = PlaylistService();
  final AlbumService _albumService = AlbumService();
  final ArtistService _artistService = ArtistService();
  
  // Canciones
  RxList<SongFinal> popularSongs = <SongFinal>[].obs;
  RxList<SongFinal> allSongs = <SongFinal>[].obs;
  
  // Playlists
  RxList<PlaylistFinal> playlists = <PlaylistFinal>[].obs;
  
  // Álbumes
  RxList<Album> albums = <Album>[].obs;
  
  // Artistas
  RxList<Artist> artists = <Artist>[].obs;
  
  // Estados de carga
  RxBool isLoading = false.obs;
  RxBool isLoadingPlaylists = false.obs;
  RxBool isLoadingAlbums = false.obs;
  RxBool isLoadingArtists = false.obs;
  
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  // Convertir SongFinal a Song para compatibilidad con UI
  Song songFinalToSong(SongFinal songFinal) {
    return Song(
      id: songFinal.id,
      title: songFinal.name,
      artist: songFinal.artists.isNotEmpty ? songFinal.artists.first.stageName : "Artista desconocido",
      duration: songFinal.duration,
      playCount: songFinal.playCountGlobal,
      fileUrl: songFinal.fileUrl,
      releaseDate: songFinal.releaseDate,
      // Por ahora sin imágenes, se pueden agregar después
      coverImage: null,
      localImage: null,
      rating: null,
      albumId: null,
    );
  }

  // Convertir PlaylistFinal a Playlist para compatibilidad con UI
  Playlist playlistFinalToPlaylist(PlaylistFinal playlistFinal) {
    return Playlist(
      id: playlistFinal.id,
      name: playlistFinal.name,
      description: playlistFinal.description,
      songCount: 0, // Este campo se calcularía dinámicamente
      totalDuration: 0, // Este campo se calcularía dinámicamente  
      isPublic: playlistFinal.isPublic,
      createdBy: "Usuario", // Por ahora hardcodeado
      saveIn: 0,
      createdAt: playlistFinal.createdAt?.toIso8601String(),
    );
  }

  // Lista de elementos convertidos para la UI
  List<Song> get popularSongsForUI => popularSongs.map((sf) => songFinalToSong(sf)).toList();
  List<Song> get allSongsForUI => allSongs.map((sf) => songFinalToSong(sf)).toList();
  List<Playlist> get playlistsForUI => playlists.map((pf) => playlistFinalToPlaylist(pf)).toList();

  Future<void> loadData() async {
    isLoading.value = true;
    errorMessage.value = '';
    
    try {
      // Cargar todas las canciones
      final songsResponse = await _songService.fetchAll();
      
      if (songsResponse.success && songsResponse.data != null) {
        allSongs.value = songsResponse.data!;
        // Por ahora las "populares" serán las primeras 10
        popularSongs.value = songsResponse.data!.take(10).toList();
        print("✅ Canciones cargadas: ${allSongs.length}");
      } else {
        errorMessage.value = songsResponse.message;
        print("❌ Error cargando canciones: ${songsResponse.message}");
      }

      // Cargar playlists en paralelo
      loadPlaylists();
      
      // Cargar álbumes en paralelo
      loadAlbums();
      
      // Cargar artistas en paralelo
      loadArtists();
      
    } catch (e) {
      errorMessage.value = "Error de conexión";
      print("❌ Error inesperado: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadPlaylists() async {
    isLoadingPlaylists.value = true;
    try {
      final response = await _playlistService.fetchAll();
      if (response.success && response.data != null) {
        playlists.value = response.data!.take(10).toList();
        print("✅ Playlists cargadas: ${playlists.length}");
      } else {
        print("❌ Error cargando playlists: ${response.message}");
      }
    } catch (e) {
      print("❌ Error inesperado cargando playlists: $e");
    } finally {
      isLoadingPlaylists.value = false;
    }
  }

  Future<void> loadAlbums() async {
    isLoadingAlbums.value = true;
    try {
      final response = await _albumService.fetchAll();
      if (response.success && response.data != null) {
        albums.value = response.data!.take(10).toList();
        print("✅ Álbumes cargados: ${albums.length}");
      } else {
        print("❌ Error cargando álbumes: ${response.message}");
      }
    } catch (e) {
      print("❌ Error inesperado cargando álbumes: $e");
    } finally {
      isLoadingAlbums.value = false;
    }
  }

  Future<void> loadArtists() async {
    isLoadingArtists.value = true;
    try {
      final response = await _artistService.fetchAll();
      if (response.success && response.data != null) {
        artists.value = response.data!.take(10).toList();
        print("✅ Artistas cargados: ${artists.length}");
      } else {
        print("❌ Error cargando artistas: ${response.message}");
      }
    } catch (e) {
      print("❌ Error inesperado cargando artistas: $e");
    } finally {
      isLoadingArtists.value = false;
    }
  }

  Future<void> refreshData() async {
    await loadData();
  }
}