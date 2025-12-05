import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemGeneroPage extends StatelessWidget {
  final String nombre;
  final String color;
  final String descripcion;
  ItemGeneroPage({
    required this.nombre,
    required this.color,
    this.descripcion = '',
    super.key,
  });

  int convertirHexAColor(String cadena) {
    cadena = cadena.substring(2, cadena.length);
    print(int.parse(cadena, radix: 16));
    return int.parse(cadena, radix: 16);
  }

  void _showGeneroDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(nombre),
          content: Text(
            descripcion.isNotEmpty
                ? descripcion
                : 'Aún no hay una descripción para este género.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showGeneroDialog(context);
      },
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            color: Color(convertirHexAColor(color)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }
}
