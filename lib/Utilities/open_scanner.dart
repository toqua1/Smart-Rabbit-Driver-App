import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:smart_rabbit_second_app/Utilities/responsive_function.dart';
import 'package:smart_rabbit_second_app/Utilities/show_order_details.dart';
import 'package:smart_rabbit_second_app/View/Home/widgets/order_item.dart';
import '../Controllers/scan_controller.dart';
import '../Models/driver_order_model.dart';
import '../View/Widgets/constants.dart';

final ScannerController controller=Get.put(ScannerController());

Future<void> openScanner(BuildContext context) async {

  void showBottomSheet(DriverOrder? order) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('QR Code scan successful'.tr,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            OrderItem(
                order: controller.selectedDriverOrder.value!,
                cardHeight: responsiveSize(context, 80, 100),
                count: 1,
                isWallet:false),
          ],
        ),
      ),
    );
  }

  var result = await Get.to(() => const SimpleBarcodeScannerPage());
  if (result != '-1') {
    controller.updateScanResult(result);
    if(controller.scanResult.isNotEmpty && controller.selectedDriverOrder.value != null){
      showBottomSheet(controller.selectedDriverOrder.value);
    }else{
      Get.snackbar('Error'.tr, 'Invalid QR code'.tr,backgroundColor:const Color
        (0xffFF0000).withOpacity(0.5),snackPosition: SnackPosition.BOTTOM);
    }
  }

}