import 'package:flutter/material.dart';

class RecuperarCuenta3Page extends StatefulWidget {
  const RecuperarCuenta3Page({super.key});

  @override
  State<RecuperarCuenta3Page> createState() => _RecuperarCuenta3PageState();
}

class _RecuperarCuenta3PageState extends State<RecuperarCuenta3Page> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Widget _form(BuildContext context) {
    return Column(
      children: [
        // 🔹 Campo Nueva Contraseña
        TextFormField(
          controller: passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: "Nueva Contraseña",
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
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

        const SizedBox(height: 20),

        // 🔹 Campo Confirmar Nueva Contraseña
        TextFormField(
          controller: confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            hintText: "Confirmar Nueva Contraseña",
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
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

        // 🔹 Botón Reestablecer Contraseña
        SizedBox(
          width: double.infinity,
          height: 80,
          child: ElevatedButton(
            onPressed: () {
              // Acción: reestablecer contraseña
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Reestablecer Contraseña",
              style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.normal),
            ),
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }

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
          "Crear Nueva Contraseña",
          style: TextStyle(
            fontSize: 30,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 40),
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
                  const SizedBox(height: 30),
                  _header(context),
                  _form(context),
                ],
              ),
            ),
          ),

          // 🔹 Botón circular de retroceso (igual a RecuperarCuenta2Page)
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
