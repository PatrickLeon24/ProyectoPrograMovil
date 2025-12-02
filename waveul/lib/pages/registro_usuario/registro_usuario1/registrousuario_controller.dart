import 'package:get/get.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/services/users_service.dart';

class RegistroUsuarioController extends GetxController {
  final UsersService _usersService = UsersService();

  var isLoading = false.obs;

  Future<void> registrarUsuario({
    required String name,
    required String lastName,
    required String username,
    required String password,
    required String email,
    required String phone,
    required String birthDate,
    String profileImage =
        "https://cdn.waveul.com/avatars/default.png", // opcional
  }) async {
    try {
      isLoading.value = true;

      GenericResponse response = await _usersService.signUp(
        name: name,
        lastName: lastName,
        username: username,
        password: password,
        email: email,
        phone: phone,
        birthDate: birthDate,
        profileImage: profileImage,
      );

      if (response.success == true) {
        Get.snackbar('Éxito', 'Usuario registrado correctamente 🎉');
        Get.offAllNamed('/iniciar_sesion');
      } else {
        Get.snackbar('Error', response.message ?? 'Error en el registro');
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo registrar: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
