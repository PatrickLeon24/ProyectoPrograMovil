import 'package:flutter/material.dart';

class Genre {
  final int id;
  final String name;
  final String? description;
  final String? coverImage; // URL de la imagen (opcional)
  final String? localImage; // Imagen local (opcional)
  final List<Color> gradientColors; // Colores del degradado
  final String? color;
  final int songCount; // Número de canciones del género (calculado)

  Genre({
    // Removido 'const' porque List<Color> no puede ser const
    required this.id,
    required this.name,
    required this.gradientColors,
    this.description,
    this.coverImage,
    this.localImage,
    this.color,
    this.songCount = 0,
  });

  // Constructor para datos locales (sin servidor)
  Genre.local({
    required this.id,
    required this.name,
    required this.gradientColors,
    required this.localImage,
    this.color,
    this.description,
    this.songCount = 0,
  }) : coverImage = null;

  //---------------------------------------
  //Cambio a partir de aqui con backend
  //(La pagina home y otras relacionadas van a dejar de funcionar por ahora)
  //Para que vuelva a funcionar puedes quitar el comentario del codigo de arriba */
}
