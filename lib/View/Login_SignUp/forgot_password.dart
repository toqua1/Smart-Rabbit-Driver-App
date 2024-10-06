import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controllers/forgot_password_controller.dart';
import '../../Utilities/constants.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_textfiled.dart';
import '../Widgets/inter_text_style.dart';
import 'otp_screen.dart';

class ForgotPassword extends GetView<ForgotPasswordController> {
  ForgotPassword({Key? key});

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
                    text: 'Reset Password'.tr,
                    size: screenHeight * 0.04,
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    letterSpacing: 0.16,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  InterTextStyle.getTextWidget(
                    text: 'Please enter your email address to reset password'.tr,
                    size: screenHeight * 0.02,
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    letterSpacing: 0.16,
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  CustomTextField(
                    labelText: 'Email Address'.tr,
                    hintText: 'Please enter your email address'.tr,
                    controller: controller.emailController,
                    icon: Iconsax.sms,
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
                            await controller.forgotPassword(
                              email: controller.emailController.text,
                            );
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            await prefs.setBool('isLoggedIn', true);
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Email sent successfully'.tr,
                              autoCloseDuration:
                              const Duration(seconds: 2),
                              showConfirmBtn: false,
                            );
                            await Future.delayed(
                                const Duration(seconds: 2));
                            Get.off(() => OtpScreen(),
                                transition: Transition.fadeIn,
                                duration: const Duration(milliseconds: 300));
                          } catch (e) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Oops...'.tr,
                              text: 'Sorry, User Not Found'.tr,
                              autoCloseDuration:
                              const Duration(seconds: 2),
                              showConfirmBtn: false,
                            );
                            SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                            await prefs.setBool('isLoggedIn', false);
                          }
                        }
                            : null,
                        text: 'Send Email'.tr,
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
