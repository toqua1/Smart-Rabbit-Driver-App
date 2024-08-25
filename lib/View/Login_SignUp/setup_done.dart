import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/create_account_controller.dart';
import '../Home/HomeView.dart';
import '../Widgets/custom_button.dart';

class SetupDone extends StatelessWidget {
  final RegistrationController controller = Get.find<RegistrationController>();

  SetupDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
              Image.asset(
                'assets/setup_done.png',
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                'Your account has been set up!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We have customized feeds according to your preferences.',
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
                        () => HomeContent(),
                    transition: Transition.rightToLeftWithFade,
                    duration: const Duration(milliseconds: 500),
                  );
                },
                text: 'Get Started',
                isButtonEnabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
