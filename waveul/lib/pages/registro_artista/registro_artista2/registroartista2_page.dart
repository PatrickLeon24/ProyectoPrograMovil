import 'package:flutter/material.dart';

enum ArtistType { solista, banda }

class RegistroArtista2Page extends StatefulWidget {
  const RegistroArtista2Page({super.key});

  @override
  State<RegistroArtista2Page> createState() => _RegistroArtista2PageState();
}

class _RegistroArtista2PageState extends State<RegistroArtista2Page> {
  ArtistType? _selectedType;
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

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

                    // 🔹 Logo
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/text1.png',
                          height: 40, // igual que login
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
                    ),

                    const SizedBox(height: 30),

                    // 🔹 Elección Solista / Banda
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Solista
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedType = ArtistType.solista;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _selectedType == ArtistType.solista
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  'assets/images/SingleSinger.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _selectedType == ArtistType.solista
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color: Theme.of(context).primaryColor,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text("Solista"),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 30),

                        // Banda
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedType = ArtistType.banda;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: _selectedType == ArtistType.banda
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  'assets/images/Band.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _selectedType == ArtistType.banda
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color: Theme.of(context).primaryColor,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text("Banda"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // 🔹 Fecha de inicio con calendario interactivo
                    TextFormField(
                      controller: fechaController,
                      readOnly: true, // 🔹 evita abrir teclado
                      decoration: InputDecoration(
                        hintText: "Fecha De Inicio",
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).primaryColor,
                          ),
                          onPressed: () async {
                            // 📅 Mostrar calendario
                            try {
                              final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2100),
                                locale: const Locale("es", "ES"),
                              );

                              print("Resultado del showDatePicker: $picked");

                              if (picked != null) {
                                setState(() {
                                  fechaController.text =
                                      "${picked.day}/${picked.month}/${picked.year}";
                                });
                              }
                            } catch (e, stacktrace) {
                              print("⚠️ Error al abrir calendario: $e");
                              print(stacktrace);
                            }

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

                    // 🔹 Biografía
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Biografía",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: bioController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText:
                            "Describe Tu Journey Artístico Y Lo Que Representa Tu Música...",
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.all(15),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // 🔹 Botón siguiente (estilo login)
                    SizedBox(
                      height: 80,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/registro_artista3');
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
