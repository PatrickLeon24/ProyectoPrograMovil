import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RecuperarCuenta3Controller extends GetxController {
  final String baseUrl = "http://10.0.2.2:9292/api/v2";

  Future<void> resetPassword(String email, String pass) async {
    final url = Uri.parse("$baseUrl/password/reset");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "new_password": pass,
      }),
    );

    if (response.statusCode == 200) {
      Get.offAllNamed('/iniciar_sesion');
      Get.snackbar("Éxito", "Contraseña cambiada correctamente");
    } else {
      Get.snackbar("Error", "No se pudo cambiar la contraseña");
    }
  }
}
