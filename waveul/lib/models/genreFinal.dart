import 'package:flutter/material.dart';

class GenreFinal {
  int id;
  String name;
  String description;
  String color;

  GenreFinal({
    required this.id,
    required this.name,
    required this.description,
    required this.color,
  });

  factory GenreFinal.fromJson(Map<String, dynamic> json) {
    return GenreFinal(
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
    return 'GenreFinal{id: $id, name: $name, description: $description, color: $color}';
  }
}
