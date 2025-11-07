import 'package:get/get.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/services/users_service.dart';

class RegistroUsuarioController extends GetxController {
  final UsersService _usersService = UsersService();

  var isLoading = false.obs;

  Future<void> registrarUsuario({
    required String username,
    required String nombres,
    required String apellidos,
    required String email,
    required String password,
    required String fechaNacimiento,
    required String telefono,
  }) async {
    try {
      isLoading.value = true;

      GenericResponse response = await _usersService.signUp(
        name: nombres,
        lastName: apellidos,
        username: username,
        password: password,
        email: email,
        phone: telefono,
        birthDate: fechaNacimiento,
      );

      if (response.success == true) {
        Get.snackbar(
          '✅ Éxito',
          'Usuario registrado correctamente 🎉',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
        Get.offAllNamed('/iniciar_sesion');
      } else {
        Get.snackbar(
          '⚠️ Error',
          response.message ?? 'Error en el registro',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      Get.snackbar(
        '❌ Error',
        'No se pudo registrar el usuario: $e',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
