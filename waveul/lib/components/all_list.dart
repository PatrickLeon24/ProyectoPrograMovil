import 'package:flutter/material.dart';
import 'package:waveul/components/albums_list.dart';
import 'package:waveul/components/artists_list.dart';
import 'package:waveul/components/playlists_list.dart';
import 'package:waveul/components/profile_list.dart';
import 'package:waveul/components/songs_list.dart';

class AllList extends StatefulWidget {
  AllList({super.key});

  @override
  State<AllList> createState() => _AllListState();
}

class _AllListState extends State<AllList> {
  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Artistas",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
        ArtistsList(),
        Text(
          "Canciones",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
        SongsList(),
        Text(
          "Albumes",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
        AlbumsList(),
        Text(
          "Playlists",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
        PlaylistsList(),
        Text(
          "Perfiles",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
        ProfilesList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
