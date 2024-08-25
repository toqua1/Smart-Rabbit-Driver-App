// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smart_rabbit/View/Widgets/inter_text_style.dart';
//
// import '../../Controller/create_account_controller.dart';
// import '../Widgets/custom_button.dart';
//
// import '../Widgets/custom_textfiled.dart';
// import '../Widgets/phone_number_field.dart';
// import '../Widgets/upload_image.dart';
//
// class CreateAccountPage extends GetView<RegistrationController> {
//   const CreateAccountPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//      appBar: AppBar(),
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(18.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: screenHeight * 0.01,
//                   ),
//                   const Text(
//                     "Create Account",
//                     style: TextStyle(
//                       fontSize: 35,
//                       fontFamily: 'SF Pro Display',
//                       fontWeight: FontWeight.w400,
//                       height: 0.05,
//                       letterSpacing: 0.28,
//                     ),
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.03,
//                   ),
//                   const Text(
//                     'Please fill in the details to create your account',
//                     style: TextStyle(
//                       color: Color(0xFF6B7280),
//                       fontSize: 16,
//                       fontFamily: 'SF Pro Display',
//                       fontWeight: FontWeight.w400,
//                       letterSpacing: 0.16,
//                     ),
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.03,
//                   ),
//                   CustomTextField(
//                     labelText: 'Username',
//                     hintText: 'Please enter username',
//                     controller: controller.usernameController,
//                     icon: Iconsax.user,
//                     obscureText: false,
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.015,
//                   ),
//                   CustomTextField(
//                     labelText: 'Email',
//                     hintText: 'Please enter email',
//                     controller: controller.emailController,
//                     icon: Iconsax.sms,
//                     obscureText: false,
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.015,
//                   ),
//                   PhoneNumberField(
//                     controller: controller.phoneController,
//                     onChanged: (phone) {
//                       print("Updated phone number: $phone"); // Additional logging if needed
//                       controller.handlePhoneNumberChange(phone);
//                       controller.updateButtonState();
//                     },
//                   ),
//                   CustomTextField(
//                     labelText: 'Password',
//                     hintText: 'Please enter password',
//                     controller: controller.passwordController,
//                     icon: Iconsax.lock,
//                     obscureText: true,
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.015,
//                   ),
//                   CustomTextField(
//                     labelText: 'Confirm Password',
//                     hintText: 'Please enter password',
//                     controller: controller.confirmPasswordController,
//                     icon: Iconsax.lock,
//                     obscureText: true,
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.015,
//                   ),
//                   CustomTextField(
//                     labelText: 'National ID Number',
//                     hintText: 'Please enter National ID Number',
//                     controller: controller.nationalIdController,
//                     icon: Iconsax.barcode,
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.015,
//                   ),
//                   CustomTextField(
//                     labelText: 'Tax Number',
//                     hintText: 'Please enter Tax Number',
//                     controller: controller.taxNumberController,
//                     icon: Iconsax.bill,
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.015,
//                   ),
//                   CustomTextField(
//                     labelText: 'City',
//                     hintText: 'Please enter the city',
//                     controller: controller.cityController,
//                     icon: Iconsax.home,
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.015,
//                   ),
//                   CustomTextField(
//                     labelText: 'Neighbourhood',
//                     hintText: 'Please enter the neighbourhood',
//                     controller: controller.neighborhoodController,
//                     icon: Iconsax.home,
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.015,
//                   ),
//                   CustomTextField(
//                     labelText: 'Street',
//                     hintText: 'Please enter the street',
//                     controller: controller.streetController,
//                     icon: Iconsax.home,
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.015,
//                   ),
//                   CustomTextField(
//                     labelText: 'Product Type',
//                     hintText: 'Please enter the product type',
//                     controller: controller.productTypeController,
//                     icon: Iconsax.shopping_cart,
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.015,
//                   ),
//                   InterTextStyle.getTextWidget(
//                       text: "National ID Card (front)", size: 20),
//                   ImageUploadContainer(storageKey: 'IDFrontImage',),
//                   SizedBox(
//                     height: screenHeight * 0.015,
//                   ),
//                   InterTextStyle.getTextWidget(
//                       text: "National ID Card (back)", size: 20),
//                   ImageUploadContainer(storageKey: 'IDBackImage'),
//                   SizedBox(
//                     height: screenHeight * 0.015,
//                   ),
//                   InterTextStyle.getTextWidget(
//                       text: "Tax Number Photo", size: 20),
//                   ImageUploadContainer(storageKey: 'TaxImage'),
//                   SizedBox(
//                     height: screenHeight * 0.05,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       TextButton(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         style: TextButton.styleFrom(
//                           padding: EdgeInsets.zero,
//                         ),
//                         child: RichText(
//                           text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: "Already have an account? ",
//                                 style: TextStyle(
//                                   fontSize: screenHeight * 0.02, // Adjusted size
//                                   color: Colors.grey, // Grey color for the first part
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: "Login now",
//                                 style: TextStyle(
//                                   fontSize: screenHeight * 0.02, // Adjusted size
//                                   color: Color(0xFF3366FF), // Blue color for "Login now"
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                     ],
//                   ),
//                   SizedBox(
//                     height: screenHeight * 0.008,
//                   ),
//                   Obx(() {
//                     return CustomButton(
//                       onPressed: controller.isButtonEnabled.value
//                           ? () async {
//                               try {
//                                 await controller.registerUser(
//                                   name: controller.usernameController.text,
//                                   email: controller.emailController.text,
//                                   password: controller.passwordController.text,
//                                   confirmPassword: controller.confirmPasswordController.text,
//                                   nationalId: controller.nationalIdController.text,
//                                   taxNumber: controller.taxNumberController.text,
//                                   city: controller.cityController.text,
//                                   neighborhood: controller.neighborhoodController.text,
//                                   street: controller.streetController.text,
//                                   productType: controller.productTypeController.text,
//                                 );
//                                 SharedPreferences prefs =
//                                     await SharedPreferences.getInstance();
//                                 await prefs.setBool('isLoggedIn', true);
//                                 // Get.to(() => const InterestsPage(),
//                                 //     transition: Transition.rightToLeftWithFade,
//                                 //     duration: const Duration(milliseconds: 500));
//                               } catch (e) {
//                                 print('Registration failed: $e');
//                               }
//                             }
//                           : null,
//                       text: 'Create Account',
//                       isButtonEnabled: controller.isButtonEnabled.value,
//                     );
//                   }),
//
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
