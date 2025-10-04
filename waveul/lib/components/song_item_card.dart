import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waveul/models/song.dart';

class SongItemCard extends StatefulWidget {
  final Song song;
  final VoidCallback? onTap;
  final VoidCallback? onFavorite;
  final VoidCallback? onPlay;
  final bool initialFavorite;

  const SongItemCard({
    super.key,
    required this.song,
    this.onTap,
    this.onFavorite,
    this.onPlay,
    this.initialFavorite = false,
  });

  @override
  State<SongItemCard> createState() => _SongItemCardState();
}

class _SongItemCardState extends State<SongItemCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavorite;
  }

  Widget _buildCoverImage() {
    // Si tiene imagen de red
    if (widget.song.coverImage != null) {
      return Image.network(
        widget.song.coverImage!,
        width: 140,
        height: 140,
        fit: BoxFit.cover,
        errorBuilder: (context, exception, stackTrace) {
          // Si falla, usar imagen local o placeholder
          return _buildLocalImage();
        },
      );
    }
    // Si no, usar imagen local
    return _buildLocalImage();
  }

  Widget _buildLocalImage() {
    if (widget.song.localImage != null) {
      return Image.asset(
        widget.song.localImage!,
        width: 140,
        height: 140,
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
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(
        Icons.music_note,
        size: 40,
        color: Colors.grey,
      ),
    );
  }

  // Widget _buildRatingStars() {
  //   if (song.rating == null) return const SizedBox.shrink();
  //   
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: List.generate(5, (index) {
  //       return Icon(
  //         index < song.rating!.round() ? Icons.star : Icons.star_border,
  //         size: 12,
  //         color: Colors.amber,
  //       );
  //     }),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la canción con botones superpuestos
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: _buildCoverImage(),
                ),
                
                // Botón de favorito (esquina superior izquierda)
                Positioned(
                  top: 8,
                  left: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                      widget.onFavorite?.call();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Theme.of(context).colorScheme.surface : Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                
                // Botón de play (esquina inferior derecha)
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: widget.onPlay,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            
            // Título de la canción
            Text(
              widget.song.title,
              style: GoogleFonts.roboto(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black // Semibold
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            
            // Artista
            Text(
              widget.song.artist,
              style: GoogleFonts.roboto(
                fontSize: 10,
                fontWeight: FontWeight.w300, // Light
                color: Colors.black,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Duración y rating en una fila
            if (widget.song.duration != null || widget.song.rating != null)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.song.duration != null)
                      Text(
                        widget.song.formattedDuration,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.black,
                        ),
                      ),
                    // if (song.rating != null)
                    //   _buildRatingStars(),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}