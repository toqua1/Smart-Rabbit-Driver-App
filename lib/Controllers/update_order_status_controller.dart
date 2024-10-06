
import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_rabbit_second_app/Controllers/driver_order_controller.dart';
import '../API/Api_helper.dart';

class OrderStatusController extends GetxController {
  final ApiData _apiData = ApiData();
  final DriverOrdersController controller = Get.find();
  RxMap<String, bool> isLoadingMap = <String, bool>{}.obs;
  final GetStorage storage=GetStorage();

  Future<void> updateOrderStatus(String orderId, String status, String
  shippedType ,String notes) async {
    isLoadingMap[orderId] = true;

    // Fetch the current order details (null check added)
    final order = controller.getOrderById(orderId);
    if (order == null) {
      isLoadingMap[orderId] = false;
      Get.snackbar('Error', 'Order not found', backgroundColor: const Color(0xffFF0000).withOpacity(0.5));
      return; // Exit the function if the order is not found
    }

    // Check if driverReceivedDate is already set or null, and conditionally set it
    String? driverReceivedDate = order.orderDetails.driverRecievedDate == null
        ? (status == 'Recieved' ? DateTime.now().toIso8601String() : null)
        : order.orderDetails.driverRecievedDate?.toIso8601String();

    // Check if wareHouseDate is already set or null, and conditionally set it
    String? wareHouseDate = order.orderDetails.wareHouseDate == null
        ? (status == 'Shipped' ? DateTime.now().toIso8601String() : null)
        : order.orderDetails.wareHouseDate?.toIso8601String();

    // Check if driverTransferredDate is already set or null, and conditionally set it
    String? recieveFromWareHouseDate = order.orderDetails.recieveFromWareHouseDate == null
        ? (status == 'Recieved From Warehouse' ? DateTime.now().toIso8601String() : null)
        : order.orderDetails.recieveFromWareHouseDate?.toIso8601String();

    // Check if deliveredAt is already set or null, and conditionally set it
    String? deliveredAt = order.orderDetails.deliveredAt == null
        ? (status == 'Complete' ? DateTime.now().toIso8601String() : null)
        : order.orderDetails.deliveredAt?.toIso8601String();

    Map<String, dynamic> requestBody = {
      'status': status,
      'shippedType': status == 'Shipped' ? 'Delivery' : shippedType,
      'driverRecievedDate': driverReceivedDate,
      'wareHouseDate': wareHouseDate,
      'recieveFromWareHouseDate': recieveFromWareHouseDate,
      'deliveredAt': deliveredAt,
      'notes':notes
    };

    final response = await _apiData.updateOrderStatus(orderId, requestBody);
    isLoadingMap[orderId] = false;

    if (response != null && response.statusCode == 200) {
      if(status=='Shipped'){
        controller.shippedCount.value++;
        storage.write('shipCount', controller.shippedCount.value);
      }
      controller.fetchDriverOrders();
      Get.snackbar('Success'.tr, '${'Order status updated to'.tr} ${status.tr}',
          backgroundColor: const Color(0xff008000).withOpacity(0.5));
    } else {
      Get.snackbar('Error'.tr, '${'Failed to update order'.tr} ${status.tr}',
          backgroundColor: const Color(0xffFF0000).withOpacity(0.5));
    }
  }
}
