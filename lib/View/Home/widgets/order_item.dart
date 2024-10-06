import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/Models/driver_order_model.dart';
import 'package:smart_rabbit_second_app/Utilities/app_styles.dart';
import 'package:smart_rabbit_second_app/Utilities/responsive_function.dart';
import '../../Widgets/order_item_button.dart';

class OrderItem extends StatelessWidget {
  final DriverOrder order;
  final double cardHeight;
  final int count;
  final bool isWallet;

  const OrderItem({
    super.key,
    required this.order,
    required this.cardHeight,
    required this.count,
    required this.isWallet,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDeliveredAt=order.orderDetails.deliveredAt != null ?
    DateFormat('yyyy-MM-dd').format(order.orderDetails.deliveredAt!):
    'No Dates Mentioned'.tr;
    String formattedTransferredDate=order.orderDetails.driverTransferredDate != null ?
    DateFormat('yyyy-MM-dd').format(order.orderDetails.driverTransferredDate!):
    'No Dates Mentioned'.tr;
    String formattedReceivedDate=order.orderDetails.driverRecievedDate != null ?
    DateFormat('yyyy-MM-dd').format(order.orderDetails.driverRecievedDate!):
    'No Dates Mentioned'.tr;
    String formattedFromWareHouseDate=order.orderDetails.recieveFromWareHouseDate !=
        null ?
    DateFormat('yyyy-MM-dd').format(order.orderDetails.recieveFromWareHouseDate!):
    'No Dates Mentioned'.tr;
    String formattedAssignedAt=DateFormat('yyyy-MM-dd').format(order.assignedAt);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: cardHeight,
        child: Center(
          child: ListTile(
            leading: SvgPicture.asset('assets/package.svg', height: 5.sh),
            title: Row(
              children: [
                Text('${'Order'.tr}  $count' , style: TextStyle(fontSize: 2.sh)),
                const SizedBox(width: 10,),
                Expanded(
                  child: Text(order.status=='Assigned'?'Assigned'.tr
                      :order.status=='Recieved'?'Received'.tr
                      :order.status=='Shipped'?'Shipped'.tr
                      :order.status=='Transfered'?'Transfered'.tr
                      :order.status=='Complete'?'Completed'.tr
                      :order.status=='Cancelled'?'Cancelled'.tr
                      :order.status=='Recieved From Warehouse'?'Received From '
                      'Warehouse'.tr
                  :'' ,
                      style: order.status=='Assigned'?Styles.style10RedColor
                      :order.status=='Recieved'?Styles.style10PrimaryColor
                      :order.status=='Recieved From Warehouse'?Styles.style10RedColor
                      :order.status=='Transfered'?Styles.style10PrimaryColor
                          :order.status=='Complete'?Styles.style10GreenColor
                          :order.status=='Cancelled'?Styles.style10RedColor
                      :null
                  ),
                ),
              ],
            ),
            subtitle: Text(
                order.status=='Assigned'?'${'Tracking Date'.tr}: $formattedAssignedAt'
                :order.status=='Recieved'?'${'Tracking Date'.tr}: '
                    '$formattedReceivedDate'
                :order.status=='Recieved From Warehouse'?'${'Tracking Date'.tr}: $formattedFromWareHouseDate'
                :order.status=='Transfered'?'${'Tracking Date'.tr}: '
                    '$formattedTransferredDate'
               :order.status=='Complete'?'${'Tracking Date'.tr}: $formattedDeliveredAt'
                :'' ,
                style: TextStyle(fontSize: responsiveSize(context, 3.sw, 2.5.sw))),
            trailing:isWallet?
            Text('+ ${'SAR'.tr} ${order.orderDetails.total}',
                style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 3.2.sw
                ),
            )
                :OrderItemButton( order: order),
          ),
        ),
      ),
    );
  }
}
