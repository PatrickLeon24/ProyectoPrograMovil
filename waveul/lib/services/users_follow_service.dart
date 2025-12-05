import 'dart:convert';

import 'package:waveul/configs/constants.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/models/user.dart';
import 'package:waveul/services/application_service.dart';
import 'package:http/http.dart' as http;

class UserFollowService extends ApplicationService {
  List<User> _userListFromJson(dynamic json) {
    return (json as List)
        .map((userJson) => User.fromJson(userJson as Map<String, dynamic>))
        .toList();
  }

  Future<GenericResponse<List<User>>> fetchAll() async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/v1/users'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<List<User>>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is List) {
            return _userListFromJson(data);
          }
          return <User>[];
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<List<User>>(
        success: false,
        data: null,
        message: "Error al obtener usuarios",
        error: stackTrace.toString(),
      );
    }
  }

  Future<GenericResponse<List<User>>> search(String query) async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/users/search?q=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<List<User>>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is List) {
            return _userListFromJson(data);
          }
          return <User>[];
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<List<User>>(
        success: false,
        data: null,
        message: "Error al buscar usuarios",
        error: stackTrace.toString(),
      );
    }
  }

  Future<GenericResponse<bool>> followUser(int userId) async {
    try {
      final httpResponse = await http.post(
        Uri.parse('${BASE_URL}api/users/$userId/follow'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final jsonMap = json.decode(httpResponse.body);

      return GenericResponse<bool>.fromJson(
        jsonMap,
        fromJsonT:
            (data) =>
                data is Map<String, dynamic> ? data['followed'] == true : false,
      );
    } catch (e, stackTrace) {
      return GenericResponse<bool>(
        success: false,
        data: null,
        message: "Error al seguir usuario",
        error: stackTrace.toString(),
      );
    }
  }

  Future<GenericResponse<bool>> unfollowUser(int userId) async {
    try {
      final httpResponse = await http.delete(
        Uri.parse('${BASE_URL}api/users/$userId/follow'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final jsonMap = json.decode(httpResponse.body);

      return GenericResponse<bool>.fromJson(
        jsonMap,
        fromJsonT:
            (data) =>
                data is Map<String, dynamic>
                    ? data['followed'] == false
                    : false,
      );
    } catch (e, stackTrace) {
      return GenericResponse<bool>(
        success: false,
        data: null,
        message: "Error al dejar de seguir usuario",
        error: stackTrace.toString(),
      );
    }
  }
}
