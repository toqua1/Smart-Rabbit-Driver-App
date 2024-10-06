// import 'package:dio/dio.dart' as dio;
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../API/endpoints.dart';
// import 'package:mime/mime.dart';
//
// import '../Models/signup_model.dart';
// import '../View/Widgets/upload_image.dart';
//
// // Function to get MIME type of a file
// String? getMimeType(String filePath) {
//   return lookupMimeType(filePath);
// }
//
// class RegistrationController extends GetxController {
//   final GetStorage storage = GetStorage();
//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//   final ImageUploadContainer idFrontImageUploadContainer =
//   ImageUploadContainer();
//   final ImageUploadContainer idBackImageUploadContainer =
//   ImageUploadContainer();
//   final ImageUploadContainer taxImageUploadContainer =
//   ImageUploadContainer();
//
//   String token = '';
//   String username = '';
//   String email = '';
//   String phone = '';
//   String id = '';
//
//   // Add an RxBool to track loading state
//   var isLoading = false.obs;
//
//   Future<SignUp> registerUser() async {
//     try {
//       isLoading.value = true; // Set loading state to true when starting
//
//       String name = storage.read('username') ?? '';
//       String email = storage.read('email') ?? '';
//       String password = storage.read('password') ?? '';
//       String confirmPassword = storage.read('confirmPassword') ?? '';
//       String phone = storage.read('phone_number') ?? '';
//       String nationalId = storage.read('nationalId') ?? '';
//       String taxNumber = storage.read('taxNumber') ?? '';
//       String productType = storage.read('productType') ?? '';
//
//       // Print values for debugging
//        
//        
//        
//        
//        
//        
//        
//        
//
//       // Retrieve file paths from GetStorage
//       final idFrontImage =
//       idFrontImageUploadContainer.retrieveStoredFileData('IDFrontImage');
//       final idBackImage =
//       idBackImageUploadContainer.retrieveStoredFileData('IDBackImage');
//       final taxImage =
//       taxImageUploadContainer.retrieveStoredFileData('TaxImage');
//       final commercialRegisterImage = taxImageUploadContainer
//           .retrieveStoredFileData('CommercialRegisterImage');
//
//        
//        
//        
//
//       final formData = dio.FormData.fromMap(<String, dynamic>{
//         'name': name,
//         'email': email,
//         'password': password,
//         'passwordConfirm': confirmPassword,
//         'phone': phone,
//         'nationalId': nationalId,
//         'taxNumber': taxNumber,
//         'nationalIdPhotoFace': await dio.MultipartFile.fromFile(
//             idFrontImage['filePath']!,
//             filename: idFrontImage['fileName']),
//         'nationalIdPhotoBack': await dio.MultipartFile.fromFile(
//             idBackImage['filePath']!,
//             filename: idBackImage['fileName']),
//         'taxNumberPhoto': await dio.MultipartFile.fromFile(
//             taxImage['filePath']!,
//             filename: taxImage['fileName']),
//         'commercialRegister': await dio.MultipartFile.fromFile(
//             commercialRegisterImage['filePath']!,
//             filename: commercialRegisterImage['fileName']),
//         'productType': productType,
//       });
//
//       final response = await dio.Dio().post(
//         '${ApiEndpoints.baseUrl}${ApiEndpoints.registerEndpoint}',
//         data: formData,
//         options: dio.Options(
//           headers: {
//             'Content-Type': 'multipart/form-data',
//           },
//         ),
//       );
//
//        
//
//       SignUp signUp = SignUp.fromJson(response.data);
//
//       return signUp;
//     } catch (e) {
//       if (e is dio.DioException) {
//          
//          
//          
//       } else {
//          
//       }
//       rethrow;
//     } finally {
//       isLoading.value = false; // Set loading state to false when finished
//     }
//   }
// }
