import 'package:flutter/material.dart';

class RecuperarCuenta2Page extends StatelessWidget {
  RecuperarCuenta2Page({super.key});

  final TextEditingController codeController = TextEditingController();

  // 🔹 Header con logo, título y subtítulo
  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Image.asset(
          'assets/images/text1.png', // tu asset del logo
          height: 40,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 30),
        const Text(
          "Código Enviado",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Hemos Enviado Un Código De Verificación A Tu Correo",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  // 🔹 Formulario con campo código y botones
  Widget _form(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: codeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Ingresar Código",
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              // usa el color de onSurface pero más clarito
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Botón Reenviar
            SizedBox(
              height: 80,
              child: OutlinedButton(
                onPressed: () {
                  // Acción: reenviar correo
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: const BorderSide(color: Colors.black, width: 1),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                ),
                
                  
                child: Text(
                  "Reenviar Correo",
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  
                ),
              ),
            ),

            const SizedBox(width: 20),

            // Botón Confirmar
            SizedBox(
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/recuperar_cuenta_3');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                ),
                
                  
                child: Text(
                  "Confirmar",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  // 🔹 Cuerpo principal con Stack (para botón de retroceso flotante)
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Contenido principal
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  _header(context),
                  _form(context),
                ],
              ),
            ),
          ),

          // Botón circular de retroceso
          Positioned(
            top: 10,
            left: 10,
            child: Material(
              color: Colors.transparent,
              shape: const CircleBorder(),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }
}
