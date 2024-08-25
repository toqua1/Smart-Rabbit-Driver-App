import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../../Controllers/create_account_controller.dart';
import '../../Controllers/store_information_controller.dart';
import '../../Utilities/registration_abstraction.dart';
import '../Login_SignUp/login_screen.dart';
import '../Widgets/custom_button.dart';
import '../Widgets/stepper_row.dart';
import 'biodata_page.dart';
import 'create_password_page.dart';
import 'store_information.dart';
import 'email_page.dart';
import 'phone_page.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({Key? key}) : super(key: key);

  final PageController pageController = PageController();
  final StepperController stepperController = Get.put(StepperController());
  final StoreInformationController storeInfoController =
      Get.put(StoreInformationController());
  final RegistrationController registrationController = Get.put(
      RegistrationController()); // Instantiate the RegistrationController

  final List<StepPage> pages = [
    BioDataPage(),
    CreatePasswordPage(),
    const StoreInformationPage(),
    const PhoneNumberPage(),
    EmailPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'.tr),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CustomStepper(
            stepperController: stepperController,
            pageController: pageController,
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              onPageChanged: (int index) {
                stepperController.goToStep(index);
              },
              children: pages,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              final currentPageIndex = stepperController.currentStep.value;
              final isLastPage = currentPageIndex == pages.length - 1;
              final buttonText = isLastPage ? 'Submit'.tr : 'Next'.tr;

              // Determine if the current page's fields are filled
              bool isCurrentPageFieldsFilled;
              if (pages[currentPageIndex] is StoreInformationPage) {
                isCurrentPageFieldsFilled =
                    storeInfoController.isButtonEnabled.value;
              } else {
                isCurrentPageFieldsFilled = (pages[currentPageIndex] as dynamic)
                    .controller
                    .isButtonEnabled
                    .value;
              }

              // Show loading indicator if the request is in progress
              if (registrationController.isLoading.value) {
                return const CircularProgressIndicator();
              }

              return CustomButton(
                onPressed: isCurrentPageFieldsFilled
                    ? () async {
                        if (isLastPage) {
                          // Submit the registration form
                          registrationController.isLoading.value = true;
                          try {
                            await registrationController.registerUser();
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.success,
                              text: 'Account created successfully',
                              showConfirmBtn: false,
                              autoCloseDuration: const Duration(seconds: 1),
                              showCancelBtn: false,
                            );
                            await Future.delayed(const Duration(seconds: 1));

                            Get.offAll(() => LoginPage(),
                                transition: Transition.fadeIn,
                                duration: const Duration(milliseconds: 500));
                          } catch (e) {
                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.error,
                              title: 'Oops...',
                              text: 'Sorry, something went wrong',
                              showConfirmBtn: false,
                              autoCloseDuration: const Duration(seconds: 1),
                              showCancelBtn: false,
                            );
                          } finally {
                            registrationController.isLoading.value = false;
                          }
                        } else {
                          final nextPageIndex = currentPageIndex + 1;
                          stepperController.goToStep(nextPageIndex);
                          pageController.animateToPage(
                            nextPageIndex,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        }
                      }
                    : null,
                text: buttonText,
                isButtonEnabled: isCurrentPageFieldsFilled,
              );
            }),
          ),
        ],
      ),
    );
  }
}
