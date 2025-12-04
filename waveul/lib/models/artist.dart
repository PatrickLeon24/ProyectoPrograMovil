//Prioridad ahora
class Artist {
  int id;
  String name;
  String description;
  String color;

  Artist({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      color: json['color'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description, 'color': color};
  }

  @override
  String toString() {
    return 'Genre{id: $id, name: $name, description: $description, color: $color}';
  }
}
