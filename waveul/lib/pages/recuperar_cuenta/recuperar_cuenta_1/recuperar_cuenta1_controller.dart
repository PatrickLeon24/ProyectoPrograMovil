import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RecuperarCuenta1Controller extends GetxController {
  final String baseUrl = "http://10.0.2.2:9292/api/v2";

  Future<void> sendCode(String email) async {
    final url = Uri.parse("$baseUrl/password/forgot");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200) {
      Get.toNamed('/recuperar_cuenta_2', arguments: email);
    } else {
      Get.snackbar("Error", "Correo no encontrado o servidor caído");
    }
  }
}
