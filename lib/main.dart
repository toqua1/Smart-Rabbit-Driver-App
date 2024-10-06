import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rabbit_second_app/View/On_Boarding/splash_screen.dart';
import 'Controllers/change_password_controller.dart';
import 'Controllers/create_password_controller.dart';
import 'Controllers/email_controller.dart';
import 'Controllers/forgot_password_controller.dart';
import 'Controllers/otp_controller.dart';
import 'Controllers/phone_controller.dart';
import 'Controllers/store_information_controller.dart';
import 'Utilities/constants.dart';
import 'Utilities/localization.dart';
import 'package:device_preview/device_preview.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => SharedPreferences.getInstance());
  await GetStorage.init();
  LocalizationService localizationService = LocalizationService();

  await localizationService.loadSavedLanguage(); // Load saved language
  runApp(
      DevicePreview(
        enabled: false,
        builder: (context) =>
       const MyApp()
    ,)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Dynamic font size based on screen height
    double dynamicFontSize = screenHeight * 0.028; // Adjust as needed
    // Dynamic borderRadius based on screen width
    double dynamicBorderRadius = screenWidth * 0.06; // Adjust as needed

    Get.put<PhoneController>(PhoneController());
    Get.put<EmailController>(EmailController());
    Get.put<CreatePasswordController>(CreatePasswordController());
    Get.put<StoreInformationController>(StoreInformationController());
    Get.put<ForgotPasswordController>(ForgotPasswordController());
    Get.put<OtpController>(OtpController());
    Get.put<ChangePasswordController>(ChangePasswordController());
    // Get.put<EditProfileController>(EditProfileController());

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final bool isArabic = Get.locale?.languageCode == 'ar';

    return ResponsiveApp(
    builder: (context) => GetMaterialApp(
        translations: LocalizationService(),
        locale: Get.deviceLocale,
        // Get.locale,
        /*device local => based on device lang.*/
        fallbackLocale: LocalizationService.fallbackLocale,
        debugShowCheckedModeBanner: false,
        title: 'Delivery App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
          useMaterial3: true,
          primaryColor: const Color(0xff0A3B9A),
          fontFamily:isArabic? GoogleFonts.cairo().fontFamily:GoogleFonts
              .montserrat().fontFamily,

          appBarTheme: AppBarTheme(
            toolbarHeight: screenHeight / 9, // Keeping toolbar height dynamic
            backgroundColor: AppColors.primaryColor,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: dynamicFontSize, // Dynamic font size
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(dynamicBorderRadius), // Dynamic borderRadius
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        useInheritedMediaQuery: true,// Set to true
        // locale: DevicePreview.locale(context), // Add the locale here
        home:const SplashScreen(),
      ),
    );
  }
}
