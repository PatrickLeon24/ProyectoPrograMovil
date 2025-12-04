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
        .map((genreJson) => Artist.fromJson(genreJson as Map<String, dynamic>))
        .toList();
  }

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
}
