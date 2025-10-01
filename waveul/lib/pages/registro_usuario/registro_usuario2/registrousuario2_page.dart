import 'package:flutter/material.dart';

class RegistroUsuario2Page extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();

  RegistroUsuario2Page({super.key});

  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Image.asset(
          'assets/images/text1.png', // Tu logo
          height: 40,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 8),
        const Text(
          "Registrarse",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),

        // 🔹 Puntitos de progreso
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.cyan,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.cyan,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _form(BuildContext context) {
    return Column(
      children: [
        // 🔹 Foto de perfil
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade300,
          child: ClipOval(
            child: Image.asset(
              'assets/images/CameraIcon.png',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () {},
          child: const Text(
            "Subir Foto De Perfil",
            style: TextStyle(
              fontSize: 14,
              color: Colors.cyan,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // 🔹 Campo de usuario
        TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
            hintText: "Ingresa Un Nombre De Usuario",
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),

        const SizedBox(height: 40),

        // 🔹 Botón Finalizar
        SizedBox(
          width: double.infinity,
          height: 80,
          child: ElevatedButton(
            onPressed: () {
              // Acción para finalizar registro
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
              shadowColor: Colors.grey.shade400,
            ),
            child: const Text(
              "Finalizar Registro",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }

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
                  _header(context),
                  _form(context),
                ],
              ),
            ),
          ),

          // 🔹 Botón circular de retroceso (como en RecuperarCuenta3Page)
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
