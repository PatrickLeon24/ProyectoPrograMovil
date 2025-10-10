import 'package:flutter/material.dart';

class RegistroUsuarioPage extends StatelessWidget {
  // 🔹 Header con logo y título
  Widget _header(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/text1.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),

        const Text(
          "Registrarse",
          style: TextStyle(
            fontSize: 30,
            
          ),
        ),
        const SizedBox(height: 10),

        // Los dos puntitos de progreso
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 🔹 Formulario
  Widget _form(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 30),

        // Nombres
        TextFormField(
          decoration: InputDecoration(
            hintText: "Nombres",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Apellidos
        TextFormField(
          decoration: InputDecoration(
            hintText: "Apellidos",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Correo
        TextFormField(
          decoration: InputDecoration(
            hintText: "Correo Electrónico",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Contraseña
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Ingresar Contraseña",
            suffixIcon: const Icon(Icons.visibility_off),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Confirmar contraseña
        TextFormField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: "Confirmar Contraseña",
            suffixIcon: const Icon(Icons.visibility_off),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Fecha de nacimiento
        TextFormField(
          decoration: InputDecoration(
            hintText: "Fecha De Nacimiento",
            suffixIcon: const Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
        const SizedBox(height: 15),

        // Teléfono
        TextFormField(
          decoration: InputDecoration(
            hintText: "Teléfono",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 30),

        // Botón siguiente
        SizedBox(
          height: 80,
          child: ElevatedButton(
            
            onPressed: () {Navigator.pushNamed(context, '/registro_usuario2');},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Siguiente",
              style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 Footer
  Widget _footer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿Ya Tienes Una Cuenta? "),
        GestureDetector(
          onTap: () {
            // Navegar a login
          },
          child: Text(
            "Inicia Sesión",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // 🔹 Cuerpo
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
                const SizedBox(height: 30),
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
        backgroundColor: Colors.white,
        body: _buildBody(context),
      ),
    );
  }
}
