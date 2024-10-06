import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rabbit_second_app/Controllers/phone_controller.dart';
import 'package:smart_rabbit_second_app/View/Create_account_pages/create_account_status.dart';
import 'package:smart_rabbit_second_app/View/Widgets/custom_button_edit.dart';
import '../../Controllers/store_information_controller.dart';
import '../../Utilities/app_styles.dart';
import '../Widgets/custom_textfeild_edit.dart';
import '../Widgets/profile_image.dart';
import '../Widgets/upload_image.dart';

class StoreInformationPage extends StatelessWidget {
  StoreInformationPage({super.key});
  final StoreInformationController controller =
      Get.put(StoreInformationController());
  final PhoneController phoneController = Get.find();
  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // phoneController.phoneController.text=phoneController.phone.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.045),
                Center(
                  child: ProfileImage(controller: controller),
                ),
                SizedBox(height: screenHeight * 0.045),

                // Full Name Field
                Text('Full Name'.tr, style: Styles.style14GreyColor),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                customTextField(
                  hintText: 'Full Name'.tr,
                  showBorder: false,
                  maxLines: false,
                  isReadOnly: false,
                  controller: controller.fullNameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Full Name is required'.tr : null,
                ),
                SizedBox(height: screenHeight * 0.015),

                // Address Field
                Text('Address'.tr, style: Styles.style14GreyColor),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                customTextField(
                  hintText: 'Address'.tr,
                  showBorder: false,
                  maxLines: false,
                  isReadOnly: false,
                  suffixIcon: Icons.location_on,
                  controller: controller.addressController,
                  validator: (value) =>
                      value!.isEmpty ? 'Address is required'.tr : null,
                ),
                SizedBox(height: screenHeight * 0.015),

                // Phone Number Field
                Text('Phone Number'.tr, style: Styles.style14GreyColor),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                customTextField(
                  hintText: '',
                  showBorder: false,
                  maxLines: false,
                  isReadOnly: false,
                  controller: phoneController.fullPhoneController,
                  validator: (value) =>
                      value!.isEmpty ? 'Phone Number is required'.tr : null,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: screenHeight * 0.015),

                // National ID Number Field
                Text('National ID'.tr, style: Styles.style14GreyColor),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                customTextField(
                  hintText: 'National ID Number'.tr,
                  showBorder: false,
                  maxLines: false,
                  isReadOnly: false,
                  controller: controller.nationalIdController,
                  validator: (value) =>
                      value!.isEmpty ? "Please enter National ID".tr :
                      null,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: screenHeight * 0.015),
                // National ID Upload
                Text('Upload National ID Face'.tr, style: Styles.style14GreyColor),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                ImageUploadContainer(
                    storageKey: 'NationalIDImageFace',
                    imageFile: controller.nationalIdImageFace,
                    onImageSelected: controller.selectNationalIdImageFace,
                  ),
                SizedBox(height: screenHeight * 0.015),

                Text('Upload National ID Back'.tr, style: Styles
                    .style14GreyColor),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                ImageUploadContainer(
                  storageKey: 'NationalIDImageBack',
                  imageFile: controller.nationalIdImageBack,
                  onImageSelected: controller.selectNationalIdImageBack,
                ),
                SizedBox(height: screenHeight * 0.015),

                // Driving License Upload
                Text('Upload driving license'.tr, style: Styles
                    .style14GreyColor),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                 ImageUploadContainer(
                    storageKey: 'DrivingLicenseImage',
                    imageFile: controller.drivingLicenseImage,
                    onImageSelected: controller.selectDrivingLicenseImage,
                  ),
                SizedBox(height: screenHeight * 0.05),

                // Continue Button
                Center(
                  child: customButton(
                      title: 'Continue'.tr,
                      style: Styles.style14,
                      action: onTapContinue ,
                    smallSize: true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void onTapContinue(){
    if (_formKey.currentState!.validate()) {
      if (controller.nationalIdImageFace.value != null && controller
          .nationalIdImageBack.value != null  && controller
          .drivingLicenseImage.value != null) {
        Get.to(CreateAccountStatus());
      } else {
        Get.snackbar('Error'.tr, 'Please upload required images. '.tr ,
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }
}
