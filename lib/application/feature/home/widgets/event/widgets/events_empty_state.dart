import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';

class EventsEmptyState extends StatelessWidget {
  final String message;
  final String message1;
  final String message2;

  const EventsEmptyState({super.key, required this.message, required this.message1, required this.message2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          message,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFB), // Very light grey for a clean look
            borderRadius: BorderRadius.circular(25.w),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            children: [
              Lottie.asset(
                AppImages.noEventJson,
                height: 150.h,
                repeat: true,
              ),
              SizedBox(height: 16.h),
              Text(
                message1,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1D1F24),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                message2,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF6B7280),
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
