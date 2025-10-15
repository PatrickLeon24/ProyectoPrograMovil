import 'package:flutter/material.dart';

class Song {
  final String title;
  final String subtitle; // "Canción · Coldplay"
  final String coverAsset; // assets/images/...
  bool liked;
  Song({
    required this.title,
    required this.subtitle,
    required this.coverAsset,
    this.liked = false,
  });
}

class SongsList extends StatefulWidget {
  SongsList({super.key});

  @override
  State<SongsList> createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  final List<Song> songs = [
    Song(
      title: 'CancionGenerica1',
      subtitle: 'Canción · Artista',
      coverAsset: 'assets/images/song_icon.jpg',
      liked: true,
    ),
    Song(
      title: 'CancionGenerica2',
      subtitle: 'Canción · Artista',
      coverAsset: 'assets/images/song_icon.jpg',
    ),
    Song(
      title: 'CancionGenerica3',
      subtitle: 'Canción · Artista',
      coverAsset: 'assets/images/song_icon.jpg',
    ),
  ];
  int _selected = 0;

  Widget _buildBody(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final s = songs[i];
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
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color:
                      s.liked
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.primaryFixedDim,
                  size: 26,
                ),
                onPressed: () {
                  /* setState(() => s.liked = !s.liked); */
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.play_arrow,
                  color: Theme.of(context).colorScheme.primaryFixedDim,
                  size: 32,
                ),
                onPressed: () {},
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
