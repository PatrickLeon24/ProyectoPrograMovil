import 'package:flutter/material.dart';
import 'package:waveul/models/playlist_final.dart';

class PlaylistsList extends StatelessWidget {
  final List<PlaylistFinal> playlists;
  final Function(int playlistId, bool saved)? onToggleSave;

  const PlaylistsList({super.key, required this.playlists, this.onToggleSave});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: playlists.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final p = playlists[i];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: CircleAvatar(
            radius: 24,
            // si coverImage es una URL:
            // backgroundImage: NetworkImage(p.coverImage),
            // si solo es nombre de archivo local:
            backgroundImage: AssetImage('assets/images/workout_playlist.png'),
          ),
          title: Text(
            p.name,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.shadow,
            ),
          ),
          subtitle: Text(
            p.owner?.username ?? 'Playlist', // o p.owner.name
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  final newSaved = !p.saved;
                  onToggleSave?.call(p.id, newSaved);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color:
                        p.saved
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(50),
                    border:
                        p.saved
                            ? null
                            : Border.all(
                              color: Theme.of(context).colorScheme.shadow,
                            ),
                  ),
                  child: Text(
                    p.saved ? "Guardado" : "Guardar",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.shadow,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).colorScheme.shadow,
                ),
                onPressed: () {},
              ),
            ],
          ),
          onTap: () {
            // Aquí luego puedes navegar a la vista de detalle de playlist
          },
        );
      },
    );
  }
}
