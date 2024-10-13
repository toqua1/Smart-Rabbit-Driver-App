import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_rabbit_second_app/API/Api_helper.dart';
import 'package:smart_rabbit_second_app/Utilities/greeting_method.dart';
import 'package:smart_rabbit_second_app/Utilities/open_scanner.dart';
import 'package:smart_rabbit_second_app/View/Home/home_nav_bar.dart';
import '../../../Controllers/store_information_controller.dart';
import '../../../Utilities/app_styles.dart';
import '../../../Utilities/constants.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(8.sh);
}

class _HomeAppBarState extends State<HomeAppBar> {
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
    final con = Get.put(StoreInformationController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.sw),
      child: AppBar(
        toolbarHeight: 8.sh,
        backgroundColor: Colors.transparent,
        leading: Container(),
        // leading: Obx(()=>
        //   CircleAvatar(
        //     radius: 12.sw,
        //     backgroundImage: con.profilePhoto.value != null
        //         ? FileImage(con.profilePhoto.value!)
        //         : null,
        //     child: con.profilePhoto.value == null
        //         ? Icon(Icons.person, size: 4.sw)
        //         : null,
        //   ),
        // ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getGreetingMessage(),
                style: Styles.style12GreyColor.copyWith(fontSize: 1.5.sh)),
            SizedBox(height: 1.sh),
            Text(fullName,
                style: Styles.style20BoldBlack.copyWith(fontSize: 2.5.sh)),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              HomeNavBar().isDrawerOpen.value = true;
              Scaffold.of(context).openDrawer();
            },
            child: SvgPicture.asset('assets/menu.svg', width: 3.5.sh),
          )
        ],
      ),
    );
  }
}
