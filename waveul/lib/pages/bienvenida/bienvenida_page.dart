import 'package:flutter/material.dart';

class BienvenidaPage extends StatelessWidget {
  // El encabezado con el logo
  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),
        Image.asset(
          "assets/images/LogoConNombre.png", // tu logo con nombre
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  // Este es el eslogan
  Widget _textSection(BuildContext context) {
    return Column(
      children: [
        Text(
          "Sumérgete En La Música",
          style: TextStyle(
            fontSize: 25,
            color: Theme.of(context).colorScheme.secondary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            "WaveUL conecta artistas y oyentes en una experiencia musical social",
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
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
            Navigator.pushNamed(context, '/registro_usuario1');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          ),
          child: Text(
            "Registrarse",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(width: 20),

        // Botón iniciar sesión
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/iniciar_sesion');
          },
          child: Text(
            "Iniciar sesión",
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.shadow,
              fontWeight: FontWeight.normal,
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
          Text(
            "¿Eres Artista? ",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/registro_artista1');
            },
            child: Text(
              "Regístrate Aquí",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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
      home: Scaffold(backgroundColor: Colors.white, body: _buildBody(context)),
    );
  }
}
