import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../API/endpoints.dart';
import '../Models/forgot_password_model.dart';

class ForgotPasswordController extends GetxController {
  late final TextEditingController emailController;

  final RxBool isButtonEnabled = false.obs;
  final RxBool isLoading = false.obs; // Loading state
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    emailController = TextEditingController();
    emailController.addListener(updateButtonState);
    super.onInit();
  }

  void updateButtonState() {
    isButtonEnabled.value = _isButtonEnabled();
  }

  bool _isButtonEnabled() {
    return emailController.text.isNotEmpty;
  }

  Future<ForgotPasswordResponse> forgotPassword({
    required String email,
  }) async {
    isLoading.value = true; // Set loading state to true
    try {
      final response = await Dio().post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.forgetPasswordEndpoint}',
        data: {
          'email': email,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data != null && response.data is Map<String, dynamic>) {
        ForgotPasswordResponse forgotPasswordResponse = ForgotPasswordResponse.fromJson(response.data);
        storage.write('otpToken', forgotPasswordResponse.otpToken);
        return forgotPasswordResponse;
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      debugPrint('Forgot password failed: $e');
      rethrow;
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
