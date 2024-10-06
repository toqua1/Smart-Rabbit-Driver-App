import 'package:flutter/material.dart';
import '../../../Utilities/app_styles.dart';

class customTextField extends StatelessWidget {
  const customTextField({
    Key? key,
    required this.hintText,
    this.suffixIcon,
    required this.showBorder,
    required this.maxLines,
    required this.isReadOnly,
    this.onSuffixIconPressed,
    this.controller,
    required this.validator,
    this.keyboardType, this.color, this.borderColor,
  }) : super(key: key);

  final String hintText;
  final IconData? suffixIcon;
  final bool showBorder;
  final bool maxLines;
  final bool isReadOnly;
  final int? color ;
  final int? borderColor;
  final TextEditingController? controller;
  final Function()? onSuffixIconPressed;
  final String? Function(String?) validator;
  final TextInputType? keyboardType ;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines ? 3 : 1,
      readOnly: isReadOnly,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: Styles.style12GreyColor,
        suffixIcon: suffixIcon != null
            ? IconButton(
          icon: Icon(suffixIcon, color: Theme.of(context).primaryColor),
          onPressed: onSuffixIconPressed,
        )
            : null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: showBorder ? borderColor != null ?Color(borderColor!) :Theme.of(context)
                .primaryColor : Colors.transparent, width: 1.0,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: showBorder ? Theme.of(context).primaryColor : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        fillColor:color != null? Color(color!).withOpacity(0.3) :Colors.grey.shade200,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          height: 1.0, // Space reserved for error text
        ),
      ),
    );
  }
}