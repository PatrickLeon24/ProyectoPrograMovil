import 'package:flutter/material.dart';
import 'package:waveul/models/artist.dart';
import 'package:waveul/models/song.dart';
import 'package:waveul/models/album.dart';
import 'package:waveul/models/playlist_final.dart';
import 'package:waveul/models/song_final.dart';
import 'package:waveul/models/user.dart';

import 'package:waveul/components/artists_list.dart';
import 'package:waveul/components/songs_list.dart';
import 'package:waveul/components/albums_list.dart';
import 'package:waveul/components/playlists_list.dart';
import 'package:waveul/components/profile_list.dart';

class AllList extends StatelessWidget {
  final List<Artist> artists;
  final List<SongFinal> songs;
  final List<Album> albums;
  final List<PlaylistFinal> playlists;
  final List<User> profiles;

  final void Function(int artistId, bool follow)? onToggleFollowArtist;
  final void Function(int songId, bool liked)? onToggleLikeSong;
  final void Function(int albumId, bool saved)? onToggleSaveAlbum;
  final void Function(int playlistId, bool saved)? onToggleSavePlaylist;
  final void Function(int userId, bool follow)? onToggleFollowUser;

  const AllList({
    super.key,
    required this.artists,
    required this.songs,
    required this.albums,
    required this.playlists,
    required this.profiles,
    this.onToggleFollowArtist,
    this.onToggleLikeSong,
    this.onToggleSaveAlbum,
    this.onToggleSavePlaylist,
    this.onToggleFollowUser,
  });

  @override
  Widget build(BuildContext context) {
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
        ArtistsList(artists: artists, onToggleFollow: onToggleFollowArtist),

        Text(
          "Canciones",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
        SongsList(songs: songs, onToggleLike: onToggleLikeSong),

        Text(
          "Álbumes",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
        AlbumsList(albums: albums, onToggleSave: onToggleSaveAlbum),

        Text(
          "Playlists",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
        PlaylistsList(playlists: playlists, onToggleSave: onToggleSavePlaylist),

        Text(
          "Perfiles",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
        ProfilesList(profiles: profiles, onToggleFollow: onToggleFollowUser),
      ],
    );
  }
}
