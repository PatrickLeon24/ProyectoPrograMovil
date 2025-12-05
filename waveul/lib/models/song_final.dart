import 'package:waveul/models/artist.dart';

class SongFinal {
  final int id;
  final String name;
  final int duration;
  final String fileUrl;
  final int playCountGlobal;
  final DateTime? releaseDate;
  final DateTime? createdAt;
  final List<Artist> artists;
  bool liked;

  SongFinal({
    required this.id,
    required this.name,
    required this.duration,
    required this.fileUrl,
    required this.playCountGlobal,
    required this.artists,
    this.releaseDate,
    this.createdAt,
    this.liked = false,
  });

  factory SongFinal.fromJson(Map<String, dynamic> json) {
    return SongFinal(
      id: json['id'] as int,
      name: json['name'] as String,
      duration: json['duration'] as int,
      fileUrl: json['file_url'] as String? ?? '',
      playCountGlobal: json['play_count_global'] as int? ?? 0,
      releaseDate:
          json['release_date'] != null && json['release_date'] != ''
              ? DateTime.parse(json['release_date'])
              : null,
      createdAt:
          json['created_at'] != null && json['created_at'] != ''
              ? DateTime.parse(json['created_at'])
              : null,
      artists:
          (json['artists'] as List<dynamic>?)
              ?.map((a) => Artist.fromJson(a as Map<String, dynamic>))
              .toList() ??
          <Artist>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'duration': duration,
      'file_url': fileUrl,
      'play_count_global': playCountGlobal,
      'release_date': releaseDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'artists': artists.map((a) => a.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Song{id: $id, name: $name, artists: ${artists.map((a) => a.stageName).join(", ")}}';
  }
}
