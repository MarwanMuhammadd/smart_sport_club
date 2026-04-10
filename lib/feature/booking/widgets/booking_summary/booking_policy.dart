import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class BookingPolicy extends StatelessWidget {
  const BookingPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.info, size: 18.w, color: Colors.white),
            SizedBox(width: 6.w),
            Text(
              'Booking Policy',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.primaryGreen.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14.w),
          ),
          child: Text(
            '• Please arrive 10 minutes before your session.\n'
            '• Free cancellation up to 3 hours before start.',
            style: TextStyle(color: AppColors.secondaryText, fontSize: 13.sp),
          ),
        ),
      ],
    );
  }
}
