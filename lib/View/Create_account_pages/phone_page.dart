import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/phone_controller.dart';
import '../../Utilities/registration_abstraction.dart';
import '../Widgets/phone_number_field.dart';

class PhoneNumberPage extends GetView<PhoneController> implements StepPage {
  const PhoneNumberPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  "Phone Number".tr,
                  style: const TextStyle(
                    fontSize: 35,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    height: 0.05,
                    letterSpacing: 0.28,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Text(
                  'Please enter your phone number to continue'.tr,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 16,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.16,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                PhoneNumberField(
                  controller: controller.phoneController,
                  onChanged: (phone) {
                    print("Updated phone number: $phone");
                    controller.handlePhoneNumberChange(phone);
                    controller.updateButtonState();
                  },
                  isCreateOrder: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool areFieldsFilled() {
    return controller.isButtonEnabled.value;
  }
}
