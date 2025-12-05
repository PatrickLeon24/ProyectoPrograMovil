import 'package:flutter/material.dart';
import 'package:waveul/models/artist.dart';

class ArtistsList extends StatelessWidget {
  final List<Artist> artists;
  final Function(int artistId, bool follow)? onToggleFollow;

  const ArtistsList({super.key, required this.artists, this.onToggleFollow});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: artists.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (_, i) {
        final a = artists[i];

        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/Artist_icon.jpg'),
          ),
          title: Text(
            a.stageName,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.shadow,
            ),
          ),
          subtitle: Text(
            a.isBand ? 'Banda' : 'Artista',
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
                onPressed: () {
                  final newFollow = !a.followed;
                  onToggleFollow?.call(a.id, newFollow);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color:
                        a.followed
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(50),
                    border:
                        a.followed
                            ? null
                            : Border.all(
                              color: Theme.of(context).colorScheme.shadow,
                            ),
                  ),
                  child: Text(
                    a.followed ? "Siguiendo" : "Seguir",
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
            Navigator.pushNamed(context, '/ver_artista', arguments: a.id);
          },
        );
      },
    );
  }
}
