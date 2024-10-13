// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:iconsax/iconsax.dart';
// import '../../Controllers/store_information_controller.dart';
// import '../../Utilities/constants.dart';

// class ProfileImage extends StatelessWidget {
//   const ProfileImage({
//     super.key,
//     required this.controller,
//   });

//   final StoreInformationController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Obx(()=>CircleAvatar(
//             radius: 70,
//             backgroundColor: Colors.grey.shade300,
//             backgroundImage: controller.profilePhoto.value != null
//                 ? FileImage(controller.profilePhoto.value!)
//                 : null,
//             child: controller.profilePhoto.value == null
//                 ?Icon(Icons.person, size: 50, color: Colors.white)
//                 :null,
//           ),
//         ),
//         Positioned(
//           right:0,
//           top: 0,
//           child: InkWell(
//               onTap: () {
//                 controller.addProfilePhoto();
//               },
//               child: CircleAvatar(
//                   radius: 18,
//                   backgroundColor:AppColors.primaryColor ,
//                   child: Icon(Iconsax.edit4, size: 20, color:
//                   Colors.white))),
//         ),
//       ],
//     );
//   }
// }

