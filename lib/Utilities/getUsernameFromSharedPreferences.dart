import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';

Future<String?> getUsernameFromSharedPreferences() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? retrievedUsername = prefs.getString('user_name');
  String? retrievedToken = prefs.getString('user_token');
  GetStorage().write('user_token', retrievedToken);
  return retrievedUsername;
}
