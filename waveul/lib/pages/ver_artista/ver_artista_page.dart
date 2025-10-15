import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ver_artista_controller.dart';
//Importamos los componentes: SongsList y AlbumsList
import 'package:waveul/components/albums_list.dart';
import 'package:waveul/components/songs_list.dart';

class VerArtistaPage extends StatelessWidget {
  final VerArtistaController control = Get.put(VerArtistaController());

  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Center(
          child: Image.asset(
            "assets/images/text1.png", // tu logo con nombre
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _cover(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/artista_cover.jpg', fit: BoxFit.cover),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 15, left: 12, right: 125),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed:
                          () =>
                              Navigator.pushNamed(context, '/explorar_musica'),
                    ),
                    Spacer(),
                    Text(
                      'Artista',
                      style: TextStyle(
                        fontSize: 40,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _overview(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 25),
        TextButton(
          onPressed: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              "+ Seguir",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 85),
            child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Theme.of(context).colorScheme.shadow,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {},
          child: Text(
            "Mostrar Más",
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  //Revisar
  Widget _contentBodySongs(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Text(
          "Canciones",
          style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
        const SizedBox(height: 12),
        SongsList(),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {},
          child: Text(
            "Escuchar Todo",
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _contentBodyAlbums(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          "Albumes",
          style: TextStyle(
            fontSize: 30,
            color: Theme.of(context).colorScheme.shadow,
          ),
        ),
        const SizedBox(height: 12),
        AlbumsList(),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () {},
          child: Text(
            "Escuchar Todo",
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _header(context),
              _cover(context),
              _overview(context),
              _contentBodySongs(context),
              _contentBodyAlbums(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: _buildBody(context)),
    );
  }
}
