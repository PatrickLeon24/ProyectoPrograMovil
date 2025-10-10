import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveul/components/carrousel_item_filter.dart';
import 'explorar_musica_controller.dart';

class ExplorarMusicaPage extends StatelessWidget {
  ExplorarMusicaController control = Get.put(ExplorarMusicaController());

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
                decoration: InputDecoration(
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
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.circle, size: 10, color: Colors.cyan),
            const SizedBox(width: 5),
            Icon(Icons.circle, size: 10, color: Colors.grey),
          ],
        ),
        const SizedBox(height: 20),
        CarrouselItemFilter(),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_header(context), _navbar(context), _filter(context)],
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
