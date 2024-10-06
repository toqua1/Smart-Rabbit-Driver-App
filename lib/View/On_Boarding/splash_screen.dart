import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rabbit_second_app/View/Home/home_nav_bar.dart';
import '../../Utilities/constants.dart';
import '../Login_SignUp/landing _login.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    _navigateToNextScreen(); // Call the navigation method
  }

  Future<void> _navigateToNextScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introSeen = prefs.getBool('introSeen') ?? false;
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    await Future.delayed(const Duration(seconds: 4));

    if (isLoggedIn) {
      Get.off(
        () => HomeNavBar(),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 500),
      );
    } else if (introSeen) {
      Get.off(
        () => LandingPage(),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 500),
      );
    } else {
      Get.off(
        () => const IntroductionScreenExample(),
        transition: Transition.rightToLeftWithFade,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double logoWidth = MediaQuery.of(context).size.width * 0.7;

    return Scaffold(
      backgroundColor: AppColors.primaryColor, // Hex color background
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Opacity(
              opacity: 0.5,
              child: Image.asset(
                'assets/Blur.png',
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
            FadeTransition(
              opacity: _animation,
              child: Image.asset(
                'assets/Logo.png',
                width: logoWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
