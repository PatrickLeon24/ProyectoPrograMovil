import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveul/services/profile_service.dart';

class CambiarContrasenaPage extends StatefulWidget {
  const CambiarContrasenaPage({super.key});

  @override
  State<CambiarContrasenaPage> createState() => _CambiarContrasenaPageState();
}

class _CambiarContrasenaPageState extends State<CambiarContrasenaPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final ProfileService _profileService = ProfileService();

  bool _isSaving = false;
  String _message = '';

  Future<void> _handleChangePassword() async {
    final currentPass = _currentPasswordController.text.trim();
    final newPass = _newPasswordController.text.trim();
    final confirmPass = _confirmPasswordController.text.trim();

    setState(() {
      _message = '';
    });

    if (currentPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      setState(() {
        _message = "Debes completar todos los campos";
      });
      return;
    }

    if (newPass != confirmPass) {
      setState(() {
        _message = "La nueva contraseña y su confirmación no coinciden";
      });
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final response =
        await _profileService.changePassword(currentPass, newPass);

    setState(() {
      _isSaving = false;
      _message = response.message;
    });

    if (response.success) {
      Get.snackbar("Éxito", "Contraseña actualizada correctamente");
      Navigator.pop(context); // volver a la pantalla anterior
    } else {
      Get.snackbar("Error", response.message);
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cambiar contraseña"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black54, Colors.grey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Contraseña actual",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _currentPasswordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Nueva contraseña",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _newPasswordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Confirmar nueva contraseña",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _handleChangePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: _isSaving
                      ? const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        )
                      : const Text(
                          "Cambiar contraseña",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  _message,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
