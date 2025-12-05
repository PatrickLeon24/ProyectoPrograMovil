import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveul/pages/recuperar_cuenta/recuperar_cuenta_3/recuperar_cuenta3_controller.dart';
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
    final email = Get.arguments;
    final controller = Get.put(RecuperarCuenta3Controller());

    return Column(
      children: [
        TextFormField(
          controller: passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: "Nueva Contraseña",
            suffixIcon: IconButton(
              icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() => _obscurePassword = !_obscurePassword);
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),

        const SizedBox(height: 20),

        TextFormField(
          controller: confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            hintText: "Confirmar Nueva Contraseña",
            suffixIcon: IconButton(
              icon: Icon(_obscureConfirmPassword
                  ? Icons.visibility_off
                  : Icons.visibility),
              onPressed: () {
                setState(() =>
                    _obscureConfirmPassword = !_obscureConfirmPassword);
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),

        const SizedBox(height: 40),

        SizedBox(
          width: double.infinity,
          height: 80,
          child: ElevatedButton(
            onPressed: () {
              if (passwordController.text.trim() !=
                  confirmPasswordController.text.trim()) {
                Get.snackbar("Error", "Las contraseñas no coinciden");
                return;
              }

              controller.resetPassword(
                email,
                passwordController.text.trim(),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              "Reestablecer Contraseña",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Image.asset('assets/images/text1.png', height: 40),
        const SizedBox(height: 30),
        const Text("Crear Nueva Contraseña",
            style: TextStyle(fontSize: 30, color: Colors.black87)),
        const SizedBox(height: 40),
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
    return Scaffold(backgroundColor: Colors.white, body: _buildBody(context));
  }
}
