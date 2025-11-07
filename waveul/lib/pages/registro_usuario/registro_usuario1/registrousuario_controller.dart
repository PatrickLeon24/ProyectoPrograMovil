import 'package:get/get.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/services/users_service.dart';

class RegistroUsuarioController extends GetxController {
  final UsersService _usersService = UsersService();

  // Variables reactivas si querés mostrar carga o mensajes
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
        username: username,
        nombres: nombres,
        apellidos: apellidos,
        email: email,
        password: password,
        fechaNacimiento: fechaNacimiento,
        telefono: telefono,
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
