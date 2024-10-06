import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/View/Home/order_details_screen.dart';
import '../../Controllers/update_order_status_controller.dart';
import '../../Models/driver_order_model.dart';
import '../../Utilities/constants.dart';
import '../../Utilities/responsive_function.dart';
import '../../Utilities/show_order_details.dart';

class OrderItemButton extends StatelessWidget {
  OrderItemButton({
    super.key,
    required this.order,
  });
  final OrderStatusController orderStatusController = Get.put(OrderStatusController());
  final DriverOrder order;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        onPressed: () {
          // showOrderDetailsDialog(context, order);
        Get.to(OrderDetailsScreen(order: order),
        transition:Transition.rightToLeft);
        },
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(
              horizontal: responsiveSize(context, 12, 30),
              vertical: responsiveSize(context, 12, 15)),
          backgroundColor: AppColors.primaryColor,
        ),
        child: orderStatusController.isLoadingMap[order.id] == true
            ? const CircularProgressIndicator(
                color: AppColors.primaryColor,
              )
            : Text(
                'Details'.tr,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: responsiveSize(context, 3.sw, 2.6.sw)),
              ),
      ),
    );
  }
}
