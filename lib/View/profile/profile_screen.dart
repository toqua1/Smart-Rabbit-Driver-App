import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rabbit_second_app/API/Api_helper.dart';
import 'package:smart_rabbit_second_app/Controllers/email_controller.dart';
import 'package:smart_rabbit_second_app/Controllers/phone_controller.dart';
import 'package:smart_rabbit_second_app/Controllers/store_information_controller.dart';
import 'package:smart_rabbit_second_app/Utilities/app_styles.dart';
import 'package:smart_rabbit_second_app/View/Widgets/custom_button_edit.dart';
import 'package:smart_rabbit_second_app/View/Widgets/custom_textfeild_edit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool loading = false;
  final StoreInformationController controller =
      Get.put(StoreInformationController());
  final PhoneController phoneController = Get.find();
  final EmailController eController = Get.put(EmailController());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'.tr),
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
                /// SizedBox(height: screenHeight * 0.045),
                // Center(
                //   child: ProfileImage(controller: controller),
                // ),
                SizedBox(height: screenHeight * 0.015),

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
                Text('Email'.tr, style: Styles.style14GreyColor),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                customTextField(
                  hintText: '',
                  showBorder: false,
                  controller: eController.emailController,
                  maxLines: false,
                  isReadOnly: false,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the field'.tr;
                    }
                    return null;
                  },
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
                SizedBox(height: screenHeight * 0.05),

                // Continue Button
                Center(
                  child: customButton(
                    title: loading ? null : 'Update profile'.tr,
                    style: Styles.style14,
                    action: loading ? null : onTapContinue,
                    smallSize: true,
                    child: loading
                        ? SizedBox(
                            width: 50,
                            child: Center(
                              child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  )),
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapContinue() async {
    if (_formKey.currentState!.validate()) {
      {
        try {
          loading = true;
          setState(() {});
          ApiData apiData = ApiData();
          await apiData.updateProfile(
              controller.fullNameController.text,
              controller.addressController.text,
              phoneController.phoneController.text);
          loading = false;
          setState(() {});

          Get.snackbar(
              'updated', 'Profile updated successfully', //TODO:localization
              snackPosition: SnackPosition.BOTTOM);
        } catch (e) {
          loading = false;
          setState(() {});

          Get.snackbar('Error'.tr, e.toString(),
              snackPosition: SnackPosition.BOTTOM);
        }
        // Get.to(CreateAccountStatus());
      }
    }
  }
}
