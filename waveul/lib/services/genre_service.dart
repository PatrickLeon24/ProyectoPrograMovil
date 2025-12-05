import 'dart:convert';

import 'package:waveul/configs/constants.dart';
import 'package:waveul/configs/generic_response.dart';
import 'package:waveul/models/genre_final.dart';
import 'package:waveul/services/application_service.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class GenreService extends ApplicationService {
  List<GenreFinal> _genreListFromJson(dynamic json) {
    return (json as List)
        .map(
          (genreJson) => GenreFinal.fromJson(genreJson as Map<String, dynamic>),
        )
        .toList();
  }

  Future<GenericResponse<List<GenreFinal>>> fetchAll() async {
    try {
      final httpResponse = await http.get(
        Uri.parse('${BASE_URL}api/genres'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${session.getToken()?.waveul}',
        },
      );

      Map<String, dynamic> jsonMap = json.decode(httpResponse.body);

      GenericResponse<List<GenreFinal>> response =
          GenericResponse<List<GenreFinal>>.fromJson(
            jsonMap,
            fromJsonT: (data) {
              if (data is List) {
                return _genreListFromJson(data);
              }
              return <GenreFinal>[];
            },
          );

      return response;
    } catch (e, stackTrace) {
      print('Error: $e');
      print('Stack trace: $stackTrace');
      return GenericResponse<List<GenreFinal>>(
        success: false,
        data: null,
        message: "Error no esperado en listar los géneros",
        error: stackTrace.toString(),
      );
    }
  }
}
