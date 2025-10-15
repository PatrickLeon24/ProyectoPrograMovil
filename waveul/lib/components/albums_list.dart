import 'package:flutter/material.dart';

class Album {
  final String title;
  final String subtitle; // "Canción · Coldplay"
  final String coverAsset; // assets/images/...
  bool liked;

  Album({
    required this.title,
    required this.subtitle,
    required this.coverAsset,
    this.liked = false,
  });
}

class AlbumsList extends StatefulWidget {
  AlbumsList({super.key});

  @override
  State<AlbumsList> createState() => _AlbumsListState();
}

class _AlbumsListState extends State<AlbumsList> {
  final List<Album> Albums = [
    Album(
      title: 'Album1',
      subtitle: 'Artista',
      coverAsset: 'assets/images/Album_icon.jpg',
      liked: true,
    ),
    Album(
      title: 'Album2',
      subtitle: 'Artista',
      coverAsset: 'assets/images/Album_icon.jpg',
    ),
    Album(
      title: 'Album3',
      subtitle: 'Artista',
      coverAsset: 'assets/images/Album_icon.jpg',
    ),
  ];
  int _selected = 0;

  Widget _buildBody(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Albums.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final s = Albums[i];
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
                onPressed: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(),
                  ),
                  child: Text(
                    "Guardar",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
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
