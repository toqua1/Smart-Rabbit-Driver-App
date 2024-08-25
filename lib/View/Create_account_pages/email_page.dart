import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../Controllers/email_controller.dart';
import '../../Utilities/registration_abstraction.dart';
import '../Widgets/custom_textfiled.dart';

class EmailPage extends GetView<EmailController> implements StepPage {
  EmailPage({Key? key}) : super(key: key);

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
              "What's Your Email?".tr,
              style: TextStyle(fontSize: screenHeight * 0.03),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "Fill Your EMAIL correctly".tr,
              style: TextStyle(
                fontSize: screenHeight * 0.018,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            SizedBox(height: screenHeight * 0.045),
            Text(
              "Email".tr,
              style: TextStyle(fontSize: screenHeight * 0.022),
            ),
            SizedBox(height: screenHeight * 0.01),
            CustomTextField(
              labelText: 'Email'.tr,
              hintText: 'Please enter email'.tr,
              controller: controller.emailController,
              icon: Iconsax.sms,
              obscureText: false,
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
