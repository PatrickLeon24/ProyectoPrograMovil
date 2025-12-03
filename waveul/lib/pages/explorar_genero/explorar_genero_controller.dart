import 'package:get/get.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/models/genre.dart';
import 'package:waveul/services/genre_service.dart';

class ExplorarGeneroController extends GetxController {
  GenreService _genreService = GenreService();

  RxList<Genre> genres = <Genre>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  Future<void> listGenres() async {
    isLoading.value = true;
    errorMessage.value = '';
    GenericResponse<dynamic> response = await _genreService.fetchAll();
    if (response.success) {
      genres.value = response.data;
      isLoading.value = false;
    } else {
      errorMessage.value = response.message;
    }
  }
}
