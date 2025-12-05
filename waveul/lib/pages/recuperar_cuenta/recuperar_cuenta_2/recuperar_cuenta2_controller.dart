import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RecuperarCuenta2Controller extends GetxController {
  final String ola = "http://10.0.2.2:9292/api/v2";

  Future<void> verifyCode(String email, String code) async {
    print("⏳ verifyCode() DISPARADO");
    print("Email: $email");
    print("Code: $code");

    final url = Uri.parse("$ola/password/verify");
    print("URL: $url");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "code": code,
      }),
    );

    print("Status: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      Get.toNamed('/recuperar_cuenta_3', arguments: email);
    } else {
      Get.snackbar("Error", "Código incorrecto");
    }
  }
}
