import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rabbit_second_app/API/Api_helper.dart';
import 'package:smart_rabbit_second_app/Controllers/email_controller.dart';

class StoreInformationController extends GetxController {
  final GetStorage storage = GetStorage();
  ApiData api=ApiData();
  final EmailController controller =Get.put(EmailController());
  late final TextEditingController fullNameController;
  late final TextEditingController addressController;
  late final TextEditingController nationalIdController;

  final RxBool isButtonEnabled = true.obs;
  final Rx<File?> profilePhoto = Rx<File?>(null);
  final Rx<File?> nationalIdImageFace = Rx<File?>(null);
  final Rx<File?> nationalIdImageBack = Rx<File?>(null);
  final Rx<File?> drivingLicenseImage = Rx<File?>(null);


  @override
  void onInit() {
    fullNameController = TextEditingController(text: storage.read('name') ?? '');
    addressController = TextEditingController(text: storage.read('address') ?? '');
    nationalIdController = TextEditingController(text: storage.read('nationalId') ?? '');

    fullNameController.addListener(() => _saveToStorage('name', fullNameController.text));
    addressController.addListener(() => _saveToStorage('address', addressController.text));
    nationalIdController.addListener(() => _saveToStorage('nationalId', nationalIdController.text));
    _loadUserPhoto();
    super.onInit();
  }

  void _saveToStorage(String key, String value) {
    storage.write(key, value);
  }

  void refreshUserData() {
    fullNameController.text = storage.read('name') ?? '';
    // fullName.value = fullNameController.text;
    controller.emailController.text=storage.read('email') ??'';
    _loadUserPhoto();
    update();
  }

  void _loadUserPhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? profilePhotoPath = prefs.getString('profilePhotoPath');
    if (profilePhotoPath != null) {
      profilePhoto.value = File(profilePhotoPath);
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    addressController.dispose();
    nationalIdController.dispose();
    super.onClose();
  }

  // // Method to add profile photo and save to GetStorage
  // Future<void> addProfilePhoto() async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     profilePhoto.value = File(pickedFile.path);
  //     // Optionally, you can also save the photo to local storage
  //     storage.write('profilePhotoPath', pickedFile.path);
  //   }
  // }

  // Method to add profile photo and save to SharedPreferences
  Future<void> addProfilePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profilePhoto.value = File(pickedFile.path);
      // Save the photo path to SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('profilePhotoPath', pickedFile.path);
    }
  }

  Future<void> selectNationalIdImageFace() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      nationalIdImageFace.value = File(pickedFile.path);
      storage.write('nationalIdImageFacePath', pickedFile.path);
    }
  }

  Future<void> selectNationalIdImageBack() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      nationalIdImageBack.value = File(pickedFile.path);
      storage.write('nationalIdImageBackPath', pickedFile.path);
    }
  }

  Future<void> selectDrivingLicenseImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      drivingLicenseImage.value = File(pickedFile.path);
      storage.write('drivingLicenseImagePath', pickedFile.path);
    }
  }

}
