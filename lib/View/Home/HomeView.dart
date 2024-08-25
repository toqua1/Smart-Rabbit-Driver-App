import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class HomeContent extends StatelessWidget {
  HomeContent({super.key});

  final RxInt currentIndex = 0.obs;

  final List<Widget Function()> pageFactories = [
    // () => const HomeScreen(),
    // () => const MessagesScreen(),
    // () => FavoriteJobsScreen(),
    // () =>  ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    double iconSize = MediaQuery.of(context).size.width * 0.08;

    return Scaffold(
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: currentIndex.value,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Iconsax.home, size: iconSize),
                activeIcon: Icon(Iconsax.home_15, size: iconSize),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.message, size: iconSize),
                activeIcon: Icon(Iconsax.message5, size: iconSize),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.save_24, size: iconSize),
                activeIcon: Icon(Iconsax.save_minus, size: iconSize),
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.profile_circle, size: iconSize),
                activeIcon: Icon(Iconsax.profile_circle, size: iconSize),
                label: 'Profile',
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: const TextStyle(color: Colors.blue),
            unselectedLabelStyle: const TextStyle(color: Colors.grey),
            onTap: (index) {
              currentIndex.value = index;
            },
          )),
      body: Obx(() => pageFactories[currentIndex.value]()),
    );
  }
}
