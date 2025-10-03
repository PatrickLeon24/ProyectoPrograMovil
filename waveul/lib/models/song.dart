class Song {
  final int id;
  final String title;
  final String artist;
  final String? coverImage; // URL de la imagen (opcional)
  final String? localImage; // Imagen local (opcional)
  final int? duration; // Duración en segundos
  final double? rating; // Calificación promedio
  
  // Campos del ERD agregados gradualmente
  final String? fileUrl; // URL del archivo de audio
  final DateTime? releaseDate; // Fecha de lanzamiento
  final int playCount; // Reproducciones globales
  final int? albumId; // ID del álbum (opcional)

  Song({
    required this.id,
    required this.title,
    required this.artist,
    this.coverImage,
    this.localImage,
    this.duration,
    this.rating,
    this.fileUrl,
    this.releaseDate,
    this.playCount = 0,
    this.albumId,
  });

  // Constructor para datos locales (sin servidor)
  Song.local({
    required this.id,
    required this.title,
    required this.artist,
    required this.localImage,
    this.duration,
    this.rating,
    this.playCount = 0,
  }) : coverImage = null,
       fileUrl = null,
       releaseDate = null,
       albumId = null;

  // Método para obtener la duración formateada
  String get formattedDuration {
    if (duration == null) return '0:00';
    final minutes = duration! ~/ 60;
    final seconds = duration! % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}