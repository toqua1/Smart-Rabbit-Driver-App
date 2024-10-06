import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rabbit_second_app/Controllers/create_password_controller.dart';
import 'package:smart_rabbit_second_app/Controllers/phone_controller.dart';
import 'package:smart_rabbit_second_app/View/Home/home_nav_bar.dart';
import 'package:smart_rabbit_second_app/View/Home/order_list_screen.dart';
import '../../API/Api_helper.dart';
import '../Create_account_pages/registration.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_textfiled.dart';
import '../Widgets/inter_text_style.dart';
import '../Widgets/loading_overlay.dart';
import '../Widgets/phone_number_field.dart';
import 'forgot_password.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, });
  final CreatePasswordController passCon=Get.put(CreatePasswordController());
  final PhoneController phoneCon=Get.put(PhoneController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    RxBool isLoading=false.obs ;

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
                    controller: phoneCon.phoneController,
                    onChanged: (phone) {
                      phoneCon.handlePhoneNumberChange(phone);
                      phoneCon.updateButtonState();
                    },
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  CustomTextField(
                    labelText: 'login_password'.tr,
                    hintText: 'login_password_hint'.tr,
                    controller: passCon.passwordController,
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
                  CustomButton(
                    onPressed: () async {
                      isLoading.value = true;
                      try {
                        bool loginSuccess = await ApiData().loginDriver(
                          phoneCon.phone,
                          passCon.passwordController.text,
                        );

                        if (loginSuccess) {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedIn', true);

                          if (Get.context != null && Get.context!.mounted) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'login_success'.tr,
                            );
                            await Future.delayed(const Duration(seconds: 1));

                            Get.offAll(() => HomeNavBar(),
                                transition: Transition.fadeIn,
                                duration: const Duration(milliseconds: 500));
                          }
                        } else {
                          isLoading.value = false;  // Stop loading if login fails
                          // if (Get.context != null && Get.context!.mounted) {
                          //   QuickAlert.show(
                          //     context: context,
                          //     type: QuickAlertType.error,
                          //     title: 'login_error_title'.tr,
                          //     text: 'login_error_message'.tr,
                          //   );
                          // }
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('isLoggedIn', false);
                        }
                      } catch (e) {
                        isLoading.value = false;
                         
                      }
                    },
                    text: 'login_button'.tr,
                  ),

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
                  // Loading overlay
                  Obx(() {
                    return isLoading.value
                        ? const LoadingOverlay()
                        : const SizedBox.shrink();
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
