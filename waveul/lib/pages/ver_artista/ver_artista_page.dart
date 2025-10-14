import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ver_artista_controller.dart';

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

class VerArtistaPage extends StatelessWidget {
  final VerArtistaController control = Get.put(VerArtistaController());

  final List<Song> songs = [
    Song(
      title: 'The Scientist',
      subtitle: 'Canción · Coldplay',
      coverAsset: 'assets/images/scientist.jpg',
      liked: true,
    ),
    Song(
      title: 'A Sky Full Of Stars',
      subtitle: 'Canción · Coldplay',
      coverAsset: 'assets/images/sky.jpg',
    ),
    Song(
      title: 'A Sky Full Of Stars',
      subtitle: 'Canción · Coldplay',
      coverAsset: 'assets/images/sky.jpg',
    ),
  ];

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
        Center(
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
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //Revisar
  Widget _contentBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Text(
          "Canciones",
          style: TextStyle(
            fontSize: 24,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: songs.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) {
            final s = songs[i];
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(s.coverAsset),
              ),
              title: Text(
                s.title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(s.subtitle),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: s.liked ? Colors.teal : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      /* setState(() => s.liked = !s.liked); */
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.play_arrow),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
              onTap: () {},
            );
          },
        ),

        const SizedBox(height: 12),
        TextButton(
          onPressed: () {},
          child: Text(
            "Escuchar Todo",
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              fontWeight: FontWeight.w600,
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
              _contentBody(context),
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
