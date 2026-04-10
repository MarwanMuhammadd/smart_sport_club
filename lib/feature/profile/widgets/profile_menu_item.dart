import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Color iconBackgroundColor;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.w),
          boxShadow: [
            BoxShadow(
              color: AppColors.blueColor.withOpacity(0.04), // soft shadow
              blurRadius: 32,
              offset: const Offset(0, 12),
            ),
          ],
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(12.w),
              ),
              child: Icon(icon, color: iconColor, size: 24.w),
            ),
            16.W,
            Expanded(
              child: Text(
                title,
                style: TextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackColor,
                ),
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Icon(
                Icons.chevron_right,
                color: AppColors.secondaryText,
                size: 24.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
