import 'package:get/get.dart';
import 'package:waveul/models/artist.dart';
import 'package:waveul/services/artist_service.dart';
import 'package:waveul/configs/generic_response.dart';

class VerArtistaController extends GetxController {
  final ArtistService _artistService = ArtistService();
  late final int artistId;

  Rx<Artist?> artist = Rx<Artist?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isFollowing = false.obs;

  @override
  void onInit() {
    super.onInit();
    artistId = Get.arguments?['artistId'] ?? 0;

    if (artistId == 0) {
      errorMessage.value = 'No se recibió el ID del artista';
    } else {
      _loadArtist();
    }
  }

  Future<void> _loadArtist() async {
    isLoading.value = true;
    errorMessage.value = '';

    GenericResponse<Artist> res = await _artistService.fetchById(artistId);

    if (res.success && res.data != null) {
      artist.value = res.data;
    } else {
      errorMessage.value = res.message ?? 'Error al cargar artista';
    }

    isLoading.value = false;
  }

  Future<void> toggleFollow() async {
    if (artist.value == null) return;
    final currentlyFollowing = isFollowing.value;
    if (!currentlyFollowing) {
      final res = await _artistService.followArtist(artistId);
      if (res.success && res.data == true) {
        isFollowing.value = true;
      } else {
        print(res.message);
      }
    } else {
      final res = await _artistService.unfollowArtist(artistId);
      if (res.success && res.data == true) {
        isFollowing.value = false;
      } else {
        print(res.message);
      }
    }
  }
}
