import 'package:flutter/material.dart';

class RecuperarCuenta1Page extends StatelessWidget {
  RecuperarCuenta1Page({super.key});

  final TextEditingController emailController = TextEditingController();

  // 🔹 Header con logo y título
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
          style: TextStyle(
            fontSize: 27,
            
            color: Colors.black87,
          ),
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

  // 🔹 Formulario con campo correo y botón
  Widget _form(BuildContext context) {
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
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              // usa el color de onSurface pero más clarito
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          ),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          height: 80,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/recuperar_cuenta_2');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
  
              
            ),
            child: const Text(
              "Enviar código",
              style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.normal),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  // 🔹 Cuerpo principal con Stack (para botón de retroceso flotante)
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

          // Botón circular de retroceso
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
