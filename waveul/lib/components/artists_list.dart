import 'package:flutter/material.dart';

class Artist {
  final String title;
  final String subtitle; // "Canción · Coldplay"
  final String coverAsset; // assets/images/...
  bool liked;
  Artist({
    required this.title,
    required this.subtitle,
    required this.coverAsset,
    this.liked = false,
  });
}

class ArtistsList extends StatefulWidget {
  ArtistsList({super.key});

  @override
  State<ArtistsList> createState() => _ArtistsListState();
}

class _ArtistsListState extends State<ArtistsList> {
  final List<Artist> Artists = [
    Artist(
      title: 'Artista1',
      subtitle: 'Artista',
      coverAsset: 'assets/images/Artist_icon.jpg',
    ),
    Artist(
      title: 'Artista2',
      subtitle: 'Artista',
      coverAsset: 'assets/images/Artist_icon.jpg',
    ),
    Artist(
      title: 'Artista3',
      subtitle: 'Artista',
      coverAsset: 'assets/images/Artist_icon.jpg',
    ),
  ];
  bool _isSelected = false;

  Widget _buildBody(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Artists.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final s = Artists[i];
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
              Icon(
                Icons.check_circle_rounded,
                color: Theme.of(context).colorScheme.surface,
                size: 32,
              ),

              TextButton(
                onPressed: () => setState(() => _isSelected = true),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color:
                        _isSelected
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(50),
                    border:
                        _isSelected
                            ? null
                            : Border.all(
                              color: Theme.of(context).colorScheme.shadow,
                            ),
                  ),
                  child: Text(
                    _isSelected ? "Siguiendo" : "Seguir",
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
