import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../API/endpoints.dart';
import '../Models/change_password_model.dart';

class ChangePasswordController extends GetxController {
  late final TextEditingController password;
  late final TextEditingController confirmPassword;

  final RxBool isButtonEnabled = false.obs;
  final RxBool isLoading = false.obs; // Loading state
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    password = TextEditingController();
    password.addListener(updateButtonState);
    confirmPassword = TextEditingController();
    confirmPassword.addListener(updateButtonState);
    super.onInit();
  }

  void updateButtonState() {
    isButtonEnabled.value = _isButtonEnabled();
  }

  bool _isButtonEnabled() {
    return password.text.isNotEmpty && confirmPassword.text.isNotEmpty;
  }

  Future<ChangePasswordResponse> updatePassword({
    required String password,
    required String confirmPassword,
  }) async {
    isLoading.value = true;
    try {
      final resetToken = storage.read('resetToken') ?? ''; // Fetch the resetToken from Get Storage

      final response = await Dio().patch(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.updatePasswordEndpoint}',
        data: {
          'password': password,
          'passwordConfirm': confirmPassword,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'resetpassword': 'Bearer $resetToken' // Use the resetToken here
          },
        ),
      );

      if (response.data != null && response.data is Map<String, dynamic>) {
        storage.write('token', resetToken);
        return ChangePasswordResponse.fromJson(response.data);
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      // debug
      rethrow;
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }
  @override
  void onClose() {
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }
}
