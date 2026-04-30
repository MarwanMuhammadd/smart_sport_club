import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/widgets/avatar_image.dart';

class EditHeader extends StatelessWidget {
  final String imageUrl;
  final File? imageFile;
  final VoidCallback? onImageTap;

  const EditHeader({super.key, required this.imageUrl, this.imageFile, this.onImageTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AvatarImage(
          imageUrl: imageUrl,
          imageFile: imageFile,
          icon: Icons.camera,
          onTap: onImageTap,
        ),
        16.H,
      ],
    );
  }
}
