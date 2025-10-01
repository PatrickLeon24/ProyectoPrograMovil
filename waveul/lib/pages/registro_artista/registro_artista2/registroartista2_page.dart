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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),

                // 🔹 Botón de retroceso
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),

                const SizedBox(height: 10),

                // 🔹 Logo y puntos de progreso
                Column(
                  children: [
                    Image.asset(
                      'assets/images/text1.png', // logo WaveUL
                      height: 80,
                      fit: BoxFit.contain,
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
                                    ? Colors.cyan
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              'assets/images/SingleSinger.png', // tu asset solista
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
                                color: Colors.black87,
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
                                    ? Colors.cyan
                                    : Colors.grey.shade400,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              'assets/images/Band.png', // tu asset banda
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
                                color: Colors.black87,
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

                // 🔹 Fecha de inicio
                TextFormField(
                  controller: fechaController,
                  decoration: InputDecoration(
                    hintText: "Fecha De Inicio",
                    suffixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                  keyboardType: TextInputType.datetime,
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                  ),
                ),

                const SizedBox(height: 30),

                // 🔹 Botón siguiente
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {Navigator.pushNamed(context, '/registro_artista3');},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Siguiente",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
