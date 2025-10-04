import 'package:flutter/material.dart';

class Genre {
  final int id;
  final String name;
  final String? description;
  final String? coverImage; // URL de la imagen (opcional)
  final String? localImage; // Imagen local (opcional)
  final List<Color> gradientColors; // Colores del degradado
  final int songCount; // Número de canciones del género (calculado)
  
  const Genre({
    required this.id,
    required this.name,
    required this.gradientColors,
    this.description,
    this.coverImage,
    this.localImage,
    this.songCount = 0,
  });

  // Constructor para datos locales (sin servidor)
  Genre.local({
    required this.id,
    required this.name,
    required this.gradientColors,
    required this.localImage,
    this.description,
    this.songCount = 0,
  }) : coverImage = null;
}