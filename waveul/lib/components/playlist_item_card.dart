import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waveul/models/playlist.dart';
import 'dart:math';

class PlaylistItemCard extends StatefulWidget {
  final Playlist playlist;
  final VoidCallback? onTap;
  final VoidCallback? onPlay;
  final VoidCallback? onAdd; // Para agregar playlist (como favoritos)
  final bool isAdded; // Si ya fue agregada/guardada

  const PlaylistItemCard({
    super.key,
    required this.playlist,
    this.onTap,
    this.onPlay,
    this.onAdd,
    this.isAdded = false,
  });

  @override
  State<PlaylistItemCard> createState() => _PlaylistItemCardState();
}

class _PlaylistItemCardState extends State<PlaylistItemCard> {
  late bool isAdded;
  late Color vinylColor;

  @override
  void initState() {
    super.initState();
    isAdded = widget.isAdded;
    // Generar color aleatorio para el disco de vinilo
    vinylColor = _generateRandomVinylColor();
  }

  // Generar colores aleatorios para el disco
  Color _generateRandomVinylColor() {
    final colors = [
      Colors.purple,
      Colors.pink,
      Colors.red,
      Colors.orange,
      Colors.amber,
      Colors.green,
      Colors.teal,
      Colors.blue,
      Colors.indigo,
      Colors.deepPurple,
    ];
    final random = Random(widget.playlist.id); // Usar ID para consistencia
    return colors[random.nextInt(colors.length)];
  }

  Widget _buildCoverImage() {
    // Si tiene imagen de red
    if (widget.playlist.coverImage != null) {
      return Image.network(
        widget.playlist.coverImage!,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return _buildLocalImage();
        },
      );
    }
    // Si no, usar imagen local
    return _buildLocalImage();
  }

  Widget _buildLocalImage() {
    if (widget.playlist.localImage != null) {
      return Image.asset(
        widget.playlist.localImage!,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          return _buildPlaceholder();
        },
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            vinylColor.withValues(alpha: 0.8),
            vinylColor.withValues(alpha: 0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.queue_music,
        size: 40,
        color: Colors.white,
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        height: 120, // Altura adecuada para evitar overflow
        child: Stack(
          children: [
            // Caja cyan con información - PRIMERO (fondo)
            Positioned(
              left: 120, // Justo después de la imagen, sin superponerse
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 70, right: 16, top: 16, bottom: 16), // Más espacio a la izquierda para el disco
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface, // Color cyan que usamos
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Row(
                  children: [
                    // Información de la playlist
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Nombre de la playlist
                          Text(
                            widget.playlist.name,
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w900, // Semibold
                              color: Colors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          
                          // Número de canciones
                          Text(
                            widget.playlist.contentDescription,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          
                          // Duración total
                          Text(
                            widget.playlist.formattedDuration,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w300, // Light
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Botones de acción
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Botón de agregar playlist
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isAdded = !isAdded;
                            });
                            widget.onAdd?.call();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isAdded ? Icons.bookmark : Icons.bookmark_border,
                              color: isAdded ? Colors.black : Colors.black54,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // Botón de play
                        GestureDetector(
                          onTap: widget.onPlay,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.play_arrow_rounded,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            // Disco de vinilo - SEGUNDO (medio)
            Positioned(
              left: 60, // Centrado en la unión entre imagen y bloque (120/2 = 60)
              top: 0,
              bottom: 0,
              child: Center(
                child: Container(
                  width: 120, // Misma altura que el contenedor
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: vinylColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.circle,
                        color: Colors.black,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Imagen de la playlist - TERCERO (encima) para que tape la mitad izquierda del disco
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: SizedBox(
                  width: 120,
                  child: _buildCoverImage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}