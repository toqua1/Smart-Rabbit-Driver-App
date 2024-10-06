import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/Models/driver_order_model.dart';
import 'package:smart_rabbit_second_app/View/Home/widgets/custom_drawer.dart';
import 'package:smart_rabbit_second_app/View/Home/widgets/home_app_bar.dart';
import 'package:smart_rabbit_second_app/View/Home/widgets/order_list.dart';
import 'package:smart_rabbit_second_app/View/Home/widgets/order_summary_card.dart';
import '../../Controllers/driver_order_controller.dart';
import '../../Controllers/store_information_controller.dart';
import '../../Utilities/constants.dart';

class OrderListScreen extends StatelessWidget {
  OrderListScreen({super.key});

  final DriverOrdersController controller = Get.put(DriverOrdersController());
  final StoreInformationController storeController = Get.put(StoreInformationController());
  final GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: const HomeAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.sw, vertical: 2.sh),
        child: ScreenTypeLayout.builder(
          mobile: (BuildContext context) => _buildOrderList(context, cardHeight: 80, widthFactor: 1),
          tablet: (BuildContext context) => _buildOrderList(context, cardHeight: 100, padding: 20.0, widthFactor: 0.65),
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, {required double cardHeight, required double widthFactor, double padding = 10.0}) {
    return Obx(() {
      if (controller.role.value == 'Pickup/Delivery') {
        // Two-tab view for Pickup/Delivery role
        return Column(
          children: [
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    flexibleSpace: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TabBar(
                          indicatorWeight: 0.5.sh,
                          unselectedLabelStyle: TextStyle(
                              fontSize: 3.5.sw ,
                              // fontWeight: FontWeight.w800,
                              color: Colors.grey
                          ),
                          labelStyle: TextStyle(
                              fontSize: 4.sw ,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryColor
                          ),
                          tabs: [
                            Tab(text: 'Pick Up'.tr),
                            Tab(text: 'Drop Off'.tr),
                          ],
                        ),
                      ],
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                  body: TabBarView(
                    children: [
                      _buildTabContent(context, 'Pickup', cardHeight, widthFactor),
                      _buildTabContent(context, 'Delivery', cardHeight, widthFactor),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      } else {
        // Single view for Pickup-only or Delivery-only roles
        String roleType = controller.role.value == 'Pickup' ? 'Pickup' : 'Delivery';
        return Column(
          children: [
            OrderSummaryCard(
              borderRadius: 20.0,
              padding: const EdgeInsets.symmetric(vertical: 30),
              widthFactor: widthFactor,
              receiveCount: roleType =='Pickup'?controller.receivedCount
                  .value:controller.recievedFromWarehouseCount.value,
              sentCount: roleType =='Pickup'?controller.shippedCount
                  .value:controller
                  .completeCount.value,
            ),
            SizedBox(height: 3.sh),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.fetchDriverOrders();
                },
                child: OrderList(cardHeight: cardHeight, orders:
                roleType =='Pickup'?
                controller.orders.where((order) =>
                order.shippedType == 'Pickup' && order.status != 'Shipped'
                    && order.status != 'Cancelled'
                ).toList()

                    :controller.orders.where((order) => order.shippedType ==
                    'Delivery' && order.status != 'Complete' && order.status != 'Shipped'
                    && order.status != 'Back To Warehouse'
                ).toList() ),
              ),
            ),
          ],
        );
      }
    });
  }

  Widget _buildTabContent(BuildContext context, String type, double cardHeight, double widthFactor) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 1.sw),
          child: Obx(()=>
            OrderSummaryCard(
              borderRadius: 20.0,
              padding: const EdgeInsets.symmetric(vertical: 30),
              widthFactor: widthFactor,
              receiveCount: type=='Pickup'?controller.receivedCount.value:controller.recievedFromWarehouseCount.value,
              sentCount:type=='Pickup'?controller.shippedCount.value:controller.completeCount.value,
            ),
          ),
        ),
        SizedBox(height: 3.sh),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              await controller.fetchDriverOrders();
            },
            child: OrderList(
                cardHeight: cardHeight,
                orders: type=='Pickup'?controller.orders.where((order) =>
                order.shippedType == 'Pickup'  && order.status != 'Shipped'
                    && order.orderDetails.orderStatus != 'Cancelled'
                ).toList()

                    :controller.orders.where((order) => order.shippedType ==
                    'Delivery' && order.status != 'Complete' && order.status != 'Shipped'
                    && order.status != 'Back To Warehouse'
                ).toList()
            ),
          ),
        ),
      ],
    );
  }
}
