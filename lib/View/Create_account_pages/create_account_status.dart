import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:smart_rabbit_second_app/Controllers/account_status_controller.dart';
import 'package:smart_rabbit_second_app/Controllers/address_controller.dart';
import 'package:smart_rabbit_second_app/Utilities/app_styles.dart';
import 'package:smart_rabbit_second_app/Utilities/constants.dart';
import 'package:smart_rabbit_second_app/View/Login_SignUp/setup_done.dart';
import 'package:smart_rabbit_second_app/View/Widgets/custom_button_edit.dart';
import '../../Utilities/sumbit_sign_data_function.dart';
import '../Widgets/loading_overlay.dart';
import '../Widgets/region_dropdown.dart';

class CreateAccountStatus extends StatelessWidget {
  CreateAccountStatus({super.key});
  final AccountStatusController controller = Get.put(AccountStatusController());
  final AddressController addressController = Get.put(AddressController());
  RxBool isLoading =false.obs;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.045),
            Text(
              'Continue As'.tr,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Obx(() => Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                children: [
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColors.primaryColor,
                    title: Text('Drop off'.tr),
                    value: 'Drop off',
                    groupValue: controller.selectedOption.value,
                    onChanged: (value) =>
                        controller.updateOption(value as String),
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColors.primaryColor,
                    title: Text('Pick up'.tr),
                    value: 'Pick up',
                    groupValue: controller.selectedOption.value,
                    onChanged: (value) =>
                        controller.updateOption(value as String),
                  ),
                  RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColors.primaryColor,
                    title: Text('Pick up & Drop off'.tr),
                    value: 'Pick up & Drop off',
                    groupValue: controller.selectedOption.value,
                    onChanged: (value) =>
                        controller.updateOption(value as String),
                  ),
                ],
              ),
            )),
            SizedBox(height: screenHeight * 0.04),
           RegionDropdown(addressController: addressController),
            SizedBox(height: screenHeight * 0.05),
            Center(
              child: customButton(
                title: 'Save'.tr,
                style: Styles.style14,
                action:()=> onTapSave(context),
                smallSize: true,
              ),
            ),
            Obx(() {
              return isLoading.value
                  ? const LoadingOverlay()
                  : const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
  void onTapSave(BuildContext context) async {
    if (controller.selectedOption.isNotEmpty &&
        addressController.selectedRegion.value != null) {
      isLoading.value = true; // Start loading
      try {
        await submitSignUp(); // Ensure this is an async function if it involves async operations

        // Check if the widget is still mounted before showing alerts or navigating
        if (Get.context != null && Get.context!.mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Account Created Successfully'.tr,
          );
          await Future.delayed(const Duration(seconds: 1));

          Get.offAll(() => const SetupDone(),
              transition: Transition.rightToLeftWithFade,
              duration: const Duration(milliseconds: 500));
        }
      } catch (e) {
        // Check if the widget is still mounted before showing alerts
        if (Get.context != null && Get.context!.mounted) {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error'.tr,
            text: 'Sign Up failed, Try again!'.tr,
          );
        }
      } finally {
        isLoading.value = false; // Stop loading
      }
    } else {
      // Check if the widget is still mounted before showing alerts
      if (Get.context != null && Get.context!.mounted) {
        Get.snackbar('Error'.tr, 'Fill all fields.'.tr,
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

}
