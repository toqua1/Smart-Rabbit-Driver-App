import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../Controllers/wallet_controller.dart';
import '../../Utilities/app_styles.dart';
import '../../Utilities/constants.dart';
import 'widgets/payment_order_part.dart';
import 'widgets/wallet_app_bar.dart';
import 'widgets/wallet_transaction_card.dart';

class WalletHistoryScreen extends StatelessWidget {
  WalletHistoryScreen({super.key});
  final WalletHistoryController controller = Get.put(WalletHistoryController());

  @override
  Widget build(BuildContext context) {
    var spin = const SpinKitCircle(color: AppColors.primaryColor);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 5.sh),
        child: RefreshIndicator(
          onRefresh: () async{
            await controller.fetchCompletedOrders();
            controller.fetchWalletBalance();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WalletHistoryAppBar(),
              const PaymentOrderPart(),
              Padding(
                padding: EdgeInsets.only(left: 4.sw, top: 2.sh),
                child: Obx(
                      () => Text(
                    controller.getFormattedDate(),
                    style: Styles.styleBold20Nunito(context),
                  ),
                ),
              ),
              Obx(
                    () {
                  if (controller.isLoading.value) {
                    return Center(child: spin);
                  }

                  if (controller.filteredOrders.isEmpty) {
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
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: controller.filteredOrders.length, // Filtered by date
                        itemBuilder: (context, index) {
                          final order = controller.filteredOrders[index];
                          return WalletTransactionCard(
                            title: '${'Order'.tr}  ${index + 1}',
                            trackingId: order.id,
                            amount: '+ ${'SAR'.tr} ${order.orderDetails.total}',
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
