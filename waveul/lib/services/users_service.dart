import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/responses/auth_response.dart';
import 'package:waveul/configs/constants.dart';
import 'package:http/http.dart' as http;

class UsersService {
  /// 🔹 Versión que usa el backend real (cuando esté disponible)
  Future<GenericResponse<AuthResponse>> signIn(String username, String password) async {
    try {
      if (username.isEmpty || password.isEmpty) {
        return GenericResponse(
          success: false,
          data: null,
          message: "Debe ingresar usuario y contraseña",
          error: "ERROR!",
        );
      }

      final httpResponse = await http.post(
        Uri.parse('${BASE_URL}api/v2/sign-in'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      print('--- RESPUESTA DEL BACKEND ---');
      print(httpResponse.body);

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<AuthResponse>.fromJson(
        jsonMap,
        fromJsonT: (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      );

      return response;
    } catch (e) {
      return GenericResponse(
        success: false,
        data: null,
        message: "Ocurrió un error al validar el usuario",
        error: e.toString(),
      );
    }
  }

  /// 🔹 Versión temporal que usa un JSON local (para pruebas sin backend)
  Future<GenericResponse<AuthResponse>> signInLocal(String username, String password) async {
    try {
      if (username.isEmpty || password.isEmpty) {
        return GenericResponse(
          success: false,
          data: null,
          message: "Debe ingresar usuario y contraseña",
          error: "ERROR!",
        );
      }

      // Simulación de usuario válido
      if (username == 'admin' && password == '123') {
        // Carga el archivo local de ejemplo
        String jsonString = await rootBundle.loadString('assets/jsons/user.json');
        final Map<String, dynamic> jsonMap = json.decode(jsonString);

        final response = GenericResponse<AuthResponse>.fromJson(
          jsonMap,
          fromJsonT: (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
        );

        return response;
      } else {
        return GenericResponse(
          success: false,
          data: null,
          message: "Usuario o contraseña incorrectos",
          error: "ERROR!",
        );
      }
    } catch (e) {
      return GenericResponse(
        success: false,
        data: null,
        message: "Error al leer el JSON local",
        error: e.toString(),
      );
    }
  }

  Future<GenericResponse> signUp({
  required String username,
  required String nombres,
  required String apellidos,
  required String email,
  required String password,
  required String fechaNacimiento,
  required String telefono,
}) async {
  try {
    if (username.isEmpty ||
        nombres.isEmpty ||
        apellidos.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        fechaNacimiento.isEmpty ||
        telefono.isEmpty) {
      return GenericResponse(
        success: false,
        data: null,
        message: "Debe completar todos los campos",
        error: "ERROR!",
      );
    }
    print(username);
    final httpResponse = await http.post(
      Uri.parse('${BASE_URL}api/v2/sign-up'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode({
        'username': username,
        'nombres': nombres,
        'apellidos': apellidos,
        'email': email,
        'password': password,
        'fecha_nacimiento': fechaNacimiento,
        'telefono': telefono,
      }),
    );
    print(httpResponse.body);
    Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

    final response = GenericResponse<AuthResponse>.fromJson(
      jsonMap,
      fromJsonT: (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
    );

    return response;
    } catch (e) {
      return GenericResponse(
        success: false,
        data: null,
        message: "Ocurrió un error al registrar el usuario",
        error: e.toString(),
      );
    }
  }
}
