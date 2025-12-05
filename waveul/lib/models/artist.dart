//Prioridad ahora
class Artist {
  final int id;
  final String stageName;
  final bool isBand;
  final String biography;
  final String profileImage;
  final DateTime? formedDate;
  final DateTime? createdAt;

  Artist({
    required this.id,
    required this.stageName,
    required this.isBand,
    required this.biography,
    required this.profileImage,
    this.formedDate,
    this.createdAt,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'] as int,
      stageName: json['stage_name'] as String,
      isBand: json['is_band'] == 1 || json['is_band'] == true,
      biography: json['biography'] as String? ?? '',
      profileImage: json['profile_image'] as String? ?? '',
      formedDate:
          json['formed_date'] != null && json['formed_date'] != ''
              ? DateTime.parse(json['formed_date'])
              : null,
      createdAt:
          json['created_at'] != null && json['created_at'] != ''
              ? DateTime.parse(json['created_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stage_name': stageName,
      'is_band': isBand ? 1 : 0,
      'biography': biography,
      'profile_image': profileImage,
      'formed_date': formedDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Artist{id: $id, stageName: $stageName, isBand: $isBand, biography: $biography}';
  }
}
