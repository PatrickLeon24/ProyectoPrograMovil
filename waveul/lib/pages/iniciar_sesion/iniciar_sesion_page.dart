import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IniciarSesionPage extends StatelessWidget {
  

  // Aquí se presenta el logo y título
  Widget _header(BuildContext context) {
    return Column(
      
      children: [
        const SizedBox(height: 40),
        Image.asset(
          'assets/images/text1.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),

        // Título principal
        const Text(
          "Iniciar Sesión",
          style: TextStyle(
            fontSize: 30,
            
          ),
        ),
        const SizedBox(height: 10),

        // Texto de ayuda con link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Si Necesitas Ayuda Haz ",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            GestureDetector(
              onTap: () {
                // acción click
              },
              child: Text(
                "Click Aquí",
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Formulario
  Widget _form(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 30),

        // Usuario
        TextFormField(
          decoration: InputDecoration(
            hintText: "Ingrese Nombre De Usuario O Correo",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          ),
        ),
        const SizedBox(height: 20),

        // Contraseña
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Contraseña",
            suffixIcon: const Icon(Icons.visibility_off),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          ),
        ),
        const SizedBox(height: 10),

        // Recuperar contraseña
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () {
              // acción click
            },
            child: Text(
              "Recuperar Contraseña",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Botón iniciar sesión
        SizedBox(
          height: 80,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Iniciar sesión",
              style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 Divider con texto "O Puedes"
  Widget _divider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "O Puedes",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  // 🔹 Botón Google
  Widget _googleButton() {
    return GestureDetector(
      onTap: () {
        // acción login con Google
      },
      child: Image.asset(
        'assets/images/GoogleIcon.png',
        height: 40,
      ),
    );
  }

  // registrarse)
  Widget _footer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿Aún No Eres Miembro? "),
        GestureDetector(
          onTap: () {
            // acción click
          },
          child: Text(
            "Regístrate Ahora",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Cuerpo principal
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
                const SizedBox(height: 20),
                _divider(),
                const SizedBox(height: 20),
                _googleButton(),
                const SizedBox(height: 40),
                _footer(context),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),

        // Botón circular de retroceso
        Positioned(
          top: 10, // distancia desde arriba
          left: 10, // distancia desde la izquierda
          child: Material(
            color: Colors.transparent, // fondo transparente
            shape: const CircleBorder(),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () {
                Navigator.pop(context); // vuelve a la pantalla anterior
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white, // <--- esto hace que sea blanco
        body: _buildBody(context),
      ),
    );
}
}
