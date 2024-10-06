
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/Utilities/app_styles.dart';
import 'package:smart_rabbit_second_app/Utilities/constants.dart';
import 'package:smart_rabbit_second_app/Utilities/responsive_function.dart';
import '../../../Controllers/date_controller.dart';
import '../../../Controllers/wallet_controller.dart';
import '../search_screen.dart';

class WalletHistoryAppBar extends StatelessWidget {
  final WalletHistoryController walletController = Get.put(WalletHistoryController());
  final DateTimePickerController dateTimePickerController = Get.put(DateTimePickerController());

  WalletHistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.0),
        ),
      ),
      child: _buildAppBar(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsiveSize(Get.context!, 0, 5.sw)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(top: responsiveSize(Get.context!, 4.sh, 0)),
                child: Text(
                  'Wallet History'.tr,
                  style: Styles.styleBold20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Text(
            'Available balance'.tr,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 5.0),
          Obx(
                () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${'SAR'.tr} ${walletController.balance.value.toStringAsFixed(2)}',
                  style: Styles.styleBold24White,
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search_rounded, color: Colors.white, size: 4.5.sh),
                      onPressed: () {
                        Get.to(() => SearchScreen());
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_month, color: Colors.white, size: 4.sh),
                      onPressed: () async {
                        await dateTimePickerController.selectDate(context, dateTimePickerController.datePicker);
                        DateTime? selectedDate = DateFormat('yyyy-MM-dd').parse(dateTimePickerController.datePicker.text);
                        walletController.updateSelectedDate(selectedDate);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
