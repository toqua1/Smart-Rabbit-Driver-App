import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rabbit_second_app/API/Api_helper.dart';
import 'package:smart_rabbit_second_app/Controllers/store_information_controller.dart';
import 'package:smart_rabbit_second_app/Utilities/constants.dart';
import 'package:smart_rabbit_second_app/Utilities/responsive_function.dart';
import 'package:smart_rabbit_second_app/View/History_orders/order_history.dart';
import 'package:smart_rabbit_second_app/View/Settings/settings_screen.dart';
import 'package:smart_rabbit_second_app/View/profile/profile_screen.dart';
import '../../../Utilities/localization.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final ApiData api = ApiData();
  int? selectedIndex = null; // Track the selected drawer item

  final List<Map<String, String>> drawerItems = [
    {'img': 'assets/Account.svg', 'label': 'Account'.tr},
    {'img': 'assets/Notification.svg', 'label': 'Notification'.tr},
    {'img': 'assets/order history.svg', 'label': 'Order History'.tr},
    {'img': 'assets/Reward.svg', 'label': 'Incentives'.tr},
    {'img': 'assets/Performance.svg', 'label': 'Performance'.tr},
    {'img': 'assets/Protection.svg', 'label': 'Safety'.tr},
    {'img': 'assets/Comments.svg', 'label': 'Comments'.tr},
    {'img': 'assets/Policy.svg', 'label': 'Privacy Policy'.tr},
    {'img': 'assets/Settings.svg', 'label': 'Settings'.tr},
    // {'img': 'assets/Settings.svg', 'label': 'Logout'.tr},
  ];

  String fullName = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('name') ?? 'Guest';
      email = prefs.getString('email') ?? 'No email found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: responsiveSize(context, 80.sw, 60.sw),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.sw, vertical: 8.sh),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDrawerHeader(context),
              SizedBox(height: 3.sh),
              ...List.generate(drawerItems.length, (index) {
                return _buildDrawerItem(
                  context,
                  img: drawerItems[index]['img']!,
                  label: drawerItems[index]['label']!,
                  index: index,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    final con = Get.put(StoreInformationController());
    return Row(
      children: [
        // Obx(
        //   () => CircleAvatar(
        //     backgroundColor: AppColors.primaryColor.withOpacity(0.2),
        //     backgroundImage: con.profilePhoto.value != null
        //         ? FileImage(con.profilePhoto.value!)
        //         : null,
        //     child: con.profilePhoto.value == null
        //         ? Icon(Icons.person, size: 4.sw)
        //         : null,
        //   ),
        // ),
        SizedBox(width: 2.sw),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              style: TextStyle(fontSize: 2.5.sh, color: Colors.black),
            ),
            Text(
              email,
              style: TextStyle(fontSize: 1.5.sh, color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDrawerItem(BuildContext context,
      {required String img, required String label, required int? index}) {
    final isSelected = selectedIndex == index;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.sh),
      child: AnimatedContainer(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: ListTile(
          leading: index == 9
              ? const Icon(
                  Icons.logout,
                  color: Colors.black54,
                )
              : SvgPicture.asset(
                  img,
                  width: responsiveSize(context, 6.sw, 4.sw),
                  color: isSelected ? Colors.white : null,
                ),
          title: Text(
            label.tr,
            style: TextStyle(
              fontSize: responsiveSize(context, 4.sw, 3.sw),
              color: index == 9
                  ? Colors.red
                  : isSelected
                      ? Colors.white
                      : null,
              fontWeight: index == 9 ? FontWeight.bold : null,
            ),
          ),
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
            switch (index) {
              case 0: // Account
                Get.back();

                Get.to(() => ProfileScreen());
                break;

              case 2: // Change Language
                Get.back();
                Get.to(() => OrderHistoryScreen());
                break;
              case 8: // Logout
                Get.back();

                Get.to(SettingsScreen());

                break;
              case 9: // Logout
                api.logout();
                break;
              default:
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.info,
                  text: 'Sorry this service is not available'.tr,
                  autoCloseDuration: const Duration(seconds: 2),
                  showConfirmBtn: false,
                );
            }
            // if (label == 'Logout') {
            //   api.logout();
            // }
            // else if (label == 'Change Language') {
            //   _changeLanguage();
            // }else if(label == 'Account'){
            //   Get.back();
            // }else{
            //   QuickAlert.show(
            //     context: context,
            //     type: QuickAlertType.info,
            //     text: 'Sorry this service is not available'.tr,
            //     autoCloseDuration: const Duration(seconds: 2),
            //     showConfirmBtn: false,
            //   );
            // }
          },
        ),
      ),
    );
  }
}
