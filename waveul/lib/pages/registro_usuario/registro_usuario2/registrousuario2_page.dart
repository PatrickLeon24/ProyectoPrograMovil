import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveul/pages/registro_usuario/registro_usuario1/registrousuario_controller.dart';

class RegistroUsuario2Page extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final RegistroUsuarioController controller = Get.put(RegistroUsuarioController());

  RegistroUsuario2Page({super.key});

  Widget _header(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        Image.asset(
          'assets/images/text1.png',
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

        // 🔹 Puntos de progreso
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
            hintText: "Ingresa un nombre de usuario",
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
        Obx(() {
          return SizedBox(
            width: double.infinity,
            height: 80,
            child: ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () async {
                      // Aquí luego pasarás los datos reales del paso 1
                      await controller.registrarUsuario(
                        username: usernameController.text,
                        nombres: 'Nombres',
                        apellidos: 'Apellidos',
                        email: 'correo@ejemplo.com',
                        password: '123456',
                        fechaNacimiento: '2000-01-01',
                        telefono: '999999999',
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
                shadowColor: Colors.grey.shade400,
              ),
              child: controller.isLoading.value
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Finalizar Registro",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
            ),
          );
        }),

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
                  _header(context),
                  _form(context),
                ],
              ),
            ),
          ),

          // 🔙 Botón de retroceso
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
