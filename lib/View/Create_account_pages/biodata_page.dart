import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../Controllers/bio_data_controller.dart';
import '../../Utilities/registration_abstraction.dart';
import '../Widgets/custom_textfiled.dart';

class BioDataPage extends GetView<BioDataController> implements StepPage {
  BioDataPage({Key? key}) : super(key: key);

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
              "What's Your Name?".tr,
              style: TextStyle(
                fontSize: screenHeight * 0.03, // Adjusted font size based on screen height
              ),
            ),
            Text(
              "Fill Your FULL NAME correctly".tr,
              style: TextStyle(
                fontSize: screenHeight * 0.018, // Adjusted font size based on screen height
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            SizedBox(height: screenHeight * 0.045),
            Text(
              "Full Name".tr,
              style: TextStyle(
                fontSize: screenHeight * 0.022, // Adjusted font size based on screen height
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            CustomTextField(
              labelText: 'Username',
              hintText: 'Please enter username'.tr,
              controller: controller.usernameController,
              icon: Iconsax.user,
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
