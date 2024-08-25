import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../Controllers/otp_controller.dart';
import '../../Utilities/constants.dart';
import '../Widgets/inter_text_style.dart';
import 'change_password_screen.dart';

class OtpScreen extends GetView<OtpController> {
  OtpScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Hide keyboard when tapping outside
      },
      child: Scaffold(
        appBar: AppBar(),
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
                    text: 'Please enter the OTP sent to your email'.tr,
                    size: screenHeight * 0.02,
                    color: const Color(0xFF6B7280),
                    fontWeight: FontWeight.w400,
                    height: 1.2,
                    letterSpacing: 0.16,
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  OtpTextField(
                    numberOfFields: 6,
                    borderWidth: 1.5,
                    autoFocus: true,
                    enabledBorderColor: AppColors.primaryColor,
                    disabledBorderColor: Colors.grey,
                    focusedBorderColor: AppColors.accentColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    showFieldAsBox: true,
                    onSubmit: (String verificationCode) async {
                      try {
                        print(verificationCode);
                        await controller.validateOtp(otp: verificationCode);
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'OTP Verified Successfully',
                          autoCloseDuration:
                          const Duration(seconds: 2),
                          showConfirmBtn: false,
                        );
                        await Future.delayed(const Duration(
                            seconds:
                            2));
                        Get.off(() => ChangePasswordScreen(),
                            transition: Transition.fadeIn,
                            duration: const Duration(milliseconds: 300));
                      } catch (e) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Oops...',
                          text: 'Invalid OTP',
                        );
                      }
                    }, // end onSubmit
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
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
