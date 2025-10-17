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
    //Provisional porque lo pienso poner a json

    final List<Map<String, dynamic>> generos = [
      {'nombre': 'Pop', 'color': '0xFF00B4D8'},
      {'nombre': 'Rock', 'color': '0xFF212121'},
      {'nombre': 'Hip Hop', 'color': '0xFFFF9800'},
      {'nombre': 'Electrónica', 'color': '0xFF9C27B0'},
      {'nombre': 'Jazz', 'color': '0xFF1A237E'},
      {'nombre': 'Clásico', 'color': '0xFF2C3E50'},
      {'nombre': 'Reggaeton', 'color': '0xFFF44336'},
      {'nombre': 'Alternativo', 'color': '0xFF4CAF50'},
      {'nombre': 'Trap', 'color': '0xFF1A237E'},
      {'nombre': 'Punk', 'color': '0xFFD81B60'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Generos",
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
        ),
        const SizedBox(height: 20),

        //aca es donde quiero importar cada genero como item
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15.0,
            mainAxisSpacing: 15.0,
          ),
          itemCount: generos.length,
          itemBuilder: (context, index) {
            final genero = generos[index];
            return ItemGeneroPage(
              nombre: genero['nombre'],
              color: genero['color'],
            );
          },
        ),
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
