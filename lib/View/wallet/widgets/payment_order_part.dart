import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/View/wallet/widgets/payment_order_part_item.dart';
import '../../../Controllers/payment_controller.dart';
import '../../../Utilities/responsive_function.dart';

class PaymentOrderPart extends StatelessWidget {
  const PaymentOrderPart({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController paymentController = Get.put(PaymentController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.sh),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Obx(() {
            return Padding(
              padding:EdgeInsets.symmetric(vertical: 1.sh,horizontal: 2.sw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PaymentOrderPartItem(
                    isActive: paymentController.selectedPaymentMethod.value == 'All',
                    title: 'All'.tr,
                    onTap: () => paymentController.setSelectedPaymentMethod('All'),
                  ),
                  SizedBox(width: responsiveSize(context, 16, 5.sw)),
                  PaymentOrderPartItem(
                    isActive: paymentController.selectedPaymentMethod.value == 'Cash',
                    title: 'Cash'.tr,
                    onTap: () => paymentController.setSelectedPaymentMethod('Cash'),
                  ),
                  SizedBox(width: responsiveSize(context, 16, 5.sw)),
                  PaymentOrderPartItem(
                    isActive: paymentController.selectedPaymentMethod.value == 'Online',
                    title: 'Online'.tr,
                    onTap: () {
                      // paymentController.setSelectedPaymentMethod('Online');
                      Get.snackbar('Unavailable'.tr, 'Online payment is currently '
                          'not available.'.tr,snackPosition: SnackPosition.BOTTOM);
                    }
                  ),
                  SizedBox(width: responsiveSize(context, 16, 5.sw)),
                  PaymentOrderPartItem(
                    isActive: paymentController.selectedPaymentMethod.value == 'Wallet',
                    title: 'Wallet'.tr,
                    onTap: () {
                      // paymentController.setSelectedPaymentMethod('Wallet');
                      Get.snackbar('Unavailable'.tr, 'Wallet payment is currently not available.'.tr,snackPosition: SnackPosition.BOTTOM);
                    }
                   ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}

