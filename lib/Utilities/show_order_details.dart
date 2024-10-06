// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import '../Controllers/update_order_status_controller.dart';
// import '../Models/driver_order_model.dart';
// import '../View/Widgets/constants.dart';
//
// void showOrderDetailsDialog(BuildContext context, DriverOrder order) {
//   String name = '';
//   String address = '';
//   String phoneNumber = '';
//   final OrderStatusController orderStatusController = Get.put(OrderStatusController());
//
//   // Check the shipped type
//   if (order.shippedType == 'Pickup') {
//     name = 'Store'.tr;
//     address = order.orderDetails.pickupAddress;
//     phoneNumber = order.orderDetails.storePhoneNumber;
//   } else if (order.shippedType == 'Delivery') {
//     name = ' ${order.orderDetails.receiverName}';
//     address = order.orderDetails.receiverAddress;
//     phoneNumber = order.orderDetails.receiverPhoneNumber;
//   }
//
//   // Show the dialog with order details
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         shape:
//         RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Text('Order Details'.tr),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildDetailRow('Name'.tr, name),
//             buildDetailRow('Phone Number'.tr, phoneNumber),
//             buildDetailRow('Address'.tr, address),
//             Divider(),
//             buildDetailRow(
//                 'Total'.tr, 'SAR ${order.orderDetails.total.toStringAsFixed(2)
//             }'),
//             buildDetailRow(
//                 'Payment Method'.tr, order.orderDetails.paymentMethod),
//             buildDetailRow('Transaction & Track ID'.tr, order.orderDetails.id),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: orderStatusController.isLoadingMap[order.id] == true
//                 ? null
//                 : () async {
//               if (order.status=='Assigned') {
//                 await orderStatusController.updateOrderStatus(
//                     order.orderDetails.id, 'Recieved',order.shippedType);
//               } else if (order.status=='Recieved') {
//                 await orderStatusController.updateOrderStatus(
//                     order.orderDetails.id, 'Shipped',order.shippedType);
//               } else if (order.status=='Shipped') {
//                 await orderStatusController.updateOrderStatus(
//                     order.orderDetails.id, 'Transfered',order.shippedType);
//               }else if (order.status=='Transfered') {
//                 await orderStatusController.updateOrderStatus(
//                     order.orderDetails.id, 'Complete',order.shippedType);
//               }
//               Navigator.of(context).pop();
//             },
//             child: Text(
//               order.status=='Assigned'?'Received Done'.tr
//                   :order.status=='Recieved'?'Shipped Done'.tr
//                   :order.status=='Shipped'?'Transferred Done'.tr
//                   :order.status=='Transfered'?'Completed Done'.tr
//                   :''
//
//               ,style: TextStyle(
//                 fontWeight: FontWeight.w800 ,fontSize: 4.sw,color: AppColors
//                 .primaryColor
//             ),),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Close'.tr,style: TextStyle(
//               fontSize: 4.sw,
//             ),),
//           ),
//         ],
//       );
//     },
//   );
// }
//
// Widget buildDetailRow(String label, String value) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label.tr,
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         Flexible(
//           child: Text(
//             value,
//             style: TextStyle(fontSize: 14),
//             textAlign: TextAlign.right,
//           ),
//         ),
//       ],
//     ),
//   );
// }