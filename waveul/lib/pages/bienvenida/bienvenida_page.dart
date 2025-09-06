import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomePage extends StatelessWidget {
  // El encabezado con el logo
  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Image.asset(
          "assets/images/LogoConNombre.png", // tu logo con nombre
          height: 120,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  // Este es el eslogan
  Widget _textSection(BuildContext context) {
    return Column(
      children: const [
        Text(
          "Sumérgete En La Música",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Text(
          "WaveUL conecta artistas y oyentes en una experiencia musical social",
          style: TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
      ],
    );
  }

  // Estos son para los Botones
  Widget _buttons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Botón registrarse
        ElevatedButton(
          onPressed: () {
            // Navegar a SignUp
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          ),
          child: const Text(
            "Registrarse",
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        const SizedBox(width: 20),

        // Botón iniciar sesión
        TextButton(
          onPressed: () {
            // Navegar a Login
          },
          child: const Text(
            "Iniciar sesión",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  // Aquí es el Footer
  Widget _footer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("¿Eres Artista? "),
          GestureDetector(
            onTap: () {
              // Acción para artistas
            },
            child: const Text(
              "Regístrate Aquí",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Cuerpo principal
  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          _header(context),
          _textSection(context),
          _buttons(context),
          const Spacer(),
          _footer(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _buildBody(context),
      ),
    );
  }
}
