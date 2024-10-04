import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_rabbit_second_app/View/Create_account_pages/store_information.dart';
import 'package:smart_rabbit_second_app/View/Widgets/custom_button_edit.dart';
import '../../Controllers/create_password_controller.dart';
import '../../Utilities/app_styles.dart';
import '../Widgets/custom_textfiled.dart';

class CreatePasswordPage extends StatelessWidget {
  CreatePasswordPage({super.key});
  final CreatePasswordController controller=Get.put(CreatePasswordController());

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * 0.045),
              Text(
                "   Create \n Password".tr,
                style: const TextStyle(fontSize: 23),
              ),
              SizedBox(height: screenHeight * 0.045),
              CustomTextField(
                labelText: 'Password'.tr,
                hintText: 'Enter your password'.tr,
                controller: controller.passwordController,
                icon: Iconsax.lock,
                obscureText: true,
              ),
              SizedBox(height: screenHeight * 0.1),
              customButton(
                title: 'Continue'.tr,
                style: Styles.style14,
                action: onTapNext,
                smallSize: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapNext(){
    if(controller.passwordController.text.isNotEmpty){
      Get.to(StoreInformationPage());
    }else{
      Get.snackbar('Error'.tr, 'Please fill empty field'.tr,snackPosition:
      SnackPosition.BOTTOM);
    }
  }
}
