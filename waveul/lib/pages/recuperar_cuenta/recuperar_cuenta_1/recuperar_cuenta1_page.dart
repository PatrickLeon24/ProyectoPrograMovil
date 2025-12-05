import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveul/pages/recuperar_cuenta/recuperar_cuenta_1/recuperar_cuenta1_controller.dart';

class RecuperarCuenta1Page extends StatelessWidget {
  RecuperarCuenta1Page({super.key});

  final TextEditingController emailController = TextEditingController();

  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Image.asset(
          'assets/images/text1.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 30),
        const Text(
          "¿Olvidaste Tu Contraseña?",
          style: TextStyle(fontSize: 27, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        const Text(
          "Ingresa Tu Correo Electrónico Para Reestablecerla",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _form(BuildContext context) {
    final controller = Get.put(RecuperarCuenta1Controller());

    return Column(
      children: [
        TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Ingrese Correo Electrónico",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 25,
            ),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          height: 80,
          child: ElevatedButton(
            onPressed: () {
              controller.sendCode(emailController.text.trim());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Enviar código",
              style: TextStyle(
                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.normal),
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
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black87),
              onPressed: () => Navigator.pop(context),
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
