import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ImageTile extends StatelessWidget {
  final String fileName;
  final String filePath;
  final VoidCallback onCancel;
  final VoidCallback onEdit;

  const ImageTile({
    super.key,
    required this.fileName,
    required this.filePath,
    required this.onCancel,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.black.withOpacity(0.3),
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.file(
            File(filePath),
            width: 50,
            height: 50,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Iconsax.edit_2,
              color: Colors.blue,
            ),
            onPressed: onEdit,
          ),
          IconButton(
            icon: const Icon(
              Icons.cancel_outlined,
              color: Colors.red,
            ),
            onPressed: onCancel,
          ),
        ],
      ),
    );
  }
}
