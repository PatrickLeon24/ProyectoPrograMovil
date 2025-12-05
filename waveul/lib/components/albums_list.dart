import 'package:flutter/material.dart';
import 'package:waveul/models/album.dart';

class AlbumsList extends StatelessWidget {
  final List<Album> albums;
  final Function(int albumId, bool saved)? onToggleSave;

  const AlbumsList({super.key, required this.albums, this.onToggleSave});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: albums.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final album = albums[i];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(album.coverImage),
          ),
          title: Text(
            album.name,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.shadow,
            ),
          ),
          subtitle: Text(
            album.artist?.stageName ?? 'Album',
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
                  final newSaved = !album.saved;
                  onToggleSave?.call(album.id, newSaved);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color:
                        album.saved
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(50),
                    border:
                        album.saved
                            ? null
                            : Border.all(
                              color: Theme.of(context).colorScheme.shadow,
                            ),
                  ),
                  child: Text(
                    album.saved ? "Guardado" : "Guardar",
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
        );
      },
    );
  }
}
