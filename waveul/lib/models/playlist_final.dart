import 'package:waveul/models/user.dart';

class PlaylistFinal {
  final int id;
  final String name;
  final String description;
  final String coverImage;
  final bool isPublic;
  final DateTime? createdAt;
  final User owner;

  PlaylistFinal({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.isPublic,
    required this.owner,
    this.createdAt,
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
      owner: User(
        id: json['user_id'] as int,
        name: 'Usuario', // Valor por defecto
        lastName: '', // Valor por defecto
        username: 'user${json['user_id']}', // Valor por defecto
        passwordHash: '', // Valor por defecto
        email: 'user@example.com', // Valor por defecto
        createdAt: DateTime.now(), // Valor por defecto
        isVerified: false, // Valor por defecto
      ),
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
      'owner': owner.toJson(),
    };
  }

  @override
  String toString() {
    return 'Playlist{id: $id, name: $name, owner: ${owner.name}}}';
  }
}
