import 'dart:convert';

import 'package:waveul/configs/constants.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/models/Song_final.dart';
import 'package:waveul/services/application_service.dart';
import 'package:http/http.dart' as http;

class SongService extends ApplicationService {
  List<SongFinal> _songListFromJson(dynamic json) {
    return (json as List)
        .map(
          (songFinalJson) =>
              SongFinal.fromJson(songFinalJson as Map<String, dynamic>),
        )
        .toList();
  }

  /// GET ${BASE_URL}api/SongFinals  -> lista todas las canciones
  Future<GenericResponse<List<SongFinal>>> fetchAll() async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/songs'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<List<SongFinal>>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is List) {
            return _songListFromJson(data);
          }
          return <SongFinal>[];
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<List<SongFinal>>(
        success: false,
        data: null,
        message: "Error no esperado al listar canciones",
        error: stackTrace.toString(),
      );
    }
  }

  /// GET ${BASE_URL}api/SongFinals/search?q=...
  Future<GenericResponse<List<SongFinal>>> search(String query) async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/songs/search?q=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<List<SongFinal>>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is List) {
            return _songListFromJson(data);
          }
          return <SongFinal>[];
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<List<SongFinal>>(
        success: false,
        data: null,
        message: "Error al buscar canciones",
        error: stackTrace.toString(),
      );
    }
  }

  /// GET ${BASE_URL}api/SongFinals/:id
  Future<GenericResponse<SongFinal>> fetchById(int id) async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/songs/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<SongFinal>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is Map<String, dynamic>) {
            return SongFinal.fromJson(data);
          }
          throw Exception('Formato de canción inválido');
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<SongFinal>(
        success: false,
        data: null,
        message: "Error al obtener canción",
        error: stackTrace.toString(),
      );
    }
  }

  /// POST ${BASE_URL}api/SongFinals/:id/like  -> marcar "Me gusta"
  Future<GenericResponse<bool>> likeSongFinal(int songId) async {
    try {
      final httpResponse = await http.post(
        Uri.parse('${BASE_URL}api/songs/$songId/like'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<bool>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is Map<String, dynamic>) {
            return data['liked'] == true;
          }
          return false;
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<bool>(
        success: false,
        data: null,
        message: "Error al marcar canción como Me gusta",
        error: stackTrace.toString(),
      );
    }
  }

  /// DELETE ${BASE_URL}api/SongFinals/:id/like  -> quitar "Me gusta"
  Future<GenericResponse<bool>> unlikeSongFinal(int songId) async {
    try {
      final httpResponse = await http.delete(
        Uri.parse('${BASE_URL}api/songs/$songId/like'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<bool>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is Map<String, dynamic>) {
            return data['liked'] == false;
          }
          return false;
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<bool>(
        success: false,
        data: null,
        message: "Error al quitar canción de Me gusta",
        error: stackTrace.toString(),
      );
    }
  }
}
