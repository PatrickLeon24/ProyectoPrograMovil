import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveul/services/users_service.dart';
import 'package:waveul/configs/generic_response.dart';

class IniciarSesionController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  RxString message = ''.obs;
  RxBool success = false.obs;

  UsersService userService = UsersService();

  void login(BuildContext context) {
    String user = username.text;
    String pass = password.text;
    GenericResponse response = userService.signIn(user, pass);

    message.value = response.message;
    success.value = response.success;

    if (response.success) {
      Navigator.pushNamed(context, '/home');
    }
  }

  void goToSignUp(BuildContext context) {
    Navigator.pushNamed(context, '/registro_usuario1');
  }

  void goToResetPassword(BuildContext context) {
    Navigator.pushNamed(context, '/recuperar_cuenta_1');
  }

  void logout(BuildContext context) {
    // Limpiar controladores
    username.clear();
    password.clear();
    message.value = '';
    success.value = false;

    // Redirigir al login
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/bienvenida',
      (route) => false, // eliminar historial para que no pueda volver atrás
    );
  }
}
