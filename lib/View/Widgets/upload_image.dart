// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:smart_rabbit_second_app/Controllers/store_information_controller.dart';
//
// import 'image_tile.dart';
//
// class ImageUploadContainer extends StatelessWidget {
//   final StoreInformationController controller=Get.put(StoreInformationController());
//   final String? storageKey;
//   final String? initialFileName;
//   final String? initialFilePath;
//
//   ImageUploadContainer({
//     super.key,
//     this.storageKey,
//     this.initialFileName,
//     this.initialFilePath,
//   }) {
//     if (initialFileName != null && controller.fileName.value.isEmpty) {
//       controller.fileName.value = initialFileName!;
//     }
//     if (initialFilePath != null && controller.filePath.value.isEmpty) {
//      controller.filePath.value = initialFilePath!;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Obx(() => controller.fileName.value.isEmpty
//           ? DottedBorder(
//         dashPattern: const [8, 6],
//         color: Colors.blue,
//         borderType: BorderType.RRect,
//         strokeWidth: 2,
//         radius: const Radius.circular(12),
//         child: Container(
//           height: MediaQuery.of(context).size.height * 0.25,
//           color: Colors.blue.withOpacity(0.15),
//           width: double.infinity,
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Icon(
//                 Iconsax.document_upload5,
//                 size: 40,
//                 color: Colors.blue,
//               ),
//               const SizedBox(height: 10),
//               const Text("Upload Image", style: TextStyle(fontSize: 20)),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(
//                   width: double.infinity,
//                   child: OutlinedButton.icon(
//                     style: OutlinedButton.styleFrom(
//                       backgroundColor: Colors.blue.withOpacity(0.16),
//                       side: const BorderSide(color: Colors.blueAccent),
//                     ),
//                     onPressed: () => pickAndUploadImage(context),
//                     icon: const Icon(Iconsax.arrow_up, color: Colors.blue),
//                     label: const Text(
//                       "Choose Image",
//                       style: TextStyle(color: Colors.blue),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       )
//           : ImageTile(
//         fileName: controller.fileName.value,
//         filePath: controller.filePath.value,
//         onCancel: () {
//           controller.fileName.value = '';
//           controller.filePath.value = '';
//           saveFile('', '');
//         },
//         onEdit: () => pickAndUploadImage(context),
//       )),
//     );
//   }
//
//   Future<void> pickAndUploadImage(BuildContext context) async {
//     final ImagePicker picker = ImagePicker();
//     try {
//       final XFile? pickedFile = await picker.pickImage(
//         source: ImageSource.gallery,
//       );
//
//       if (pickedFile != null) {
//         controller.fileName.value = pickedFile.name;
//         controller.filePath.value = pickedFile.path;
//         saveFile(pickedFile.name, pickedFile.path);
//       } else {
//          
//       }
//     } catch (error) {
//        
//     }
//   }
//
//   void saveFile(String fileName, String filePath) {
//     if (storageKey != null) {
//       GetStorage().write('${storageKey!}_name', fileName);
//       GetStorage().write('${storageKey!}_path', filePath);
//
//        
//        
//        
//        
//     } else {
//        
//     }
//   }
//
// }
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

import 'image_tile.dart';

class ImageUploadContainer extends StatelessWidget {
  final Rx<File?> imageFile;
  final Function() onImageSelected;
  final String? storageKey;

  ImageUploadContainer({
    required this.imageFile,
    required this.onImageSelected,
    this.storageKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() => imageFile.value == null
          ? DottedBorder(
        dashPattern: const [8, 6],
        color: Colors.blue,
        borderType: BorderType.RRect,
        strokeWidth: 2,
        radius: const Radius.circular(12),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          color: Colors.blue.withOpacity(0.15),
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Iconsax.document_upload5,
                size: 40,
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              const Text("Upload Image", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blue.withOpacity(0.16),
                  side: const BorderSide(color: Colors.blueAccent),
                ),
                onPressed: onImageSelected,
                icon: const Icon(Iconsax.arrow_up, color: Colors.blue),
                label: const Text(
                  "Choose Image",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      )
          : ImageTile(
        fileName: imageFile.value?.path.split('/').last ?? '',
        filePath: imageFile.value?.path ?? '',
        onCancel: () {
          imageFile.value = null;
          if (storageKey != null) {
            GetStorage().write('${storageKey!}_name', '');
            GetStorage().write('${storageKey!}_path', '');
          }
        },
        onEdit: onImageSelected,
      )),
    );
  }
}
