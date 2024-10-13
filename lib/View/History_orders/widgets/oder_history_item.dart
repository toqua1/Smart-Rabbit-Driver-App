import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smart_rabbit_second_app/Models/driver_order_model.dart';
import 'package:smart_rabbit_second_app/Utilities/app_styles.dart';
import 'package:smart_rabbit_second_app/Utilities/responsive_function.dart';

class OrderHistoryItem extends StatelessWidget {
  final DriverOrder order;
  final double cardHeight;
  final int count;
  final bool isWallet;

  const OrderHistoryItem({
    super.key,
    required this.order,
    required this.cardHeight,
    required this.count,
    required this.isWallet,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: cardHeight,
        child: Center(
          child: ListTile(
            leading: SvgPicture.asset('assets/package.svg', height: 5.sh),
            title: Row(
              children: [
                Text(order.orderDetails.receiverName,
                    style: Styles.styleBold24Primary),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            subtitle: Text(
                'Tracking Id : ${order.orderDetails.orderNumber}' //TODO:localization

                ,
                style:
                    TextStyle(fontSize: responsiveSize(context, 3.sw, 2.5.sw))),
            trailing: Text('+ \$${order.orderDetails.orderPrice}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff00EE0A),
                )),
          ),
        ),
      ),
    );
  }
}
