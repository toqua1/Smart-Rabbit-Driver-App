import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/Utilities/constants.dart';
import '../../../Controllers/driver_order_controller.dart';
//
// class OrderSummaryCard extends StatelessWidget {
//   final DriverOrdersController controller = Get.put(DriverOrdersController());
//   final double borderRadius;
//   final EdgeInsetsGeometry padding;
//   final double widthFactor;
//   final int receiveCount;
//   final int sentCount;
//
//   OrderSummaryCard({
//     super.key,
//     required this.borderRadius,
//     required this.padding,
//     required this.receiveCount,
//     required this.sentCount,
//     this.widthFactor = 1.0,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Container(
//       padding: padding,
//       width: MediaQuery.of(context).size.width * widthFactor,
//       decoration: BoxDecoration(
//         color: AppColors.primaryColor,
//         borderRadius: BorderRadius.circular(borderRadius),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Column(
//             children: [
//               SvgPicture.asset('assets/box.svg',width: 4.sh,),
//               SizedBox(height: 1.5.sh),
//               Text(
//                 'Successfully sent'.tr,
//                 style: TextStyle(color: Colors.white, fontSize: 2.sh),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 '${controller.sentCount.value}'.tr,
//                 style: TextStyle(color: Colors.white, fontSize: 3.sh),
//               ),
//             ],
//           ),
//           Column(
//             children: [
//               SvgPicture.asset('assets/box2.svg',width: 6.sh,),
//               SizedBox(height: 1.5.sh),
//               Text(
//                 'Successfully received'.tr,
//                 style: TextStyle(color: Colors.white, fontSize: 2.sh),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 '${controller.receivedCount.value}'.tr,
//                 style: TextStyle(color: Colors.white, fontSize: 3.sh),
//               ),
//             ],
//           ),
//         ],
//       ),
//     ));
//   }
// }
class OrderSummaryCard extends StatelessWidget {
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double widthFactor;
  final int receiveCount;
  final int sentCount;

  OrderSummaryCard({
    super.key,
    required this.borderRadius,
    required this.padding,
    required this.receiveCount,
    required this.sentCount,
    this.widthFactor = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: MediaQuery.of(context).size.width * widthFactor,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              SvgPicture.asset('assets/box.svg', width: 4.sh),
              SizedBox(height: 1.5.sh),
              Text(
                'Successfully sent'.tr,
                style: TextStyle(color: Colors.white, fontSize: 2.sh),
              ),
              const SizedBox(height: 8),
              Text(
                '$sentCount',
                style: TextStyle(color: Colors.white, fontSize: 3.sh),
              ),
            ],
          ),
          Column(
            children: [
              SvgPicture.asset('assets/box2.svg', width: 6.sh),
              SizedBox(height: 1.5.sh),
              Text(
                'Successfully received'.tr,
                style: TextStyle(color: Colors.white, fontSize: 2.sh),
              ),
              const SizedBox(height: 8),
              Text(
                '$receiveCount',
                style: TextStyle(color: Colors.white, fontSize: 3.sh),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
