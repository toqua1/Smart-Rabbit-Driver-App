
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smart_rabbit_second_app/Controllers/create_password_controller.dart';
import '../API/Api_helper.dart';
import '../Controllers/account_status_controller.dart';
import '../Controllers/address_controller.dart';
import '../Controllers/email_controller.dart';
import '../Controllers/phone_controller.dart';
import '../Controllers/store_information_controller.dart';
import '../Models/signup_model.dart';

Future<void> submitSignUp() async {
   final StoreInformationController storeController = Get.put(StoreInformationController());
  final PhoneController phoneController = Get.put(PhoneController());
  final EmailController emailController = Get.put(EmailController());
  final AddressController addressController = Get.put(AddressController());
  final AccountStatusController accountStatusController = Get.put(AccountStatusController());
   final CreatePasswordController passCon=Get.put(CreatePasswordController());
   String role = accountStatusController.selectedOption.value == 'Pick up & Drop '
       'off'?'Pickup/Delivery': accountStatusController.selectedOption
       .value=='Pick up'?'Pickup':'Delivery';

  // Creating a SignUp object with the collected data
  final signUpData = SignUp(
    name: storeController.fullNameController.text,
    email: emailController.emailController.text,
    phone: phoneController.phone,
    password: passCon.passwordController.text,
    nationalId: storeController.nationalIdController.text,
    nationalIdPhotoFace: storeController.nationalIdImageFace.value!.path,
    nationalIdPhotoBack: storeController.nationalIdImageBack.value!.path,
    driverLicensePhoto: storeController.drivingLicenseImage.value!.path,
    address: addressController.selectedRegion.value!.nameEn ,
    role: role,
  );

  // Send the data to the API
  final apiData = ApiData();
 await apiData.signUpDriver(signUpData);
}
