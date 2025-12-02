import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistroUsuarioPage extends StatelessWidget {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  RegistroUsuarioPage({super.key});

  // ---------------- HEADER ----------------
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
        const SizedBox(height: 8),

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
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------- FORM ----------------
  Widget _form(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 30),

        // Nombres
        TextFormField(
          controller: nameController,
          decoration: _inputDecoration("Nombres"),
        ),
        const SizedBox(height: 15),

        // Apellidos
        TextFormField(
          controller: lastNameController,
          decoration: _inputDecoration("Apellidos"),
        ),
        const SizedBox(height: 15),

        // Correo
        TextFormField(
          controller: emailController,
          decoration: _inputDecoration("Correo Electrónico"),
        ),
        const SizedBox(height: 15),

        // Contraseña
        TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: _inputDecoration("Ingresar Contraseña")
              .copyWith(suffixIcon: const Icon(Icons.visibility_off)),
        ),
        const SizedBox(height: 15),

        // Fecha de nacimiento
        TextFormField(
          controller: birthDateController,
          decoration: _inputDecoration("Fecha de nacimiento")
              .copyWith(suffixIcon: const Icon(Icons.calendar_today)),
        ),
        const SizedBox(height: 15),

        // Teléfono
        TextFormField(
          controller: phoneController,
          keyboardType: TextInputType.phone,
          decoration: _inputDecoration("Teléfono"),
        ),
        const SizedBox(height: 30),

        // Botón siguiente
        SizedBox(
          height: 80,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/registro_usuario2',
                arguments: {
                  'name': nameController.text,
                  'lastName': lastNameController.text,
                  'email': emailController.text,
                  'password': passwordController.text,
                  'birthDate': birthDateController.text,
                  'phone': phoneController.text,
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Siguiente",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- FOOTER ----------------
  Widget _footer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("¿Ya Tienes Una Cuenta? "),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/iniciar_sesion');
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

  // ---------------- INPUT DECORATION ----------------
  InputDecoration _inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
      );

  // ---------------- BODY ----------------
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

          // Botón retroceso circular
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

  // ---------------- BUILD ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }
}
