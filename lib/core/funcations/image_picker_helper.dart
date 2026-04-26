import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';

class ImagePickerHelper {
  static Future<void> showImagePickerBottomSheet({
    required BuildContext context,
    required Function(File) onImagePicked,
  }) async {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.w)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from Gallery'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _pickImage(context, ImageSource.gallery, onImagePicked);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _pickImage(context, ImageSource.camera, onImagePicked);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> _pickImage(
    BuildContext context,
    ImageSource source,
    Function(File) onImagePicked,
  ) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      onImagePicked(File(pickedFile.path));
    }
  }
}
