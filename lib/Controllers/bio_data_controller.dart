import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BioDataController extends GetxController {
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  final GetStorage storage = GetStorage();

  final RxBool isButtonEnabled = false.obs;

  @override
  void onInit() {
    usernameController = TextEditingController();

    usernameController.text = storage.read('username') ?? '';

    // Add listeners
    usernameController.addListener(_onUsernameChanged);

    super.onInit();
  }

  void _onUsernameChanged() {
    storage.write('username', usernameController.text);
    updateButtonState();
  }

  void updateButtonState() {
    isButtonEnabled.value = _areFieldsFilled();
  }

  bool _areFieldsFilled() {
    return usernameController.text.isNotEmpty;
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
