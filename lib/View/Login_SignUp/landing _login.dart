import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../Controllers/login_controller.dart';
import '../Create_account_pages/registration.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/custom_divider.dart';
import '../Widgets/custom_outlined_button.dart';
import '../Widgets/inter_text_style.dart';
import 'login_screen.dart';

class LandingPage extends GetView<LoginController> {
  LandingPage({Key? key});

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/bro.png',
                      fit: BoxFit.contain, height: screenHeight * 0.35),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: InterTextStyle.getTextWidget(
                      text: 'landing_welcome'.tr,
                      size: screenHeight * 0.030,
                      // Adjusted size
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      // Standard line height
                      letterSpacing: 0.16,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  InterTextStyle.getTextWidget(
                    text: 'landing_login_prompt'.tr,
                    size: screenHeight * 0.02,
                    // Adjusted size
                    fontWeight: FontWeight.w400,
                    opacity: 0.7,
                    height: 1.2,
                    // Standard line height
                    letterSpacing: 0.16,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomOutlinedButton(
                        buttonText: 'landing_continue_google'.tr,
                        iconColor: Colors.red,
                        onPressed: () {
                          print('google button clicked');
                        },
                        iconData: FontAwesomeIcons.google,
                      ),
                      CustomOutlinedButton(
                        buttonText: 'landing_continue_facebook'.tr,
                        iconColor: Colors.blue,
                        onPressed: () {
                          print('Facebook button clicked');
                        },
                        iconData: FontAwesomeIcons.facebook,
                      ),
                      CustomOutlinedButton(
                        buttonText: 'landing_continue_apple'.tr,
                        iconColor: Colors.black,
                        onPressed: () {
                          print('Facebook button clicked');
                        },
                        iconData: FontAwesomeIcons.apple,
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      CustomDivider(text: 'landing_or_login'.tr),
                      CustomButton(
                          onPressed: () {
                            Get.to(
                                  () => LoginPage(),
                              transition: Transition.rightToLeftWithFade,
                              // Add your transition
                              duration: const Duration(
                                  milliseconds: 500), // Specify duration
                            );
                          },
                          text: "landing_login_now".tr,
                          isButtonEnabled: true),
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
                            child: InterTextStyle.getTextWidget(
                              text: 'landing_register_prompt'.tr,
                              size: screenHeight * 0.02, // Adjusted size
                              color: const Color(0xFF3366FF),
                            ),
                          ),
                        ],
                      ),
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
