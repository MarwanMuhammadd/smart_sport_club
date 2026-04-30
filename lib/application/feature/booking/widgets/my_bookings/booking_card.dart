import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class BookingCard extends StatelessWidget {
  final String title;
  final String coach;
  final String date;
  final String imageUrl;
  final String footer;

  const BookingCard({
    super.key,
    required this.title,
    required this.coach,
    required this.date,
    required this.imageUrl,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(15.w),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.w),
                  child: Image.asset(
                    imageUrl,
                    width: 80.w,
                    height: 80.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        coach,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.secondaryText,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15.w),
              ),
            ),
            child: Text(
              footer,
              style: TextStyle(fontSize: 12.sp, color: AppColors.secondaryText),
            ),
          ),
        ],
      ),
    );
  }
}
