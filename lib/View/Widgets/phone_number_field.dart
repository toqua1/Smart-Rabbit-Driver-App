import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../Utilities/app_styles.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final void Function(String)? onCountryChanged;
  // final bool isCreateOrder;
  const PhoneNumberField({
    required this.controller,
    required this.onChanged,
    this.onCountryChanged,
    // required this.isCreateOrder,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      invalidNumberMessage: 'Invalid Mobile Number'.tr,
      decoration:
      // isCreateOrder?
      InputDecoration(
        labelText: 'Phone Number'.tr,
        labelStyle: Styles.style12GreyColor,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 2.0),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.transparent, width: 2.0),
        ),
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      //     :InputDecoration(
      //   labelText: 'Phone Number'.tr,
      //   border: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(30),
      //     borderSide: BorderSide(color:AppColors.accentColor),
      //   ),
      //   focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(30),
      //     borderSide:
      //     BorderSide(color:AppColors.primaryColor, width: 2.0),
      //   ),
      // ),
      initialCountryCode: 'SA',
      countries:
      countries.where((element) => ['SA', 'EG'].contains(element.code)).toList(),
      controller: controller,
      onChanged: (phone) {
         
        //  
        // isCreateOrder?
        // onChanged(phone.number);
        // :
        onChanged(phone.completeNumber);
      },
      onCountryChanged: (country) {
        onCountryChanged?.call(country.dialCode);
      },

    );
  }
}
