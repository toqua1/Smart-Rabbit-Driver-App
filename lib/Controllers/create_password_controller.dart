import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CreatePasswordController extends GetxController {
  late final TextEditingController passwordController;
  final GetStorage storage = GetStorage();

  final RxBool isButtonEnabled = false.obs;

  @override
  void onInit() {
    passwordController = TextEditingController();

    // Load initial values if they exist
    passwordController.text = storage.read('password') ?? '';

    // Add listeners
    passwordController.addListener(_onPasswordChanged);

    super.onInit();
  }

  void _onPasswordChanged() {
    storage.write('password', passwordController.text);
    // updateButtonState();
  }

  // void updateButtonState() {
  //   isButtonEnabled.value = _areFieldsFilled();
  // }
  //
  // bool _areFieldsFilled() {
  //   return passwordController.text.isNotEmpty &&
  //       passwordController.text == confirmPasswordController.text;
  // }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
