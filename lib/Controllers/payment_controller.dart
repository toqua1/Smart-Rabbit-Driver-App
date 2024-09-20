import 'package:get/get.dart';

class PaymentController extends GetxController {
  var selectedPaymentMethod = 'All'.obs;

  void setSelectedPaymentMethod(String method) {
    selectedPaymentMethod.value = method;
  }
}
