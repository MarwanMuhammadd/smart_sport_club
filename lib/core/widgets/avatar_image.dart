import 'dart:io';
import 'package:date_picker_timeline/extra/color.dart' hide AppColors;
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class AvatarImage extends StatelessWidget {
  const AvatarImage({super.key, required this.imageUrl, required this.icon, this.onTap, this.imageFile});

  final String imageUrl;
  final File? imageFile;
  final IconData icon;
  final void Function()? onTap;


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          width: 112.w, // 28 * 4 from tailwind w-28
          height: 112.w,
          padding: EdgeInsets.all(4.w), // p-1 equivalent
          decoration:  BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryColor, // using primary and green to match the theme
                AppColors.primaryGreen,
              ],
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4.w),
              image: DecorationImage(
                image: imageFile != null ? FileImage(imageFile!) as ImageProvider : NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 4.w,
          right: 4.w,
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.w),
            ),
            child: GestureDetector(
              onTap: onTap,
              child: Icon(icon, color: Colors.white, size: 16.w),
            ),
          ),
        ),
      ],
    );
  }
}
