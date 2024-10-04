import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../API/endpoints.dart';
import '../Models/reset_otp_model.dart';

class OtpController extends GetxController {
  late final TextEditingController otpController;
  final RxBool isLoading = false.obs;
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    otpController = TextEditingController();
    super.onInit();
  }

  Future<ResetOtpResponse> validateOtp({
    required String otp,
  }) async {
    isLoading.value = true;
    try {
       
      int.parse(otp);
      final otpToken = storage.read('otpToken') ?? ''; // Fetch the resetToken from Get Storage

       

      final response = await Dio().post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.validateOtpEndpoint}',
        data: {
          'OTP': otp,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'otp': 'Bearer $otpToken' // Use the resetToken here
          },
        ),
      );

      if (response.data != null && response.data is Map<String, dynamic>) {
         
        ResetOtpResponse resetOtpResponse = ResetOtpResponse.fromJson(response.data);
        storage.write('resetToken', resetOtpResponse.resetToken); // Save resetToken in Get Storage
        return resetOtpResponse;
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
    otpController.dispose();
    super.onClose();
  }
}
