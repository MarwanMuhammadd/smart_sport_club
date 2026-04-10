import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class TabItem extends StatelessWidget {
  final String title;
  final bool active;

  const TabItem({super.key, required this.title, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: active ? AppColors.primaryGreen : AppColors.secondaryText,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          height: 3.h,
          width: 60.w,
          decoration: BoxDecoration(
            color: active ? AppColors.primaryGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(10.w),
          ),
        ),
      ],
    );
  }
}
