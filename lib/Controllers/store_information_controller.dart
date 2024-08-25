import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class StoreInformationController extends GetxController {
  final GetStorage storage = GetStorage();

  late final TextEditingController nationalIdController;
  late final TextEditingController taxNumberController;
  late final TextEditingController productTypeController;

  final RxBool isButtonEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();

    nationalIdController = TextEditingController(text: storage.read('nationalId') ?? '');
    taxNumberController = TextEditingController(text: storage.read('taxNumber') ?? '');
    productTypeController = TextEditingController(text: storage.read('productType') ?? '');

    nationalIdController.addListener(() => _saveToStorage('nationalId', nationalIdController.text));
    taxNumberController.addListener(() => _saveToStorage('taxNumber', taxNumberController.text));
    productTypeController.addListener(() => _saveToStorage('productType', productTypeController.text));



  }



  void _saveToStorage(String key, String value) {
    storage.write(key, value);
  }

  @override
  void onClose() {
    nationalIdController.dispose();
    taxNumberController.dispose();
    productTypeController.dispose();
    super.onClose();
  }
}
