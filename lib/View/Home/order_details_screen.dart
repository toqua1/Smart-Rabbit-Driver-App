import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/Utilities/constants.dart';
import 'package:smart_rabbit_second_app/Utilities/responsive_function.dart';
import 'package:smart_rabbit_second_app/View/Widgets/custom_textfeild_edit.dart';
import '../../Controllers/update_order_status_controller.dart';
import '../../Models/driver_order_model.dart';
import '../../Utilities/app_styles.dart';
import '../Widgets/custom_button_edit.dart';
import '../Widgets/custom_google_maps.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key, required this.order});
  final DriverOrder order;
  final OrderStatusController orderStatusController =
      Get.put(OrderStatusController());
  final TextEditingController notesCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final bool isArabic = Get.locale?.languageCode == 'ar';
    final bool isCahDelivery = order.shippedType == 'Pickup' &&
        order.orderDetails.cashHandlingType == 'delivery';
    final bool isCashTotal = order.shippedType == 'Delivery' &&
        order.orderDetails.cashHandlingType == 'total';

    String name = '';
    String address = '';
    String phoneNumber = '';

    // Check the shipped type
    if (order.shippedType == 'Pickup') {
      name = 'Store'.tr;
      address = order.orderDetails.pickupAddress;
      phoneNumber = order.orderDetails.storePhoneNumber;
    } else if (order.shippedType == 'Delivery') {
      name = ' ${order.orderDetails.receiverName}';
      address = order.orderDetails.receiverAddress;
      phoneNumber = order.orderDetails.receiverPhoneNumber;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Order Details'.tr)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: responsiveSize(context, 3.sw, 10.sw), vertical: 4.sh),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Reminder widget
              isCahDelivery || isCashTotal
                  ? Container(
                      padding: const EdgeInsets.all(20),
                      margin:
                          EdgeInsets.only(bottom: 2.sh, left: 2.sw, right: 5
                              .sw),
                      decoration: BoxDecoration(
                        color: Colors.yellow[100], // Light yellow background
                        borderRadius: isArabic
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                // topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))
                            : const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ), // Rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Text(isCahDelivery
                          ? 'Don\'t forget to get delivery price only from store'
                              .tr
                          : isCashTotal
                              ? 'Don\'t forget to get total order price from receiver'
                                  .tr
                              : ''),
                    )
                  : SizedBox(
                      height: 7.sh,
                    ),
              buildDetailRow('Name'.tr, name),
              buildDetailRow('Phone Number'.tr, phoneNumber),
              buildDetailRow('Address'.tr, address),
              Divider(indent: 2.sw, endIndent: 2.sw),
              buildDetailRow('Total'.tr,
                  'SAR ${order.orderDetails.total.toStringAsFixed(2)}'),
              buildDetailRow(
                  'Payment Method'.tr, order.orderDetails.paymentMethod),
              buildDetailRow(
                  'Transaction & Track ID'.tr, order.orderDetails.id),
              SizedBox(height: 5.sh),
              Text(
                'Notes'.tr,
                style: Styles.styleBold16Primary.copyWith(fontSize: 3.5.sw),
              ),
              SizedBox(height: 2.sh),
              customTextField(
                  hintText: 'Enter your notes'.tr,
                  showBorder: true,
                  maxLines: true,
                  isReadOnly: false,
                  controller: notesCon,
                  validator: (String? value) {
                    return null;
                  }),
              SizedBox(
                height: responsiveSize(context, 22.sh, 26.sh),
              ),
              Center(
                child: Row(
                  children: [
                    Expanded(
                      child: customButton(
                        smallSize: true,
                        action: orderStatusController.isLoadingMap[order.id] ==
                                true
                            ? null
                            : () async {
                                if (order.status == 'Assigned') {
                                  await orderStatusController.updateOrderStatus(
                                      order.orderDetails.id,
                                      'Recieved',
                                      order.shippedType,
                                      notesCon.text);
                                } else if (order.status == 'Recieved') {
                                  await orderStatusController.updateOrderStatus(
                                      order.orderDetails.id,
                                      'Shipped',
                                      order.shippedType,
                                      notesCon.text);
                                }
                                // else if (order.status == 'Shipped') {
                                //   await orderStatusController.updateOrderStatus(
                                //       order.orderDetails.id,
                                //       'Transfered',
                                //       order.shippedType,
                                //       notesCon.text
                                //   );
                                // }
                                else if (order.status == 'Transfered') {
                                  await orderStatusController.updateOrderStatus(
                                      order.orderDetails.id,
                                      'Recieved From Warehouse',
                                      order.shippedType,
                                      notesCon.text);
                                } else if (order.status ==
                                    'Recieved From Warehouse') {
                                  await orderStatusController.updateOrderStatus(
                                      order.orderDetails.id,
                                      'Complete',
                                      order.shippedType,
                                      notesCon.text);
                                } else if (order.status == 'Cancelled') {
                                  await orderStatusController.updateOrderStatus(
                                      order.orderDetails.id,
                                      'Back To Warehouse',
                                      order.shippedType,
                                      notesCon.text);
                                }
                                Navigator.of(context).pop();
                              },
                        title: order.status == 'Assigned'
                            ? 'Received Done'.tr
                            : order.status == 'Recieved'
                                ? 'Shipped Done'.tr
                                : order.status == 'Transfered'
                                    ? 'Received From Warehouse Done'.tr
                                    : order.status == 'Recieved From Warehouse'
                                        ? 'Completed Done'.tr
                                        : order.status == 'Cancelled'
                                            ? 'Back To Warehouse Done'.tr
                                            : '',
                        style: Styles.styleBold12
                            .copyWith(color: Colors.white, fontSize: 1.5.sh),
                      ),
                    ),
                    order.status == 'Recieved From Warehouse'
                        ? Expanded(
                            child: customButton(
                                title: 'Cancelled'.tr,
                                style: Styles.styleBold12Red
                                    .copyWith(fontSize: 1.5.sh),
                                action: () async {
                                  await orderStatusController.updateOrderStatus(
                                      order.orderDetails.id,
                                      'Cancelled',
                                      order.shippedType,
                                      notesCon.text);
                                  Navigator.of(context).pop();
                                }),
                          )
                        : SizedBox(
                            width: 1,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 13.sh,left: 2.sw,right: 2.sw),
        child: SizedBox(
          width: responsiveSize(context, 15.sw, 10.sw),
          height:  responsiveSize(context, 15.sw, 10.sw),
          child: FloatingActionButton(
            onPressed: () async{
              String address = order.shippedType == 'Pickup'
                  ? order.orderDetails.pickupAddress
                  : order.orderDetails.receiverAddress;
              try {
                // Fetch coordinates from address
                List<Location> locations =
                await locationFromAddress(address);
                if (locations.isNotEmpty) {
                  Location location = locations.first;
                  LatLng coordinates =
                  LatLng(location.latitude, location.longitude);

                  // Navigate to the map screen with coordinates
                  Get.to(() => CustomGoogleMap(
                    receiverLocation: coordinates,
                    receiverAddress: address,
                    phone: phoneNumber,
                  ));
                } else {
                  // Handle no results found
                  Get.snackbar('Error'.tr,
                      'No coordinates found for this address.'.tr);
                }
              } catch (e) {
                // Handle errors (e.g., invalid address)
                Get.snackbar(
                    'Error'.tr, '${'Error retrieving location:'.tr}$e');
              }
            },
            backgroundColor: Colors.yellow[200],
            child: Icon(Icons.location_on_rounded,size:7.5.sw,color:AppColors.primaryColor),
          ),
        ),
      ),
    );
  }

  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 3.sw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label.tr,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 3.sw),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 3.sw),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
