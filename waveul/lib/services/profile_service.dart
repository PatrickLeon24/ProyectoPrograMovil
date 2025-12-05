import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:waveul/configs/constants.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/responses/auth_response.dart';
import 'package:waveul/services/session_service.dart';

class ProfileService {
  final SessionService _sessionService = SessionService();

  /// 🔹 Actualizar username en el backend
  Future<GenericResponse<AuthResponse>> updateUsername(String newUsername) async {
    try {
      if (newUsername.trim().isEmpty) {
        return GenericResponse(
          success: false,
          data: null,
          message: "El nickname no puede estar vacío",
          error: "VALIDATION_ERROR",
        );
      }

      // 1. Obtener el token guardado en sesión
      final tokenModel = _sessionService.getToken();

      if (tokenModel == null) {
        return GenericResponse(
          success: false,
          data: null,
          message: "No hay sesión activa. Inicia sesión nuevamente.",
          error: "NO_TOKEN",
        );
      }

      // 👇 Ajusta este campo según tu modelo Token
      final String token = tokenModel.waveul; // por ejemplo: waveul, access, etc.

      final uri = Uri.parse('${BASE_URL}api/v2/users/username');
      print('🌐 PUT a: $uri');

      final httpResponse = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'username': newUsername.trim(),
        }),
      );

      print('🔢 Status code: ${httpResponse.statusCode}');
      print('📥 Body: ${httpResponse.body}');

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<AuthResponse>.fromJson(
        jsonMap,
        fromJsonT:
            (data) => AuthResponse.fromJson(data as Map<String, dynamic>),
      );

      // 3. Si todo ok, actualizamos también la sesión local
      if (response.success && response.data != null) {
        await _sessionService.saveAuthData(
          response.data!.user,
          response.data!.tokens,
        );
      }

      return response;
    } catch (e) {
      print('🔥 Error en updateUsername: $e');
      return GenericResponse(
        success: false,
        data: null,
        message: "Ocurrió un error al actualizar el nickname",
        error: e.toString(),
      );
    }
  }
}
