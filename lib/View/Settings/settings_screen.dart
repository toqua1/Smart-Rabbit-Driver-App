import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_rabbit_second_app/API/Api_helper.dart';
import 'package:smart_rabbit_second_app/Utilities/app_styles.dart';
import 'package:smart_rabbit_second_app/Utilities/localization.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ApiData api = ApiData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.tr),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              _changeLanguage();
            },
            leading: const Icon(
              Icons.language,
              color: Colors.black54,
            ),
            title: Text(
              'Change Language'.tr,
              style: Styles.style14BlackBold,
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ),
          // ListTile(
          //   onTap: () {
          //     Get.to(() => ChangePasswordScreen());
          //   },
          //   leading: SvgPicture.asset(
          //     'assets/Password.svg',
          //     width: MediaQuery.of(context).size.width * .06,
          //   ),
          //   title: Text(
          //     'Change Password'.tr,
          //     style: Styles.style14BlackBold,
          //   ),
          //   trailing: const Icon(
          //     Icons.arrow_forward_ios,
          //     size: 16,
          //   ),
          // ),

          ListTile(
            onTap: () {
              api.logout();
            },
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text(
              'Logout'.tr,
              style: Styles.style14BlackBold.copyWith(color: Colors.red),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          )
        ],
      ),
    );
  }

  void _changeLanguage() {
    final localizationService = LocalizationService();
    String currentLang = Get.locale?.languageCode ?? 'en';
    String newLang = currentLang == 'en' ? 'ar' : 'en';
    localizationService.changeLocale(newLang); // Change language
  }
}
