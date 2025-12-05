import 'package:waveul/models/artist.dart';

class Album {
  final int id;
  final String name;
  final String coverImage;
  final Artist artist;
  final DateTime? releaseDate;
  final DateTime? createdAt;

  Album({
    required this.id,
    required this.name,
    required this.coverImage,
    required this.artist,
    this.releaseDate,
    this.createdAt,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] as int,
      name: json['name'] as String,
      coverImage: json['cover_image'] as String? ?? '',
      releaseDate:
          json['release_date'] != null && json['release_date'] != ''
              ? DateTime.parse(json['release_date'])
              : null,
      createdAt:
          json['created_at'] != null && json['created_at'] != ''
              ? DateTime.parse(json['created_at'])
              : null,
      artist: Artist(
        id: 0, // No tenemos el ID del artista en esta respuesta
        stageName: json['artist_name'] as String? ?? '',
        isBand: false, // Valor por defecto
        biography: '', // Valor por defecto
        profileImage: json['artist_image'] as String? ?? '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cover_image': coverImage,
      'artist': artist.toJson(),
      'release_date': releaseDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Album{id: $id, name: $name, artist: ${artist.stageName}}';
  }
}
