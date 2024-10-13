import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/Controllers/date_controller.dart';
import 'package:smart_rabbit_second_app/Utilities/app_styles.dart';
import 'package:smart_rabbit_second_app/View/History_orders/history_search_screen.dart';
import 'package:smart_rabbit_second_app/View/Home/widgets/order_list.dart';
import '../../Controllers/driver_order_controller.dart';
import '../../Controllers/store_information_controller.dart';

class OrderHistoryScreen extends StatelessWidget {
  OrderHistoryScreen({super.key});
  final DateTimePickerController dateTimePickerController =
      Get.put(DateTimePickerController());

  final DriverOrdersController controller = Get.put(DriverOrdersController());
  final StoreInformationController storeController =
      Get.put(StoreInformationController());
  final GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order History'.tr,
          style: Styles.styleBold24White,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.sw, vertical: 2.sh),
        child: ScreenTypeLayout.builder(
          mobile: (BuildContext context) =>
              _buildOrderHistory(context, cardHeight: 80, widthFactor: 1),
          tablet: (BuildContext context) => _buildOrderHistory(context,
              cardHeight: 100, padding: 20.0, widthFactor: 0.65),
        ),
      ),
    );
  }

  Widget _buildOrderHistory(BuildContext context,
      {required double cardHeight,
      required double widthFactor,
      double padding = 10.0}) {
    return Column(
      children: [
        Row(
          children: [
            Obx(
              () {
                if (controller.searchWithDate.value) {
                  return Row(
                    children: [
                      InkWell(
                          onTap: () => controller.clearSearchDate(),
                          child: const Icon(Icons.close)),
                      Text(
                        controller.searchDate.value.year ==
                                    DateTime.now().year &&
                                controller.searchDate.value.month ==
                                    DateTime.now().month &&
                                controller.searchDate.value.day ==
                                    DateTime.now().day
                            ? 'Today'.tr
                            : dateTimePickerController.datePicker.text,
                        style: Styles.style20BoldBlack,
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  Get.to(HistorySearchScreen());
                },
                icon: SvgPicture.asset('assets/Magnifier.svg')),
            IconButton(
                onPressed: () async {
                  await dateTimePickerController.selectDate(
                      context, dateTimePickerController.datePicker);
                  if (dateTimePickerController.selectedDate != null) {
                    controller
                        .setSearchDate(dateTimePickerController.selectedDate!);
                  }
                },
                icon: SvgPicture.asset('assets/🦆 icon _date_.svg'))
          ],
        ),
        Expanded(child: _buildContent(context, cardHeight, widthFactor)),
      ],
    );
  }

  Widget _buildContent(
      BuildContext context, double cardHeight, double widthFactor) {
    return Obx(
      () {
        if (controller.searchWithDate.value) {
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchDriverHistoryOrders();
                  },
                  child: OrderList(
                      history: true,
                      cardHeight: cardHeight,
                      orders: controller.historyOrdersSearchWDate),
                ),
              ),
            ],
          );
        }
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.fetchDriverHistoryOrders();
                },
                child: OrderList(
                    history: true,
                    cardHeight: cardHeight,
                    orders: controller.historyOrders),
              ),
            ),
          ],
        );
      },
    );
  }
}
