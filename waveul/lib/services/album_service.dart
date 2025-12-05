import 'dart:convert';

import 'package:waveul/configs/constants.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/models/album.dart';
import 'package:waveul/services/application_service.dart';
import 'package:http/http.dart' as http;

class AlbumService extends ApplicationService {
  List<Album> _albumListFromJson(dynamic json) {
    return (json as List)
        .map((albumJson) => Album.fromJson(albumJson as Map<String, dynamic>))
        .toList();
  }

  /// GET ${BASE_URL}api/albums
  Future<GenericResponse<List<Album>>> fetchAll() async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/albums'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<List<Album>>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is List) {
            return _albumListFromJson(data);
          }
          return <Album>[];
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<List<Album>>(
        success: false,
        data: null,
        message: "Error al listar álbumes",
        error: stackTrace.toString(),
      );
    }
  }

  /// GET ${BASE_URL}api/albums/:id
  Future<GenericResponse<Album>> fetchById(int id) async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/albums/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<Album>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is Map<String, dynamic>) {
            return Album.fromJson(data);
          }
          throw Exception('Formato de álbum inválido');
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<Album>(
        success: false,
        data: null,
        message: "Error al obtener álbum",
        error: stackTrace.toString(),
      );
    }
  }

  /// GET ${BASE_URL}api/albums/search?q=
  Future<GenericResponse<List<Album>>> search(String query) async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/albums/search?q=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<List<Album>>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is List) {
            return _albumListFromJson(data);
          }
          return <Album>[];
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<List<Album>>(
        success: false,
        data: null,
        message: "Error al buscar álbumes",
        error: stackTrace.toString(),
      );
    }
  }

  /// POST ${BASE_URL}api/albums/:id/save
  Future<GenericResponse<bool>> saveAlbum(int albumId) async {
    try {
      final httpResponse = await http.post(
        Uri.parse('${BASE_URL}api/albums/$albumId/save'),
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
            return data['saved'] == true;
          }
          return false;
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<bool>(
        success: false,
        data: null,
        message: "Error al guardar álbum",
        error: stackTrace.toString(),
      );
    }
  }

  /// DELETE ${BASE_URL}api/albums/:id/save
  Future<GenericResponse<bool>> unsaveAlbum(int albumId) async {
    try {
      final httpResponse = await http.delete(
        Uri.parse('${BASE_URL}api/albums/$albumId/save'),
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
            return data['saved'] == false;
          }
          return false;
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<bool>(
        success: false,
        data: null,
        message: "Error al quitar álbum de tu biblioteca",
        error: stackTrace.toString(),
      );
    }
  }
}
