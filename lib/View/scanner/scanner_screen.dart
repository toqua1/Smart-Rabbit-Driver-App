import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/Utilities/constants.dart';
import '../../Utilities/open_scanner.dart';

class ScannerScreen extends StatelessWidget {
   const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'.tr ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                openScanner(context);
              },
              child: Text('Open Scanner'.tr,style: TextStyle(fontSize: 5.sw,
                  color:
              AppColors.primaryColor),),
            ),
            SizedBox(height: 3.sh),
          ],
        ),
      ),
    );
  }
}
