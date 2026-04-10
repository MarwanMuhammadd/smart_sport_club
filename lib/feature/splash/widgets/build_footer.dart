import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

Widget buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.security, color: AppColors.secondaryText, size: 14.w),
        SizedBox(width: 8.w),
        Text(
          'PRO LEAGUE STANDARD',
          style: TextStyle(
            color: AppColors.secondaryText,
            fontSize: 10.sp,
            letterSpacing: 2.w,
          ),
        ),
      ],
    );
  }