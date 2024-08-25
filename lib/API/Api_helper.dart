import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../Models/get_profile_model.dart';
import '../Utilities/savedToken.dart';
import 'endpoints.dart';

class ApiData {
  final dio = Dio();
  final storage = GetStorage();
  late String authToken;

  ApiData() {
    _loadAuthToken();
  }

  void _loadAuthToken() {
    authToken = storage.read('token') ?? '';
  }

  Future<void> saveUserData({
    required String token,
    required String name,
    required String email,
    required String phone,
    required String id, // Added user ID
  }) async {
    storage.write('token', token);
    storage.write('name', name);
    storage.write('email', email);
    storage.write('phone', phone);
    storage.write('_id', id); // Save user ID
  }

  void saveToken(String token) {
    storage.write('token', token);
    authToken = token;
  }

  void saveName(String name) {
    storage.write('name', name);
  }

  void saveEmail(String email) {
    storage.write('email', email);
  }

  void savePhone(String phone) {
    storage.write('phone', phone);
  }

  Map<String, String?> getUserData() {
    return {
      'token': storage.read('token'),
      'name': storage.read('name'),
      'email': storage.read('email'),
      'phone': storage.read('phone'),
      '_id': storage.read('_id'), // Retrieve user ID
    };
  }

  String? getToken() {
    return storage.read('token');
  }

  Future<String?> getName() async {
    return Future.value(storage.read('name'));
  }

  String? getEmail() {
    return storage.read('email');
  }

  Future<String?> getPhone() async {
    return Future.value(storage.read('phone'));
  }

  Future<void> fetchAndSaveUserData(String userId) async {
    try {
      final response = await dio.get(
        '${ApiEndpoints.baseUrl}/customers/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $authToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final userProfile = UserProfile.fromJson(response.data);

        saveName(userProfile.customer.name);
        saveEmail(userProfile.customer.email);
        savePhone(userProfile.customer.phone);
      } else {
        print('Failed to load user data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching user data: $e');
    }
  }

  Future<String?> fetchName(String userId) async {
    await fetchAndSaveUserData(userId);
    return getName();
  }

  Future<String?> fetchEmail(String userId) async {
    await fetchAndSaveUserData(userId);
    return getEmail();
  }

  Future<String?> fetchPhone(String userId) async {
    await fetchAndSaveUserData(userId);
    return getPhone();
  }
}
