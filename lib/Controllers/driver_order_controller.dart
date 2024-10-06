import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smart_rabbit_second_app/API/Api_helper.dart';
import '../Models/driver_order_model.dart';

class DriverOrdersController extends GetxController {
  var orders = <DriverOrder>[].obs;
  var isLoading = false.obs;
  RxInt receivedCount = 0.obs;
  RxInt shippedCount = 0.obs;
  RxInt completeCount = 0.obs;
  RxInt recievedFromWarehouseCount = 0.obs;
  final ApiData apiHelper = ApiData();
  var role = ''.obs;  // For storing the driver's role

  @override
  void onInit() async {
    super.onInit();
    await _getUserRole();
    apiHelper.authToken = apiHelper.getToken() ?? '';
    await fetchDriverOrders();
  }

  Future<void> _getUserRole() async {
    final userData = await apiHelper.getUserData();
    role.value = userData['role'] ?? ''; // Fetch and store the driver's role
  }

  Future<void> fetchDriverOrders() async {
    isLoading.value = true;
     
    final startTime = DateTime.now();

    final response = await apiHelper.getDriverOrders();

    if (response != null && response.data['status'] == 'success') {
       
      List<dynamic> orderList = response.data['data']['orders'];
      orders.value = orderList.map((json) => DriverOrder.fromJson(json)).toList();
       
      _countOrdersByStatus();  // Update the counts based on order statuses
    } else {
       
    }
    isLoading.value = false;
    final endTime = DateTime.now();
     
  }

  // Count the number of orders by their status
  void _countOrdersByStatus() {
    receivedCount.value = orders.where((order) => order.status == 'Recieved').length;
    // shippedCount.value += orders.where((order) => order.status == 'Shipped').length;
    shippedCount.value=GetStorage().read('shipCount') ?? 0;
    completeCount.value = orders.where((order) => order.status == 'Complete').length;
    recievedFromWarehouseCount.value = orders.where((order) => order.status == 'Recieved From Warehouse').length;
  }
  DriverOrder? getOrderById(String id) {
    return orders.firstWhereOrNull((order) => order.orderDetails.id == id);
  }
}

