
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:intl/intl.dart';
import '../API/Api_helper.dart';
import '../Models/driver_order_model.dart';

class WalletHistoryController extends GetxController {
  var isSearching = false.obs;
  var searchText = ''.obs;
  var balance = 0.0.obs;
  var isLoading = true.obs;
  var selectedDate = DateTime.now().obs;
  var orders = <DriverOrder>[].obs;
  var filteredOrders = <DriverOrder>[].obs;
  RxList searchResults = <DriverOrder>[].obs;
  RxList recentSearches = <DriverOrder>[].obs;
  final ApiData apiData = ApiData();

  @override
  void onInit() {
    super.onInit();
    fetchWalletBalance();
    fetchCompletedOrders();
  }

  // Fetch wallet balance from API
  void fetchWalletBalance() async {
    isLoading(true);
    final wallet = await apiData.getDriverWallet();
    if (wallet != null) {
      balance.value = wallet['balance'].toDouble();
    }
    isLoading(false);
  }

  // Fetch completed orders from API
  Future<void> fetchCompletedOrders() async {
    isLoading.value = true;
    final response = await apiData.getCompletedOrders();

    if (response != null && response.data['status'] == 'success') {
      List<dynamic> orderList = response.data['data']['orders'];
      orders.value = orderList.map((json) => DriverOrder.fromJson(json)).toList();
      filterOrdersBySelectedDate();
    } else {
       
    }
    isLoading.value = false;
  }
  void filterOrdersBySelectedDate() {
    filteredOrders.value = orders.where((order) {
      if (order.orderDetails.deliveredAt != null) {
        final orderDate = DateFormat('yyyy-MM-dd').format(order.orderDetails.deliveredAt!); // Use deliveredAt date
        final selected = DateFormat('yyyy-MM-dd').format(selectedDate.value);
        return orderDate == selected;
      }
      return false;
    }).toList();
  }

  // Helper to check if two dates are the same day
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  // Handle date selection from the calendar
  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
    filterOrdersBySelectedDate();
  }

  // Get formatted date for UI (Today, Yesterday, etc.)
  String getFormattedDate() {
    final now = DateTime.now();
    if (isSameDay(selectedDate.value, now)) {
      return 'Today'.tr;
    } else if (isSameDay(selectedDate.value, now.subtract(Duration(days: 1)))) {
      return 'Yesterday'.tr;
    } else if (isSameDay(selectedDate.value, now.add(Duration(days: 1)))) {
      return 'Tomorrow'.tr;
    } else {
      return DateFormat('yyyy-MM-dd').format(selectedDate.value);
    }
  }
  // Search orders by ID
  void searchOrders(String query) {
    searchText.value = query;

    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    // Filter completed orders based on query
    searchResults.value = orders
        .where((order) => order.id.startsWith(query))
        .toList();

    if (searchResults.isNotEmpty) {
      // Add successful searches to recent list
      recentSearches.add(searchResults.first);
    }
  }

  // Clear search history
  void clearSearchHistory() {
    recentSearches.clear();
    searchResults.clear();
  }
}
