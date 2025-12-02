import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveul/pages/registro_usuario/registro_usuario1/registrousuario_controller.dart';

class RegistroUsuario2Page extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final RegistroUsuarioController controller =
      Get.put(RegistroUsuarioController());

  RegistroUsuario2Page({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Datos traídos desde la pantalla 1
    final Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _header(),
                    _form(context, data),
                  ],
                ),
              ),
            ),

            // 🔙 Botón atrás
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        const SizedBox(height: 40),
        Image.asset('assets/images/text1.png', height: 40),
        const SizedBox(height: 8),
        const Text("Registrarse", style: TextStyle(fontSize: 30)),
        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(radius: 5, backgroundColor: Colors.cyan),
            SizedBox(width: 8),
            CircleAvatar(radius: 5, backgroundColor: Colors.cyan),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _form(BuildContext context, Map<String, dynamic> data) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey.shade300,
          child: Image.asset('assets/images/CameraIcon.png', width: 50),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {},
          child: const Text("Subir Foto De Perfil",
              style: TextStyle(color: Colors.cyan)),
        ),

        const SizedBox(height: 20),

        TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
            hintText: "Ingresa un nombre de usuario",
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),

        const SizedBox(height: 40),

        Obx(() {
          return SizedBox(
            width: double.infinity,
            height: 80,
            child: ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () async {
                      await controller.registrarUsuario(
                        name: data['name'],
                        lastName: data['lastName'],
                        email: data['email'],
                        password: data['password'],
                        birthDate: data['birthDate'],
                        phone: data['phone'],
                        username: usernameController.text,
                        profileImage:
                            "https://cdn.waveul.com/avatars/default.png",
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Finalizar Registro",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
            ),
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }
}
