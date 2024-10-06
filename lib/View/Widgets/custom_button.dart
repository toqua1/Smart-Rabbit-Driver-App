import 'package:flutter/material.dart';
import '../../Utilities/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const CustomButton({
    required this.onPressed,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Builder(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: screenHeight * 0.06,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, Colors.indigoAccent.shade700],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(25)),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                foregroundColor:Colors.white,
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.transparent,
              ),
              onPressed:onPressed ,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
