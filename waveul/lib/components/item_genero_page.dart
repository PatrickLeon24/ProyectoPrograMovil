import 'package:flutter/material.dart';

class ItemGeneroPage extends StatelessWidget {
  final String nombre;
  final String color;

  ItemGeneroPage({required this.nombre, required this.color, super.key});

  int convertirHexAColor(String cadena) {
    cadena = cadena.substring(2, cadena.length);
    print(int.parse(cadena, radix: 16));
    return int.parse(cadena, radix: 16);
  }

  Widget _buildBody(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: Color(convertirHexAColor(color)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Ahora imagen
              Text(
                nombre,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
