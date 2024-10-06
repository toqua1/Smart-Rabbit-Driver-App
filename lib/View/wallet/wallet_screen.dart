import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_rabbit_second_app/Utilities/responsive_function.dart';
import 'package:smart_rabbit_second_app/View/Home/widgets/order_item.dart';
import '../../Controllers/driver_order_controller.dart';
import '../../Controllers/wallet_controller.dart';
import '../../Utilities/app_styles.dart';
import 'widgets/payment_order_part.dart';
import 'widgets/wallet_app_bar.dart';

class WalletHistoryScreen extends StatelessWidget {
  WalletHistoryScreen({super.key});
  final WalletHistoryController controller = Get.put(WalletHistoryController());
  final DriverOrdersController controllerDriver = Get.put(DriverOrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 5.sh),
        child: RefreshIndicator(
          onRefresh: () async {
            if (controllerDriver.role.value != 'Pickup') {
              await controller.fetchCompletedOrders();
              controller.fetchWalletBalance();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WalletHistoryAppBar(),
              const PaymentOrderPart(),
              Padding(
                padding: EdgeInsets.only(left: 4.sw, top: 2.sh, right: 4.sw),
                child: Obx(
                      () => Text(
                    controller.getFormattedDate(),
                    style: Styles.styleBold20Nunito(context),
                  ),
                ),
              ),
              controllerDriver.role.value == 'Pickup'
                  ? Column(
                children: [
                  SizedBox(height: 3.sh),
                  Center(
                    child: Text(
                      'Wallet is not available at Pickup role'.tr,
                      style: TextStyle(
                        fontSize: 4.sw,
                        fontFamily: GoogleFonts.nunito().fontFamily,
                      ),
                    ),
                  ),
                ],
              )
                  : Expanded( // Wrap with Expanded to avoid layout issues
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return Skeletonizer(
                      enabled: true,
                      child: ListView.builder(
                        itemCount: 10, // Display placeholder skeletons
                        itemBuilder: (context, index) {
                          return const Card(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: ListTile(
                              title: Text('Loading...'),
                              subtitle: Text('Please wait...'),
                              trailing: Icon(Icons.hourglass_empty),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (controller.filteredOrders.isEmpty) {
                    return Center(
                      child: Text(
                        'No orders available'.tr,
                        style: TextStyle(
                          fontSize: 4.sw,
                          fontFamily: GoogleFonts.nunito().fontFamily,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: controller.filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = controller.filteredOrders[index];
                        return OrderItem(
                          order: order,
                          cardHeight: responsiveSize(context, 80, 100),
                          count: index + 1,
                          isWallet: true,
                        );
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
