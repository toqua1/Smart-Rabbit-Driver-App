import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/Utilities/responsive_function.dart';

class PaymentOrderPartItem extends StatelessWidget {
  const PaymentOrderPartItem({
    super.key,
    required this.isActive,
    required this.title,
    required this.onTap,
  });

  final bool isActive;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: responsiveSize(context, 25.sw, 20.sw),
        height: 5.sh,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.50,
              color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          shadows: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 1,
            )
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 3.sw,
            color: isActive ? Theme.of(context).primaryColor : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
