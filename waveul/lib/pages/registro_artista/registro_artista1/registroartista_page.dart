import 'package:flutter/material.dart';

class RegistroArtistaPage extends StatefulWidget {
  const RegistroArtistaPage({super.key});

  @override
  State<RegistroArtistaPage> createState() => _RegistroArtistaPageState();
}

class _RegistroArtistaPageState extends State<RegistroArtistaPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(height: 40),

                    // 🔹 Logo y título
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/text1.png', // Logo
                          height: 40, // igual al login
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Registro de Artista",
                          style: TextStyle(
                            fontSize: 30, // igual que login
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(height: 10),
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
                    ),

                    const SizedBox(height: 30),

                    // 🔹 Nombre artístico
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Nombre Artístico",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor, // igual al login
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔹 Correo
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Correo Electrónico",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 25,
                        ),
                        prefixIcon: Icon(Icons.email,color: Theme.of(context).primaryColor,),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔹 Contraseña
                    TextFormField(
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: "Contraseña",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor, 
                        ),
                        prefixIcon: Icon(Icons.lock,color: Theme.of(context).primaryColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                                color: Theme.of(context).primaryColor, // 🔹 Forzamos color plomo
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
                          vertical: 25,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 🔹 Confirmar Contraseña
                    TextFormField(
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        hintText: "Confirmar Contraseña",
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).primaryColor, 
                        ),
                        prefixIcon: Icon(Icons.lock_outline,color: Theme.of(context).primaryColor,),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                                color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 25,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 🔹 Botón siguiente (ahora estilo como login)
                    SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registro_artista2');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.surface,
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

                    const SizedBox(height: 20),

                    // 🔹 Divider con texto "O Puedes"
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "O Puedes",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 🔹 Botón Google
                    GestureDetector(
                      onTap: () {
                        // Acción login con Google
                      },
                      child: Image.asset(
                        'assets/images/GoogleIcon.png',
                        height: 40,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // 🔹 Footer
                    Row(
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
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),

            // 🔹 Botón circular de retroceso (igual al login)
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
      ),
    );
  }
}
