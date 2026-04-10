import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';


class BookingInfoBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const BookingInfoBox({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95.w,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(16.w),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.primaryGreen, size: 24.w),
          SizedBox(height: 6.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppColors.secondaryText,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
