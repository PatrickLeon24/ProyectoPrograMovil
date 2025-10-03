import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waveul/models/genre.dart';

class GenreCard extends StatelessWidget {
  final Genre genre;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const GenreCard({
    super.key,
    required this.genre,
    this.onTap,
    this.width = 160, // Ancho fijo de 160
    this.height = 135, // Alto fijo de 135
  });

  Widget _buildCoverImage() {
    // Si tiene imagen de red
    if (genre.coverImage != null) {
      return Image.network(
        genre.coverImage!,
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
    // Usar kanye.png para todas las tarjetas como prueba
    return Image.asset(
      "assets/images/kanye.png",
      fit: BoxFit.cover,
      errorBuilder: (context, exception, stackTrace) {
        return _buildPlaceholder();
      },
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: genre.gradientColors,
        ),
      ),
      child: const Icon(
        Icons.music_note,
        size: 40,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Fondo con degradado
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: genre.gradientColors,
                    ),
                  ),
                ),
              ),
              
              // Imagen del artista/género (puede superponerse al texto)
              if (genre.localImage != null || genre.coverImage != null)
                Positioned(
                  right: -20, // Posicionada para que sobresalga un poco
                  bottom: -10,
                  top: 20,
                  child: Opacity(
                    opacity: 0.8, // Semi-transparente para que el texto sea legible
                    child: SizedBox(
                      width: 120,
                      child: _buildCoverImage(),
                    ),
                  ),
                ),
              
              // Texto del género - Solo nombre
              Positioned(
                left: 16,
                top: 16,
                right: 60, // Espacio para que no choque mucho con la imagen
                child: Text(
                  genre.name,
                  style: GoogleFonts.poppins(
                    fontSize: 28, // Aumentado para que se vea más prominente
                    fontWeight: FontWeight.w700, // Bold
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}