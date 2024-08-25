import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../Utilities/constants.dart';

class CustomStepper extends StatelessWidget {
  final StepperController stepperController;
  final PageController pageController;

  const CustomStepper({
    Key? key,
    required this.stepperController,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return EasyStepper(
        lineStyle: const LineStyle(
          lineType: LineType.normal,
        ),
        enableStepTapping: false,
        activeStep: stepperController.currentStep.value,
        direction: Axis.horizontal,
        unreachedStepIconColor: Colors.white,
        finishedStepBackgroundColor: AppColors.primaryColor,
        unreachedStepBackgroundColor: Colors.grey,
        showTitle: false,
        onStepReached: (index) {
          stepperController.goToStep(index);
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
        steps: const [
          EasyStep(
            icon: Icon(Iconsax.user),
            title: 'Cart',
          ),
          EasyStep(
            icon: Icon(Iconsax.password_check),
            activeIcon: Icon(Icons.file_present),
            title: 'Address',
          ),
          EasyStep(
            icon: Icon(Iconsax.archive),
            activeIcon: Icon(Icons.filter_center_focus_sharp),
            title: 'Checkout',
          ),
          EasyStep(
            icon: Icon(Iconsax.call),
            activeIcon: Icon(Icons.money),
            title: 'Payment',
          ),
          EasyStep(
            icon: Icon(Iconsax.sms),
            activeIcon: Icon(Icons.local_shipping_outlined),
            title: 'Shipping',
          ),
        ],
      );
    });
  }
}

class StepperController extends GetxController {
  var currentStep = 0.obs;

  void goToStep(int step) {
    currentStep.value = step;
  }
}
