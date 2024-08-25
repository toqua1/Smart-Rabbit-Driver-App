import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../Controllers/store_information_controller.dart';
import '../../Utilities/registration_abstraction.dart';
import '../Widgets/custom_textfiled.dart';
import '../Widgets/inter_text_style.dart';
import '../Widgets/upload_image.dart';

class StoreInformationPage extends GetView<StoreInformationController>
    implements StepPage {
  const StoreInformationPage({super.key});

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
              "Store Information".tr,
              style: const TextStyle(fontSize: 23),
            ),
            Text(
              "Save your important information securely.".tr,
              style: TextStyle(
                  fontSize: 14.5, color: Colors.black.withOpacity(0.5)),
            ),
            SizedBox(height: screenHeight * 0.045),

            // National ID Field
            Text(
              "National ID Number".tr,
              style: const TextStyle(fontSize: 18),
            ),
            SizedBox(height: screenHeight * 0.01),
            CustomTextField(
              labelText: 'National ID'.tr,
              hintText: 'Please enter National ID'.tr,
              controller: controller.nationalIdController,
              icon: Icons.badge,
              obscureText: false,
            ),
            SizedBox(height: screenHeight * 0.015),

            // Tax Number Field
            Text(
              "Tax Number".tr,
              style: const TextStyle(fontSize: 18),
            ),
            SizedBox(height: screenHeight * 0.01),
            CustomTextField(
              labelText: 'Tax Number'.tr,
              hintText: 'Please enter Tax Number'.tr,
              controller: controller.taxNumberController,
              icon: Iconsax.bill,
              obscureText: false,
            ),
            SizedBox(height: screenHeight * 0.015),

            // Product Type Field
            Text(
              "Product Type".tr,
              style: const TextStyle(fontSize: 18),
            ),
            SizedBox(height: screenHeight * 0.01),
            CustomTextField(
              labelText: 'Product Type'.tr,
              hintText: 'Please enter Product Type'.tr,
              controller: controller.productTypeController,
              icon: Iconsax.shopping_cart,
              obscureText: false,
            ),
            SizedBox(height: screenHeight * 0.015),

            // ID Front Image Upload
            InterTextStyle.getTextWidget(
                text: "National ID Card (front)".tr, size: 20),
            ImageUploadContainer(
              storageKey: 'IDFrontImage',
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),

            // ID Back Image Upload
            InterTextStyle.getTextWidget(
                text: "National ID Card (back)".tr, size: 20),
            ImageUploadContainer(
              storageKey: 'IDBackImage',
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            InterTextStyle.getTextWidget(text: "Tax Number Photo".tr, size: 20),
            ImageUploadContainer(
              storageKey: 'TaxImage',
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            InterTextStyle.getTextWidget(text: "Commercial Register Photo".tr, size: 20),
            ImageUploadContainer(
              storageKey: 'CommercialRegisterImage',
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool areFieldsFilled() {
    return true;
  }
}
