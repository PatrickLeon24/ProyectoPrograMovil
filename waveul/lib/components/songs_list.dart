import 'package:flutter/material.dart';
import 'package:waveul/models/song_final.dart';

class SongsList extends StatelessWidget {
  final List<SongFinal> songs;
  final Function(int songId, bool liked)? onToggleLike;

  const SongsList({super.key, required this.songs, this.onToggleLike});

  @override
  Widget build(BuildContext context) {
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
            // si en backend guardas imagen:
            // backgroundImage: NetworkImage(s.coverImage),
            backgroundImage: AssetImage("assets/images/Song_icon.jpg"),
          ),

          title: Text(
            s.name,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.shadow,
            ),
          ),

          subtitle: Text(
            s.artists.isNotEmpty ? s.artists.first.stageName : "Artista",
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
                  final newLiked = !s.liked;
                  onToggleLike?.call(s.id, newLiked);
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
        );
      },
    );
  }
}
