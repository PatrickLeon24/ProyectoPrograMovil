import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveul/pages/recuperar_cuenta/recuperar_cuenta_2/recuperar_cuenta2_controller.dart';

class RecuperarCuenta2Page extends StatelessWidget {
  RecuperarCuenta2Page({super.key});

  final TextEditingController codeController = TextEditingController();

  @override
  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Image.asset('assets/images/text1.png', height: 40, fit: BoxFit.contain),
        const SizedBox(height: 30),
        const Text(
          "Código Enviado",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

  Widget _form(BuildContext context) {
    final email = Get.arguments;
    final controller = Get.put(RecuperarCuenta2Controller());

    return Column(
      children: [
        TextFormField(
          controller: codeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Ingresar Código",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
        ),
        const SizedBox(height: 40),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
              child: OutlinedButton(
                onPressed: () {
                  controller.verifyCode(email, codeController.text.trim());
                },
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                ),
                child: const Text("Reenviar Correo", style: TextStyle(color: Colors.black)),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              height: 80,
              child: ElevatedButton(
                onPressed: () {
                  controller.verifyCode(email, codeController.text.trim());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.surface,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                ),
                child: const Text("Confirmar",
                    style: TextStyle(fontSize: 14, color: Colors.white)),
              ),
            ),
          ],
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
