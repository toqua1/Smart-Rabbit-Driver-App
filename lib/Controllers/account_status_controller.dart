import 'package:get/get.dart';

class AccountStatusController extends GetxController {
  final RxString selectedOption = ''.obs;

  void updateOption(String option) {
    selectedOption.value = option;
  }

}
