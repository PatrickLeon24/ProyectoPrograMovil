import 'package:get/get.dart';
import 'package:waveul/models/artist.dart';
import 'package:waveul/models/song.dart';
import 'package:waveul/models/playlist_final.dart';
import 'package:waveul/services/artist_service.dart';
import 'package:waveul/services/song_service.dart';
import 'package:waveul/services/playlist_service.dart';
import 'package:waveul/configs/generic_response.dart';

class ExplorarMusicaController extends GetxController {
  final ArtistService _artistService = ArtistService();
  final SongService _songService = SongService();
  final PlaylistService _playlistService = PlaylistService();
}
