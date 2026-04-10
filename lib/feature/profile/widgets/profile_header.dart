import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String imageUrl;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 112.w, // 28 * 4 from tailwind w-28
              height: 112.w,
              padding: EdgeInsets.all(4.w), // p-1 equivalent
              decoration: const BoxDecoration(
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
                    image: NetworkImage(imageUrl),
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
                child: Icon(
                  Icons.verified,
                  color: Colors.white,
                  size: 16.w,
                ),
              ),
            ),
          ],
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
        Text(
          email,
          style: TextStyles.caption1.copyWith(
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
