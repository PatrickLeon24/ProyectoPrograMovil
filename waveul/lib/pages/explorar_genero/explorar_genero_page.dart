import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveul/pages/explorar_musica/explorar_musica_page.dart';
import 'explorar_genero_controller.dart';
//Necesitamos importar cada genero de una lista
import 'package:waveul/components/item_genero_page.dart';

class ExplorarGeneroPage extends StatelessWidget {
  final ExplorarGeneroController control = Get.put(ExplorarGeneroController());

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
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).colorScheme.surface,
              ),
              onPressed: () => Navigator.pushNamed(context, '/home'),
            ),
            Text(
              "Buscar",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 30,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            hintText: "¿Que quieres escuchar?",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 15,
            ),
            prefixIcon: IconButton(
              onPressed:
                  () => {Navigator.pushNamed(context, '/explorar_musica')},
              icon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Obx(() {
      if (control.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Géneros",

            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
            ),
            itemCount: control.genres.length,
            itemBuilder: (context, index) {
              final genre = control.genres[index];
              print(genre);
              return ItemGeneroPage(
                nombre: genre.name,
                color: genre.color,
                descripcion: genre.description,
              );
            },
          ),
        ],
      );
    });
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_header(context), _navbar(context), _content(context)],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _buildBody(context));
  }
}
