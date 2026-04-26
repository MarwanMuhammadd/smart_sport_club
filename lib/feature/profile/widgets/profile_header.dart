import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/avatar_image.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String imageUrl;
  final File? imageFile;
  final VoidCallback? onEditTap;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.imageUrl,
    this.imageFile,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AvatarImage(
          imageUrl: imageUrl,
          imageFile: imageFile,
          icon: Icons.edit,
          onTap: onEditTap ?? () => Navigations.pushTo(context, AppRoutes.editProfile),
        ),
        16.H,
        Text(
          name,
          style: TextStyles.headline.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w800,
          ),
        ),
        4.H,
      ],
    );
  }
}
