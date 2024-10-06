import 'package:flutter/material.dart';
import 'package:get/get.dart';

class customButton extends StatelessWidget {
  const customButton({
    super.key, required this.title, required this.style, required this.action, this.smallSize,
  });
  final String title ;
  final TextStyle style ;
  final Function? action;
  final bool? smallSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19.0),
      child: ElevatedButton(
        onPressed: () async {
          if (action != null) {
            final result = action!(); // Call the action (either void or Future)
            if (result is Future) {
              await result; // If it's a Future, we await it
            }
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor:title=='Cancelled'.tr?Colors.white :Theme.of(context)
              .primaryColor,
          minimumSize:Size(smallSize != null ? 225 : double.infinity, 50), //
          // Full-width button
        ),
        child:Text(title,style: style),
      ),
    );
  }
}