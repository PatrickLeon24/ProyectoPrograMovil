import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/responses/auth_response.dart';
import 'package:waveul/services/session_service.dart';
import 'package:waveul/services/users_service.dart';

class IniciarSesionController extends GetxController {
  // Controladores de texto
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  // Variables reactivas (para actualizar la UI)
  RxString message = ''.obs;
  RxBool success = false.obs;

  // Servicios
  final UsersService userService = UsersService();
  final SessionService sessionService = SessionService();

  /// 🔹 Iniciar sesión
  Future<void> login(BuildContext context) async {
  String user = username.text.trim();
  String pass = password.text.trim();

  print('🟢 Intentando iniciar sesión con: $user / $pass');

  if (user.isEmpty || pass.isEmpty) {
    message.value = "Por favor ingresa tus credenciales.";
    print('⚠️ Campos vacíos.');
    return;
  }

  try {
    GenericResponse<dynamic> response = await userService.signIn(user, pass);

    print('📦 Respuesta del servidor: ${response.toJson()}');

    message.value = response.message;
    success.value = response.success;

    if (response.success) {
      print('✅ Login exitoso. Guardando sesión...');
      AuthResponse data = response.data;

      await sessionService.saveAuthData(data.user, data.tokens);
      print('💾 Sesión guardada correctamente.');

      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    } else {
      print('❌ Falló el inicio de sesión: ${response.message}');
    }
  } catch (e) {
    print('🔥 Error al iniciar sesión: $e');
    message.value = "Ocurrió un error al intentar iniciar sesión.";
  }
}

  /// 🔹 Navegar al registro
  void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, '/registro_usuario1');
  }

  /// 🔹 Navegar a recuperar contraseña
  void goToResetPassword(BuildContext context) {
    Navigator.pushNamed(context, '/recuperar_cuenta_1');
  }

  /// 🔹 Cerrar sesión
  Future<void> logout(BuildContext context) async {
    await sessionService.clearAll();

    // Limpiar controladores
    username.clear();
    password.clear();
    message.value = '';
    success.value = false;

    // Redirigir al login
    Navigator.pushNamedAndRemoveUntil(context, '/bienvenida', (route) => false);
  }
}
