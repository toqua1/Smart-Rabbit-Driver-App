import 'package:get/get.dart';

String getGreetingMessage() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return 'Good Morning'.tr;
  } else if (hour >= 12 && hour < 17) {
    return 'Good Afternoon'.tr;
  } else if (hour >= 17 && hour < 20) {
    return 'Good Evening'.tr;
  } else {
    return 'Good Night'.tr;
  }
}
