import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CreatePasswordController extends GetxController {
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  final GetStorage storage = GetStorage();

  final RxBool isButtonEnabled = false.obs;

  @override
  void onInit() {
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    // Load initial values if they exist
    passwordController.text = storage.read('password') ?? '';
    confirmPasswordController.text = storage.read('confirmPassword') ?? '';

    // Add listeners
    passwordController.addListener(_onPasswordChanged);
    confirmPasswordController.addListener(_onConfirmPasswordChanged);

    super.onInit();
  }

  void _onPasswordChanged() {
    storage.write('password', passwordController.text);
    updateButtonState();
  }

  void _onConfirmPasswordChanged() {
    storage.write('confirmPassword', confirmPasswordController.text);
    updateButtonState();
  }

  void updateButtonState() {
    isButtonEnabled.value = _areFieldsFilled();
  }

  bool _areFieldsFilled() {
    return passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
