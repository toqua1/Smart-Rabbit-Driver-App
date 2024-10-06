import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smart_rabbit_second_app/View/Login_SignUp/login_screen.dart';
import '../../Controllers/create_account_controller.dart';
import '../Home/home_nav_bar.dart';
import '../Widgets/custom_button.dart';

class SetupDone extends StatelessWidget {
  // final RegistrationController controller = Get.find<RegistrationController>();

  const SetupDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: SizedBox.shrink(),
              ),
              SvgPicture.asset(
                'assets/done.svg',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                'Congratulations!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'You have to wait admin approve your account.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              CustomButton(
                onPressed: () {
                  Get.offAll(
                        () => LoginPage(),
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                text: 'Get Started',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
