import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as prefix;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rabbit_second_app/View/Login_SignUp/login_screen.dart';
import '../Models/login_response.dart';
import '../Models/signup_model.dart';
import 'endpoints.dart';

class ApiData {
  final dio = Dio();
  final storage = GetStorage();
  late String authToken;

  ApiData() {

    _loadAuthToken();
  }

  Future<void> _loadAuthToken() async{
    // final prefs = await SharedPreferences.getInstance();
    // authToken =prefs.getString('token') ?? '';
    authToken=storage.read('token')?? '';
  }

  Future<void> saveUserData({
    required String token,
    required String name,
    required String email,
    required String phone,
    required String id,
    required String role
  }) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('name', name);
    prefs.setString('email', email);
    prefs.setString('phone', phone);
    prefs.setString('id', id);
    prefs.setString('role', role);
  }

  // Load data from SharedPreferences
  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString('token'),
      'name': prefs.getString('name'),
      'email': prefs.getString('email'),
      'phone': prefs.getString('phone'),
      'id': prefs.getString('id'),
      'role':prefs.getString('role')
    };
  }

  Future<void> signUpDriver(SignUp signUpData) async {
    try {
      final formData = FormData.fromMap({
        'name': signUpData.name,
        'email': signUpData.email,
        'phone': signUpData.phone,
        'password': signUpData.password,
        'nationalId': signUpData.nationalId,
        if (signUpData.nationalIdPhotoFace.isNotEmpty)
          'nationalIdPhotoFace':
              await MultipartFile.fromFile(signUpData.nationalIdPhotoFace),
        if (signUpData.nationalIdPhotoBack.isNotEmpty)
          'nationalIdPhotoBack':
              await MultipartFile.fromFile(signUpData.nationalIdPhotoBack),
        if (signUpData.driverLicensePhoto.isNotEmpty)
          'license':
              await MultipartFile.fromFile(signUpData.driverLicensePhoto),
        'address': signUpData.address,
        'role': signUpData.role,
      });

       

      final response = await dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.registerEndpoint}',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        final driverData = response.data['data']['driver'];
        // final token = response.data['token'];
        await saveUserData(
          token: '',
          name: driverData['name'],
          email: driverData['email'],
          phone: driverData['phone'],
          id: driverData['_id'],
          role: driverData['role'],
        );

        // final name = response.data['data']['driver']['name'];
        // final email = response.data['data']['driver']['email'];
        // final phone = response.data['data']['driver']['phone'];
        // final id = response.data['data']['driver']['_id'];
        // saveUserData(token: token, name: name, email: email, phone: phone, id: id);
      } else {
         
         
      }
    } catch (e) {
      if (e is DioException) {
         
      } else if (e is TypeError) {
         
      } else {
         
      }
    }
  }

  Future<bool> loginDriver(String phone, String password) async {
    try {
      final response = await dio.post(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.loginEndpoint}',
        data: {
          'phone': phone,
          'password': password,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final driverData = response.data['data']['driver'];
        final driver = Driver.fromJson(driverData);
        saveToken(driver.token);

        await saveUserData(
          token: driver.token,
          name: driver.name,
          email: driver.email,
          phone: driver.phone,
          id: driver.id,
          role: driver.role,
        );
         
        // final token = response.data['data']['driver']['token'];
        // final name = response.data['data']['driver']['name'];
        // final email = response.data['data']['driver']['email'];
        // final phone = response.data['data']['driver']['phone'];
        // final id = response.data['data']['driver']['_id'];
        //  
        //  
        //  
        //  
        //  

        // saveUserData(token: token, name: name, email: email, phone: phone, id: id);
        return true;
      } else {
        Get.snackbar('Error', 'Login failed: ${response.data['message']}');
         
        return false; // Login failed
      }
    } catch (e) {
      if (e is DioException) {
        Get.snackbar('Error', ' ${e.response?.data['message'] ?? e.message}',
            colorText: Color(0xffFF0000));
         

      } else {
         
        Get.snackbar('Error', 'An unexpected error occurred: $e');
      }
      return false; // Error occurred
    }
  }

  Future<Map<String, dynamic>?> getDriverWallet() async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getDriverWallet}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['data']['wallet'];
      } else {
         
        return null;
      }
    } on DioException catch (e) {
       
      return null;
    }
  }

  Future<Response?> getDriverOrders() async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getDriverOrders}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response;
      } else {
         
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
         
      } else {
         
      }
      return null;
    }
  }

  Future<Response?> getCompletedOrders() async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.getCompletedOrders}',
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        return response;
      } else {
         
        return null;
      }
    } on DioException catch (e) {
      if (e.response != null) {
         
      } else {
         
      }
      return null;
    }
  }

  // New method to update order status
  Future<Response?> updateOrderStatus(String orderId, Map<String , dynamic>requestBody) async {
    try {
      final response = await dio.patch(
        '${ApiEndpoints.baseUrl}${ApiEndpoints.updateOrderStatus}$orderId',
        data: requestBody,
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
         
        return response;
      } else {
         
      }
    } on DioException catch (e) {
      if (e.response != null) {
         
      } else {
         
      }
    } catch (e) {
       
    }
    return null;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(() => LoginPage(), transition: Transition.fadeIn);
  }

  void saveToken(String token) {
    storage.write('token', token);
    authToken = token;
  }

  String? getToken() {
    return storage.read('token');
  }


// Future<void> saveUserData({
  //   required String token,
  //   required String name,
  //   required String email,
  //   required String phone,
  //   required String id, // Added user ID
  // }) async {
  //   storage.write('token', token);
  //   storage.write('name', name);
  //   storage.write('email', email);
  //   storage.write('phone', phone);
  //   storage.write('_id', id); // Save user ID
  // }
  //

  //
  // void saveName(String name) {
  //   storage.write('name', name);
  // }
  //
  // void saveEmail(String email) {
  //   storage.write('email', email);
  // }
  //
  // void savePhone(String phone) {
  //   storage.write('phone', phone);
  // }
  //
  // void saveProfileImage(String image) {
  //   storage.write('profile', image);
  // }

  // Map<String, String?> getUserData() {
  //   return {
  //     'token': storage.read('token'),
  //     'name': storage.read('name'),
  //     'email': storage.read('email'),
  //     'phone': storage.read('phone'),
  //     '_id': storage.read('_id'), // Retrieve user ID
  //   };
  // }
  //

  // Future<String?> getName() async {
  //   return Future.value(storage.read('name'));
  // }
  //
  // String? getEmail() {
  //   return storage.read('email');
  // }
  //
  // Future<String?> getPhone() async {
  //   return Future.value(storage.read('phone'));
  // }
  //
  // Future<void> fetchAndSaveUserData(String userId) async {
  //   try {
  //     final response = await dio.get(
  //       '${ApiEndpoints.baseUrl}/customers/$userId',
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $authToken',
  //         },
  //       ),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final userProfile = UserProfile.fromJson(response.data);
  //
  //       saveName(userProfile.customer.name);
  //       saveEmail(userProfile.customer.email);
  //       savePhone(userProfile.customer.phone);
  //     } else {
  //        
  //     }
  //   } catch (e) {
  //      
  //   }
  // }
  //
  // Future<String?> fetchName(String userId) async {
  //   await fetchAndSaveUserData(userId);
  //   return getName();
  // }
  //
  // Future<String?> fetchEmail(String userId) async {
  //   await fetchAndSaveUserData(userId);
  //   return getEmail();
  // }
  //
  // Future<String?> fetchPhone(String userId) async {
  //   await fetchAndSaveUserData(userId);
  //   return getPhone();
  // }
}
