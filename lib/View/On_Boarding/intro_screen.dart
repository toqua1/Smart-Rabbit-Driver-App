import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart'; // Add this import for Lottie
import '../Login_SignUp/landing _login.dart';
import '../Login_SignUp/login_screen.dart';

class IntroductionScreenExample extends StatefulWidget {
  const IntroductionScreenExample({Key? key}) : super(key: key);

  @override
  _IntroductionScreenExampleState createState() =>
      _IntroductionScreenExampleState();
}

class _IntroductionScreenExampleState extends State<IntroductionScreenExample> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    checkIntroSeenStatus();
  }

  Future<void> checkIntroSeenStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool introSeen = prefs.getBool('introSeen') ?? false;

    if (introSeen) {
      Get.off(LoginPage(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 500));
    }
  }

  Future<void> markIntroAsSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('introSeen', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Static content
            _buildStaticContent(context),
            // Dynamic content
            Flexible(
              fit: FlexFit.loose,
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  _buildPage(
                    "Explore over 25,924 available job roles and upgrade your operator now.",
                    "Find a job, and ",
                    "start Building ",
                    "your career from now on",
                  ),
                  _buildPage(
                    "Immediately join us and start applying for the job you are interested in.",
                    "Hundreds of jobs are ",
                    "waiting for you ",
                    "to join together",
                  ),
                  _buildPage(
                    "Explore over 25,924 available job roles and upgrade your operator now.",
                    "Find a job, and",
                    "start Building",
                    "your career from now on",
                  ),
                ],
              ),
            ),
            _buildCustomIndicator(),
            _buildCustomButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticContent(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            TextButton(
              onPressed: () {
                markIntroAsSeen();
                Get.off(
                  () => LandingPage(),
                  transition: Transition.rightToLeftWithFade,
                  // Add the transition here
                  duration:
                      const Duration(milliseconds: 500), // Specify the duration
                );
              },
              child: const Text(
                "Skip",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Lottie.asset('assets/biker.json',
              fit: BoxFit.fitWidth), // Use Lottie asset
        ),
      ],
    );
  }

  Widget _buildPage(String body, String title2, String title3, String title4) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: title2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.07),
                          ),
                          TextSpan(
                            text: title3,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.07,
                            ),
                          ),
                          TextSpan(
                            text: title4,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.07),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(body,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.05)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.all(8),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.indigoAccent],
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        onPressed: () {
          if (_currentPage == 2) {
            markIntroAsSeen();
            Get.off(LandingPage(),
                transition: Transition.rightToLeftWithFade,
                duration: const Duration(milliseconds: 500));
          } else {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        },
        child: Text(
          _currentPage == 2 ? "Start App" : "Next",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
