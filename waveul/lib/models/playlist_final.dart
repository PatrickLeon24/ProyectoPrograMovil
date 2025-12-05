import 'package:waveul/models/user.dart';

class PlaylistFinal {
  final int id;
  final String name;
  final String description;
  final String coverImage;
  final bool isPublic;
  final DateTime? createdAt;
  final User? owner;
  bool saved;

  PlaylistFinal({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.isPublic,
    this.owner,
    this.createdAt,
    this.saved = false,
  });

  factory PlaylistFinal.fromJson(Map<String, dynamic> json) {
    return PlaylistFinal(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      coverImage: json['cover_image'] as String? ?? '',
      isPublic: json['is_public'] == 1 || json['is_public'] == true,
      createdAt:
          json['created_at'] != null && json['created_at'] != ''
              ? DateTime.parse(json['created_at'])
              : null,
      owner:
          json['user'] != null
              ? User.fromJson(json['user'] as Map<String, dynamic>)
              : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'cover_image': coverImage,
      'is_public': isPublic ? 1 : 0,
      'created_at': createdAt?.toIso8601String(),
      if (owner != null) 'user': owner!.toJson(),
    };
  }

  @override
  String toString() {
    return 'Playlist{id: $id, name: $name, owner: ${owner?.name}}}';
  }
}
