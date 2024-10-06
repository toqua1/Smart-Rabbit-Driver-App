import 'dart:convert';
import 'package:get/get.dart';
import '../Models/driver_order_model.dart';
import 'driver_order_controller.dart';

class ScannerController extends GetxController {
  var scanResult = ''.obs;
  var selectedDriverOrder = Rx<DriverOrder?>(null);
  RxString receiveDate=''.obs;

  void updateScanResult(String result) {
    try {
      // Parse the JSON String result to Map
      Map<String, dynamic> jsonResult = json.decode(result);
      String orderId = jsonResult['_id'];
       
      // receiveDate.value=jsonResult['receiveDate'];
      //  
      selectedDriverOrder.value=getOrderById(orderId);
      scanResult.value = orderId;

    } catch (e) {
       
      scanResult.value = 'Invalid QR code'.tr;
    }
  }

  final DriverOrdersController controller = Get.put(DriverOrdersController());

  // Fetch order details by the scanned ID
  DriverOrder? getOrderById(String orderId) {
    try {
      return controller.orders.firstWhere((order) => order.orderDetails.id == orderId);
    } catch (e) {
       
      return null;
    }
  }

}