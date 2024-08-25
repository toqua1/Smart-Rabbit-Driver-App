import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../API/Api_helper.dart';
import '../API/endpoints.dart';
import '../Models/users_model.dart';

class LoginController extends GetxController {
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final RxBool isButtonEnabled = false.obs;

  String token = '';
  String username = '';
  String phone = '';
  String userId = ''; // Changed to string to match the JSON response

  final ApiData apiData = ApiData(); // Create an instance of ApiData

  @override
  void onInit() {
    passwordController = TextEditingController();
    phoneController = TextEditingController();
    passwordController.addListener(updateButtonState);
    phoneController.addListener(updateButtonState);
    super.onInit();
  }

  void updateButtonState() {
    isButtonEnabled.value = _isButtonEnabled();
  }

  bool _isButtonEnabled() {
    return phoneController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  // New method to handle phone number change
  void handlePhoneNumberChange(String completeNumber) {
    phone = completeNumber;
    updateButtonState();
  }

  Future<UserData> loginUser({
    required String password,
  }) async {
    try {
      final response = await Dio().post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.loginEndpoint}',
        data: {
          'phone': phone,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.data != null && response.data is Map<String, dynamic>) {
        final token = response.data['data']['customer']['token'];

        if (token != null) {
          this.token = token;
          username = response.data['data']['customer']['name'] ?? '';
          userId = response.data['data']['customer']['_id'] ?? '';
          await apiData.saveUserData(
            token: token,
            name: username,
            email: response.data['data']['customer']['email'] ?? '',
            phone: response.data['data']['customer']['phone'] ?? '',
            id: userId,  // Save the user ID

          );
          print('Login successful! Token: $token');

          return UserData.fromJson(response.data);
        } else {
          throw Exception("Token is null in the response");
        }
      } else {
        throw Exception("Invalid response format");
      }
    } catch (e) {
      debugPrint('Login failed: $e');
      throw Exception('Login failed: $e');
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
