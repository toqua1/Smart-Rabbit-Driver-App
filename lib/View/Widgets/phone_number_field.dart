import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../Utilities/app_styles.dart';
import '../../Utilities/constants.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onChanged;
  final void Function(String)? onCountryChanged;
  final bool isCreateOrder;
  const PhoneNumberField({
    required this.controller,
    required this.onChanged,
    this.onCountryChanged,
    required this.isCreateOrder,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration:isCreateOrder?
      InputDecoration(
        labelText: 'Phone Number'.tr,
        labelStyle: Styles.style12GreyColor,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 2.0),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent, width: 2.0),
        ),
        fillColor: const Color(0xffFAFAFF),
        filled: true,
      )
          :InputDecoration(
        labelText: 'Phone Number'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color:AppColors.accentColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
          BorderSide(color:AppColors.primaryColor, width: 2.0),
        ),
      ),
      initialCountryCode: 'SA',
      countries:
      countries.where((element) => ['SA', 'EG'].contains(element.code)).toList(),
      controller: controller,
      onChanged: (phone) {
        print('Current phone number: ${phone.completeNumber}');
        isCreateOrder?onChanged(phone.number)
        :onChanged(phone.completeNumber);
      },
      onCountryChanged: (country) {
        onCountryChanged?.call(country.dialCode);
      },

    );
  }
}
