import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_rabbit_second_app/API/Api_helper.dart';

class PhoneController extends GetxController {
  late final TextEditingController phoneController;
  late final TextEditingController fullPhoneController;
  final RxBool isButtonEnabled = false.obs;
  ApiData api = ApiData();

  String phone = '';

  final GetStorage storage = GetStorage(); // Initialize GetStorage

  @override
  void onInit() {
    var data = api.getUserData().then(
      (value) {
        phoneController = TextEditingController(text: value['phone']);
        fullPhoneController = TextEditingController(text: value['phone']);
        phoneController.addListener(updateButtonState);
      },
    );

    super.onInit();
  }

  void handlePhoneNumberChange(String completeNumber) {
    phone = completeNumber;
    fullPhoneController.text = phone;

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
