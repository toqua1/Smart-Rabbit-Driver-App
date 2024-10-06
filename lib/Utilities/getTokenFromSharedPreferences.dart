import 'package:get_storage/get_storage.dart';
Future<String?> getTokenFromSharedPreferences() async {
  String? retrievedToken = GetStorage().read('user_token');
   
  return retrievedToken;
}