import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'explorar_musica_controller.dart';
//importar carrusel con los 6 filtros
import 'package:waveul/components/carrousel_item_filter.dart';
//importar los 6 componentes de filtro
import 'package:waveul/components/all_list.dart';
import 'package:waveul/components/artists_list.dart';
import 'package:waveul/components/songs_list.dart';
import 'package:waveul/components/albums_list.dart';
import 'package:waveul/components/playlists_list.dart';
import 'package:waveul/components/profile_list.dart';

class ExplorarMusicaPage extends StatefulWidget {
  const ExplorarMusicaPage({super.key});
  @override
  State<ExplorarMusicaPage> createState() => _ExplorarMusicaPageState();
}

class _ExplorarMusicaPageState extends State<ExplorarMusicaPage> {
  final ExplorarMusicaController control = Get.put(ExplorarMusicaController());

  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Image.asset(
            "assets/images/text1.png",
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _navbar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/explorar_genero');
              },
              icon: Icon(Icons.arrow_back),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextFormField(
                onChanged: (value) => control.searchAll(value),
                decoration: InputDecoration(
                  hintText: "Puedes buscar artistas, canciones, albums, etc",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _filter(BuildContext context) {
    return Column(
      children: [
        CarrouselItemFilter(
          onItemSelected: (index) {
            control.changeTab(index);
          },
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Obx(() {
      if (control.isSearching.value) {
        return const Center(child: CircularProgressIndicator());
      }

      switch (control.selectedTab.value) {
        case 0:
          // 🔹 Tienes que ajustar AllList para que reciba estas listas
          return AllList(
            artists: control.artists,
            songs: control.songs,
            albums: control.albums,
            playlists: control.playlists,
            profiles: control.profiles,
          );
        case 1:
          return ArtistsList(artists: control.artists);
        case 2:
          return SongsList(songs: control.songs);
        case 3:
          return AlbumsList(albums: control.albums);
        case 4:
          return PlaylistsList(playlists: control.playlists);
        case 5:
          return ProfilesList(profiles: control.profiles);
        default:
          return const Text("Error 404: No se encontró la página solicitada");
      }
    });
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              _navbar(context),
              _filter(context),
              _content(context),
            ],
          ),
        ),
      ),
    );
  }

  //Por cada pagina considerar el componente Scaffold y no
  //el MaterialApp sino sobreescribe el tema de color definido por uno default
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _buildBody(context));
  }
}
