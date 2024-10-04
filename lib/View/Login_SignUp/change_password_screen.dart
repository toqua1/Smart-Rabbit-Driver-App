import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:smart_rabbit_second_app/View/Home/order_list_screen.dart';
import '../../Controllers/change_password_controller.dart';
import '../../Utilities/constants.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_textfiled.dart';
import '../Widgets/inter_text_style.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  ChangePasswordScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Hide keyboard when tapping outside
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  InterTextStyle.getTextWidget(
                    text: 'Reset Password'.tr, // Translation added
                    size: screenHeight * 0.04,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    letterSpacing: 0.16,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  InterTextStyle.getTextWidget(
                    text: 'Please enter your new password'.tr, // Translation added
                    size: screenHeight * 0.02,
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    letterSpacing: 0.16,
                  ),
                  Image.asset('assets/password.png'),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  CustomTextField(
                    labelText: 'Password'.tr, // Translation added
                    hintText: 'Please enter your new password'.tr, // Translation added
                    controller: controller.password,
                    obscureText: true,
                    icon: Iconsax.lock,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  CustomTextField(
                    labelText: 'Confirm Password'.tr, // Translation added
                    hintText: 'Please confirm your new password'.tr, // Translation added
                    controller: controller.confirmPassword,
                    obscureText: true,
                    icon: Iconsax.lock,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return CustomButton(
                        onPressed: controller.isButtonEnabled.value
                            ? () async {
                          try {
                            await controller.updatePassword(
                                password: controller.password.text,
                                confirmPassword: controller.confirmPassword.text);
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Password changed successfully'.tr, // Translation added
                              autoCloseDuration: const Duration(seconds: 2),
                              showConfirmBtn: false,
                            );
                            Future.delayed(const Duration(seconds: 2), () {
                              Get.offAll(() => OrderListScreen());
                            });
                          } catch (e) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Oops...'.tr, // Translation added
                              text: 'Password don\'t match'.tr, // Translation added
                              autoCloseDuration: const Duration(seconds: 2),
                              showConfirmBtn: false,
                            );
                          }
                        }
                            : null,
                        text: 'Change password'.tr, // Translation added
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
