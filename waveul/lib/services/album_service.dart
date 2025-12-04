import 'dart:convert';

import 'package:waveul/configs/constants.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/models/album.dart';
import 'package:waveul/services/application_service.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AlbumService extends ApplicationService {
  List<Album> _albumListFromJson(dynamic json) {
    return (json as List)
        .map((genreJson) => Album.fromJson(genreJson as Map<String, dynamic>))
        .toList();
  }

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

      Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      GenericResponse<List<Album>> response =
          GenericResponse<List<Album>>.fromJson(
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
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse<List<Album>>(
        success: false,
        data: null,
        message: "Error no esperado en listar los artistas",
        error: stackTrace.toString(),
      );
    }
  }
}
