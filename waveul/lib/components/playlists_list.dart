import 'package:flutter/material.dart';

class Playlist {
  final String title;
  final String subtitle; // "Canción · Coldplay"
  final String coverAsset; // assets/images/...
  bool saved;
  Playlist({
    required this.title,
    required this.subtitle,
    required this.coverAsset,
    this.saved = false,
  });
}

class PlaylistsList extends StatefulWidget {
  PlaylistsList({super.key});

  @override
  State<PlaylistsList> createState() => _PlaylistsListState();
}

class _PlaylistsListState extends State<PlaylistsList> {
  final List<Playlist> Playlists = [
    Playlist(
      title: 'Mi playlist',
      subtitle: 'Playlist',
      coverAsset: 'assets/images/workout_playlist.png',
      saved: false,
    ),
    Playlist(
      title: 'Playlist Chill',
      subtitle: 'Playlist',
      coverAsset: 'assets/images/workout_playlist.png',
      saved: false,
    ),
    Playlist(
      title: 'Entrenamiento 😎',
      subtitle: 'Playlist',
      coverAsset: 'assets/images/workout_playlist.png',
      saved: false,
    ),
  ];

  Widget _buildBody(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Playlists.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final s = Playlists[i];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(s.coverAsset),
          ),
          title: Text(
            s.title,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.shadow,
            ),
          ),
          subtitle: Text(
            s.subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () => setState(() => s.saved = !s.saved),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color:
                        s.saved
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(50),
                    border:
                        s.saved
                            ? null
                            : Border.all(
                              color: Theme.of(context).colorScheme.shadow,
                            ),
                  ),
                  child: Text(
                    s.saved ? "Guardado" : "Guardar",
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
          onTap: () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
