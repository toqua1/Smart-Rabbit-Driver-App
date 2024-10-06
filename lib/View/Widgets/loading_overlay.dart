import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:smart_rabbit_second_app/Utilities/constants.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var spin=SpinKitCircle(color: AppColors.primaryColor,);
    return Stack(
      children: [
        // Blur effect
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black.withOpacity(0.5), // semi-transparent black color
          ),
        ),
        // Loading indicator
        Center(
          child: spin
        ),
      ],
    );
  }
}
