import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waveul/services/session_service.dart';
import 'package:waveul/services/profile_service.dart';

class EditarPerfilController extends GetxController {
  final SessionService _sessionService = SessionService();
  final ProfileService _profileService = ProfileService();

  late TextEditingController nicknameController;
  RxBool isSaving = false.obs;
  RxString message = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final user = _sessionService.getUser();
    nicknameController = TextEditingController(
      text: user?.username ?? '',
    );
  }

  /// 🔹 Llamar al backend para actualizar el username
  Future<void> saveNickname() async {
    final newUsername = nicknameController.text.trim();

    if (newUsername.isEmpty) {
      message.value = "El nickname no puede estar vacío";
      return;
    }

    isSaving.value = true;
    message.value = '';

    final response = await _profileService.updateUsername(newUsername);

    isSaving.value = false;
    message.value = response.message;

    if (response.success) {
      // Opcional: podrías mostrar un Snackbar o navegar hacia atrás
      Get.snackbar("Éxito", "Nickname actualizado correctamente");
    } else {
      Get.snackbar("Error", response.message);
    }
  }
}
