class Playlist {
  final int id;
  final String name;
  final String? description;
  final String? coverImage; // URL de la imagen (opcional)
  final String? localImage; // Imagen local (opcional - solo para desarrollo)
  final int songCount; // Número de canciones (calculado dinámicamente)
  final int totalDuration; // Duración total en segundos (calculado dinámicamente)
  final bool isPublic;
  final String? createdBy; // Nombre del creador (solo para UI, se obtiene de user)
  final int? userId; // ID del usuario creador
  
  // Datos del ERD que coinciden exactamente
  final int saveIn; // Cuántas veces fue guardada (coincide con ERD)
  final String? createdAt; // Fecha de creación como string (sin DateTime para evitar logs chinos)

  const Playlist({
    required this.id,
    required this.name,
    required this.songCount,
    required this.totalDuration,
    this.description,
    this.coverImage,
    this.localImage,
    this.isPublic = true,
    this.createdBy,
    this.userId,
    this.saveIn = 0,
    this.createdAt,
  });

  // Constructor para datos locales (sin servidor)
  Playlist.local({
    required this.id,
    required this.name,
    required this.songCount,
    required this.totalDuration,
    required this.localImage,
    this.description,
    this.createdBy,
    this.saveIn = 0,
  }) : coverImage = null,
       isPublic = true,
       userId = null,
       createdAt = null;

  // Formato de duración total legible (ej: "1h 23m" o "45m")
  String get formattedDuration {
    if (totalDuration <= 0) return '0m';
    
    final hours = totalDuration ~/ 3600;
    final minutes = (totalDuration % 3600) ~/ 60;
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  // Texto descriptivo del contenido
  String get contentDescription {
    return '$songCount canciones';
  }
}