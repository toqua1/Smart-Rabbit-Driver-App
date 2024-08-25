import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controllers/login_controller.dart';
import '../Create_account_pages/registration.dart';
import '../Home/home_page.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_textfiled.dart';
import '../Widgets/inter_text_style.dart';
import '../Widgets/phone_number_field.dart';
import 'forgot_password.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Hide keyboard when tapping outside
      },
      child: Scaffold(
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
                  InterTextStyle.getTextWidget(
                    text: 'login_title'.tr,
                    size: screenHeight * 0.04,
                    // Adjusted size
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    // Standard line height
                    letterSpacing: 0.16,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  InterTextStyle.getTextWidget(
                    text: 'login_prompt'.tr,
                    size: screenHeight * 0.02,
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    // Standard line height
                    letterSpacing: 0.16,
                  ),
                  SizedBox(
                    height: screenHeight * 0.06,
                  ),
                  PhoneNumberField(
                    controller: controller.phoneController,
                    onChanged: (phone) {
                      controller.handlePhoneNumberChange(phone);
                      controller.updateButtonState();
                    },
                    isCreateOrder: false,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  CustomTextField(
                    labelText: 'login_password'.tr,
                    hintText: 'login_password_hint'.tr,
                    controller: controller.passwordController,
                    icon: Iconsax.lock,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: screenHeight * 0.016,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.to(() => ForgotPassword(),
                              transition: Transition.rightToLeftWithFade,
                              duration: const Duration(milliseconds: 500));
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF3366FF),
                        ),
                        child: InterTextStyle.getTextWidget(
                          text: 'login_forgot_password'.tr,
                          size: screenHeight * 0.018, // Adjusted size
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  SizedBox(
                    height: screenHeight * 0.0008,
                  ),
                  Obx(() {
                    return CustomButton(
                      onPressed: controller.isButtonEnabled.value
                          ? () async {
                              try {
                                await controller.loginUser(
                                  //phone: controller.phoneController.text,
                                  password: controller.passwordController.text,
                                );
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool('isLoggedIn', true);
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: 'login_success'.tr,
                                );
                                await Future.delayed(
                                    const Duration(seconds: 1));

                                Get.offAll(() => HomePage(),
                                    transition: Transition.fadeIn,
                                    duration:
                                        const Duration(milliseconds: 500));
                              } catch (e) {
                                print('Login failed: $e');
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.error,
                                  title: 'login_error_title'.tr,
                                  text: 'login_error_message'.tr,
                                );
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool('isLoggedIn', false);
                              }
                            }
                          : null,
                      text: 'login_button'.tr,
                      isButtonEnabled: controller.isButtonEnabled.value,
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Get.to(() => RegistrationScreen(),
                                transition: Transition.rightToLeftWithFade,
                                duration: const Duration(milliseconds: 500));
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'login_no_account_prompt'.tr,
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    color: Colors.grey,
                                    // Grey color for the first part
                                  ),
                                ),
                                TextSpan(
                                  text: 'login_register_now'.tr,
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                    color: const Color(0xFF3366FF),
                                    // Blue color for "Register now"
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
