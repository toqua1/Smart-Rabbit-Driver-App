import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class EmailController extends GetxController {
  late final TextEditingController emailController;
  final RxBool isButtonEnabled = false.obs;
  final GetStorage storage = GetStorage();  // Initialize GetStorage

  @override
  void onInit() {
    emailController = TextEditingController();

    // Load the email from storage if it exists
    emailController.text = storage.read('email') ?? '';

    emailController.addListener(_onEmailChanged);
    super.onInit();
  }

  void _onEmailChanged() {
    updateButtonState();
    storage.write('email', emailController.text);  // Save email to storage
  }

  void updateButtonState() {
    isButtonEnabled.value = _isEmailValid(emailController.text);
  }

  bool _isEmailValid(String email) {
    // Regular expression for validating an email
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
