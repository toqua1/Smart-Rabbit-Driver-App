import 'package:flutter/material.dart';
import '../../../Controllers/driver_order_controller.dart';
import '../../../Models/driver_order_model.dart';
import 'order_item.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderList extends StatelessWidget {
  final double cardHeight;
  final List<DriverOrder> orders;

  const OrderList({super.key, required this.orders, required this.cardHeight});

  @override
  Widget build(BuildContext context) {
    final DriverOrdersController controller = Get.find();

    return Obx(() {
      if (controller.isLoading.value) {
        // Show skeleton loading while fetching data
        return Skeletonizer(
          enabled: true,
          child: ListView.builder(
            itemCount: 10, // Display placeholder skeletons
            itemBuilder: (context, index) {
              return const Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  title: Text('Loading...'), // Placeholder text for skeleton
                  subtitle: Text('Please wait...'),
                  trailing: Icon(Icons.hourglass_empty),
                ),
              );
            },
          ),
        );
      } else if (orders.isEmpty) {
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchDriverOrders();
          },
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Center(
                  child: Text('No orders available'.tr),
                ),
              ),
            ],
          ),
        );
      } else {
        // Data is available, show the list of orders
        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return OrderItem(
              order: order,
              cardHeight: cardHeight,
              count: index + 1,
              isWallet: false,
            );
          },
        );
      }
    });
  }
}
