import 'dart:convert';

import 'package:waveul/configs/constants.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/models/playlist_final.dart';
import 'package:waveul/services/application_service.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class PlaylistService extends ApplicationService {
  List<PlaylistFinal> _playlistListFromJson(dynamic json) {
    return (json as List)
        .map(
          (playlistJson) =>
              PlaylistFinal.fromJson(playlistJson as Map<String, dynamic>),
        )
        .toList();
  }

  //Para GET all ${BASE_URL}api/playlists
  Future<GenericResponse<List<PlaylistFinal>>> fetchAll() async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/playlists'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      GenericResponse<List<PlaylistFinal>> response =
          GenericResponse<List<PlaylistFinal>>.fromJson(
            jsonMap,
            fromJsonT: (data) {
              if (data is List) {
                return _playlistListFromJson(data);
              }
              return <PlaylistFinal>[];
            },
          );

      return response;
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse<List<PlaylistFinal>>(
        success: false,
        data: null,
        message: "Error no esperado en listar los Playlists",
        error: stackTrace.toString(),
      );
    }
  }

  //Para GET by id ${BASE_URL}api/Playlists
  Future<GenericResponse<PlaylistFinal>> fetchById(int id) async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/playlists/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<PlaylistFinal>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is Map<String, dynamic>) {
            return PlaylistFinal.fromJson(data);
          }
          throw Exception('Formato de Playlist inválido');
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<PlaylistFinal>(
        success: false,
        data: null,
        message: "Error al obtener Playlist",
        error: stackTrace.toString(),
      );
    }
  }

  // Para GET /api/playlists/search
  Future<GenericResponse<List<PlaylistFinal>>> search(String query) async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/playlists/search?q=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      final Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      final response = GenericResponse<List<PlaylistFinal>>.fromJson(
        jsonMap,
        fromJsonT: (data) {
          if (data is List) {
            return _playlistListFromJson(data);
          }
          return <PlaylistFinal>[];
        },
      );

      return response;
    } catch (e, stackTrace) {
      return GenericResponse<List<PlaylistFinal>>(
        success: false,
        data: null,
        message: "Error al buscar playlists",
        error: stackTrace.toString(),
      );
    }
  }

  // Para POST /api/playlists/:id/save
  Future<GenericResponse<bool>> savePlaylist(int playlistId) async {
    try {
      final httpResponse = await http.post(
        Uri.parse('${BASE_URL}api/playlists/$playlistId/save'),
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
        message: "Error al guardar Playlist",
        error: stackTrace.toString(),
      );
    }
  }

  /// PARA DELETE /api/Playlists/:id/save
  Future<GenericResponse<bool>> unsavePlaylist(int playlistId) async {
    try {
      final httpResponse = await http.delete(
        Uri.parse('${BASE_URL}api/playlists/$playlistId/save'),
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
        message: "Error al eliminar de guardados la Playlist",
        error: stackTrace.toString(),
      );
    }
  }
}
