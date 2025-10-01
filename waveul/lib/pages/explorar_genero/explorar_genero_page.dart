import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'explorar_genero_controller.dart';
//Necesitamos importar cada genero de una lista
import 'package:waveul/pages/item_genero/item_genero_page.dart';

class ExplorarGeneroPage extends StatelessWidget {
  ExplorarGeneroController control = Get.put(ExplorarGeneroController());

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
        Text(
          "Buscar",
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 30),
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
            prefixIcon: Icon(Icons.search),
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  }

  Widget _content(BuildContext context) {
    //Provisional porque lo pienso componetizar por item ojo
    /*
    final List<Map<String, String>> generos = [
      {'nombre': 'Pop'},
      {'nombre': 'Rock'},
      {'nombre': 'Hip Hop'},
      {'nombre': 'Electrónica'},
      {'nombre': 'Jazz'},
      {'nombre': 'Clásico'},
      {'nombre': 'Reggaeton'},
      {'nombre': 'Alternativo'},
      {'nombre': 'Trap'},
      {'nombre': 'Punk'},
    ];*/

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Generos",
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20),
        ),
        const SizedBox(height: 30),
        //aca es donde quiero importar cada genero como item
        /*
        Flexible(
          child: ListView.builder(
            itemCount: generos.length, // Cuantos géneros hay
            itemBuilder: (context, index) {
              final genero = generos[index]; // Obtener el género por su índice
              return Card(
                margin: const EdgeInsets.all(8.0),
                color: Theme.of(context).colorScheme.onSurface,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      Text(genero['nombre']!, style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        */
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
    return MaterialApp(
      home: Scaffold(backgroundColor: Colors.white, body: _buildBody(context)),
    );
  }
}
