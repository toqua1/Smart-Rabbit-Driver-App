import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rabbit_second_app/Controllers/email_controller.dart';
import 'package:smart_rabbit_second_app/Controllers/phone_controller.dart';
import 'package:smart_rabbit_second_app/View/Create_account_pages/create_password_page.dart';
import 'package:smart_rabbit_second_app/View/Widgets/custom_button_edit.dart';
import 'package:smart_rabbit_second_app/View/Widgets/custom_textfeild_edit.dart';
import 'package:smart_rabbit_second_app/View/Widgets/phone_number_field.dart';
import '../../Utilities/app_styles.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final EmailController eController = Get.put(EmailController());

  final PhoneController controller = Get.put(PhoneController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.phoneController.text = '';
    eController.emailController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'.tr),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Phone Number'.tr, style: Styles.style14GreyColor),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                PhoneNumberField(
                  controller: controller.phoneController,
                  onChanged: (phone) {
                    controller.handlePhoneNumberChange(phone);
                    controller.updateButtonState();
                  },
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Text('Email'.tr, style: Styles.style14GreyColor),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                customTextField(
                  hintText: '',
                  showBorder: false,
                  controller: eController.emailController,
                  maxLines: false,
                  isReadOnly: false,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please fill the field'.tr;
                    }
                    return null;
                  },
                ),
                const Spacer(),
                Center(
                  child: customButton(
                    title: 'Save'.tr,
                    style: Styles.style14,
                    action: onTapNext,
                    smallSize: true,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void onTapNext() {
    if (_formKey.currentState!.validate() &&
        controller.phoneController.text.isNotEmpty) {
      if (eController.isEmailValid(eController.emailController.text)) {
        Get.to(CreatePasswordPage());
      } else {
        Get.snackbar('Error'.tr, 'Fill email correctly.'.tr);
      }
    } else {
      Get.snackbar('Error'.tr, 'Please fill empty fields'.tr);
    }
  }
}
