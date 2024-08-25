import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomOutlinedButton  extends StatelessWidget {
  final String buttonText;
  final IconData iconData;
  final Color iconColor;
  final VoidCallback? onPressed;

  const CustomOutlinedButton({
    Key? key,
    required this.buttonText,
    required this.iconData,
    required this.iconColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.02), // Adjust padding relative to screen width
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFCAE2FF), // Set background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.025), // Adjust border radius relative to screen width
          ),
          minimumSize: Size(0, screenHeight * 0.07), // Set minimum height relative to screen height
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FaIcon(
              iconData,
              size: screenWidth * 0.06,
              color: iconColor,
            ),
            SizedBox(width: screenWidth * 0.02), // Adjust spacing relative to screen width
            Text(
              buttonText,
              style: TextStyle(
                fontSize: screenHeight * 0.02, // Adjust font size relative to screen height
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            const SizedBox(width: 20,)
          ],
        ),
      ),
    );
  }
}
