import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WalletTransactionCard extends StatelessWidget {
  final String title;
  final String trackingId;
  final String amount;

  const WalletTransactionCard({super.key,
    required this.title,
    required this.trackingId,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.sw),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin:EdgeInsets.symmetric(vertical: 1.3.sh),
        child: ListTile(
          leading: SvgPicture.asset('assets/package.svg',height: 5.sh),
          title: Text(title, style: TextStyle(fontSize: 2.sh)),
          subtitle: Text('${'Tracking ID'.tr}:$trackingId', style: TextStyle
            (fontSize: 1.8.sh)),
          trailing: Text(amount,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 1.8.sh
            ),
          ),
        ),
      ),
    );
  }
}
