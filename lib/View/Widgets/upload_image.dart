import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'image_tile.dart';

class ImageUploadContainer extends StatelessWidget {
  final RxString fileName = ''.obs;
  final RxString filePath = ''.obs;
  final String? storageKey;
  final String? initialFileName;
  final String? initialFilePath;

  ImageUploadContainer({
    super.key,
    this.storageKey,
    this.initialFileName,
    this.initialFilePath,
  }) {
    if (initialFileName != null && fileName.value.isEmpty) {
      fileName.value = initialFileName!;
    }
    if (initialFilePath != null && filePath.value.isEmpty) {
      filePath.value = initialFilePath!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() => fileName.value.isEmpty
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
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Iconsax.document_upload5,
                size: 40,
                color: Colors.blue,
              ),
              const SizedBox(height: 10),
              const Text("Upload Image", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue.withOpacity(0.16),
                      side: const BorderSide(color: Colors.blueAccent),
                    ),
                    onPressed: () => pickAndUploadImage(context),
                    icon: const Icon(Iconsax.arrow_up, color: Colors.blue),
                    label: const Text(
                      "Choose Image",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          : ImageTile(
        fileName: fileName.value,
        filePath: filePath.value,
        onCancel: () {
          fileName.value = '';
          filePath.value = '';
          saveFile('', '');
        },
        onEdit: () => pickAndUploadImage(context),
      )),
    );
  }

  Future<void> pickAndUploadImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        fileName.value = pickedFile.name;
        filePath.value = pickedFile.path;
        saveFile(pickedFile.name, pickedFile.path);
      } else {
        print('User canceled the image picker.');
      }
    } catch (error) {
      print('Upload failed: $error');
    }
  }

  void saveFile(String fileName, String filePath) {
    if (storageKey != null) {
      GetStorage().write('${storageKey!}_name', fileName);
      GetStorage().write('${storageKey!}_path', filePath);

      print('File saved:');
      print('Name: $fileName');
      print('Path: $filePath');
      print(storageKey);
    } else {
      print('Storage key is null. Cannot save file.');
    }
  }


  Map<String, String?> retrieveStoredFileData(String storageKey) {
    String? storedFileName = GetStorage().read('${storageKey}_name');
    String? storedFilePath = GetStorage().read('${storageKey}_path');
    return {
      'fileName': storedFileName,
      'filePath': storedFilePath,
    };
  }

}
