import 'dart:convert';

import 'package:waveul/configs/constants.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/models/artist.dart';
import 'package:waveul/services/application_service.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ArtistService extends ApplicationService {
  List<Artist> _artistListFromJson(dynamic json) {
    return (json as List)
        .map(
          (artistJson) => Artist.fromJson(artistJson as Map<String, dynamic>),
        )
        .toList();
  }

  //Para GET all ${BASE_URL}api/artists
  Future<GenericResponse<List<Artist>>> fetchAll() async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/artists'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      GenericResponse<List<Artist>> response =
          GenericResponse<List<Artist>>.fromJson(
            jsonMap,
            fromJsonT: (data) {
              if (data is List) {
                return _artistListFromJson(data);
              }
              return <Artist>[];
            },
          );

      return response;
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse<List<Artist>>(
        success: false,
        data: null,
        message: "Error no esperado en listar los artistas",
        error: stackTrace.toString(),
      );
    }
  }

  //Para GET by id ${BASE_URL}api/artists
  Future<GenericResponse<Artist>> fetchById(int id) async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/artists/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<Artist>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is Map<String, dynamic>) {
            return Artist.fromJson(data);
          }
          throw Exception('Formato de artista inválido');
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<Artist>(
        success: false,
        data: null,
        message: "Error al obtener artista",
        error: stackTrace.toString(),
      );
    }
  }

  Future<GenericResponse<List<Artist>>> search(String query) async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/artists/search?q=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<List<Artist>>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is List) {
            return _artistListFromJson(data);
          }
          return <Artist>[];
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<List<Artist>>(
        success: false,
        data: null,
        message: "Error al buscar artistas",
        error: stackTrace.toString(),
      );
    }
  }

  /// Para POST /api/artists/:id/follow
  Future<GenericResponse<bool>> followArtist(int artistId) async {
    try {
      final httpResponse = await http.post(
        Uri.parse('${BASE_URL}api/artists/$artistId/follow'),
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
            return data['followed'] == true;
          }
          return false;
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<bool>(
        success: false,
        data: null,
        message: "Error al seguir artista",
        error: stackTrace.toString(),
      );
    }
  }

  /// PARA DELETE /api/artists/:id/unfollow
  Future<GenericResponse<bool>> unfollowArtist(int artistId) async {
    try {
      final httpResponse = await http.delete(
        Uri.parse('${BASE_URL}api/artists/$artistId/unfollow'),
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
            return data['followed'] == false;
          }
          return false;
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<bool>(
        success: false,
        data: null,
        message: "Error al dejar de seguir artista",
        error: stackTrace.toString(),
      );
    }
  }
}
