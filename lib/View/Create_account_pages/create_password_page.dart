import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../Controllers/create_password_controller.dart';
import '../../Utilities/registration_abstraction.dart'; // Adjust the import path as necessary
import '../Widgets/custom_textfiled.dart'; // Assuming you have this custom widget

class CreatePasswordPage extends GetView<CreatePasswordController> implements StepPage {

  CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Password".tr,
              style: const TextStyle(fontSize: 23),
            ),
            Text(
              "Set a secure password for your account".tr,
              style: TextStyle(
                  fontSize: 14.5, color: Colors.black.withOpacity(0.5)),
            ),
            SizedBox(height: screenHeight * 0.045),
            CustomTextField(
              labelText: 'Password'.tr,
              hintText: 'Enter your password'.tr,
              controller: controller.passwordController,
              icon: Iconsax.lock,
              obscureText: true,
            ),
            SizedBox(height: screenHeight * 0.03),
            CustomTextField(
              labelText: 'Confirm Password'.tr,
              hintText: 'Confirm your password'.tr,
              controller: controller.confirmPasswordController,
              icon: Iconsax.lock,
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool areFieldsFilled() {
    return controller.isButtonEnabled.value;
  }
}
