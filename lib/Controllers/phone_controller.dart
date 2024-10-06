import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PhoneController extends GetxController {
  late final TextEditingController phoneController;
  late final TextEditingController fullPhoneController;
  final RxBool isButtonEnabled = false.obs;
  String phone = '';

  final GetStorage storage = GetStorage();  // Initialize GetStorage

  @override
  void onInit() {
    phoneController = TextEditingController();
    fullPhoneController=TextEditingController();
    phoneController.addListener(updateButtonState);
    super.onInit();
  }

  void handlePhoneNumberChange(String completeNumber) {
    phone = completeNumber;
    fullPhoneController.text=phone;
     
    updateButtonState();
    saveCompletePhoneNumber(completeNumber);
  }

  void updateButtonState() {
    isButtonEnabled.value = phoneController.text.isNotEmpty;
  }

  void saveCompletePhoneNumber(String phone) {
    storage.write('phone', phone);
  }

  String? getSavedPhoneNumber() {
    return storage.read('phone');
  }
}
