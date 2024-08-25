import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PhoneController extends GetxController {
  late final TextEditingController phoneController;
  final RxBool isButtonEnabled = false.obs;
  String phone = '';

  final GetStorage storage = GetStorage();  // Initialize GetStorage

  @override
  void onInit() {
    phoneController = TextEditingController();
    phoneController.addListener(updateButtonState);
    super.onInit();
  }

  void handlePhoneNumberChange(String completeNumber) {
    phone = completeNumber;
    print("Phone number: $phone");
    updateButtonState();
    savePhoneNumber(phone);  // Save the phone number to GetStorage
  }

  void updateButtonState() {
    isButtonEnabled.value = phoneController.text.isNotEmpty;
  }

  void savePhoneNumber(String phone) {
    storage.write('phone_number', phone);
    print("Phone number saved: $phone");
  }

  String? getSavedPhoneNumber() {
    return storage.read('phone_number');
  }
}
