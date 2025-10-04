import 'package:flutter/material.dart';

class PerfilUsuarioPage extends StatelessWidget {
  const PerfilUsuarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fondo blanco
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 🔹 Header con botón "Editar Perfil" y logo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Acción editar perfil
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.black),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Editar Perfil",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Image.asset(
                      "assets/images/text1.png", // tu logo WaveUL
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 Foto de perfil
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey, // circular en blanco
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, size: 20),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // 🔹 Nombre de usuario y seguidores
              const Text(
                "SkibidyMaster89",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                "5 seguidores · 10 seguidos",
                style: TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 20),

              // 🔹 Datos personales
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.black, // fondo negro
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _DatoItem(label: "Nombre", value: "Dylann Rojas"),
                      SizedBox(height: 12),
                      _DatoItem(label: "Email", value: "drojas89@gmail.com"),
                      SizedBox(height: 12),
                      _DatoItem(label: "Fecha de cumpleaños", value: "15/11/2000"),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 Estadísticas título
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "TUS ESTADÍSTICAS",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // 🔹 Estadísticas (grid)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: const [
                    _EstadisticaItem(numero: "40", descripcion: "Canciones Escuchadas"),
                    _EstadisticaItem(numero: "5", descripcion: "Seguidores"),
                    _EstadisticaItem(numero: "100", descripcion: "Veces Reproducida"),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔹 Widget para mostrar cada dato personal
class _DatoItem extends StatelessWidget {
  final String label;
  final String value;

  const _DatoItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

// 🔹 Widget para mostrar cada estadística
class _EstadisticaItem extends StatelessWidget {
  final String numero;
  final String descripcion;

  const _EstadisticaItem({required this.numero, required this.descripcion});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black, // fondo negro
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            numero,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            descripcion,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
