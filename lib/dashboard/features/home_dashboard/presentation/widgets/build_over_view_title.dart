import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class BuildOverViewTitle extends StatelessWidget {
  const BuildOverViewTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: 16,
      runSpacing: 16,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard Overview',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 24,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w600,
                height: 1.30,
                letterSpacing: -0.24,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Welcome back, Admin. Here\'s what\'s happening today.',
              style: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 16,
                fontFamily: 'Plus Jakarta Sans',
                fontWeight: FontWeight.w400,
                height: 1.60,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: ShapeDecoration(
            color: const Color(0xFFF5F3F1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today,
                size: 16,
                color: AppColors.secondaryColor,
              ),
              SizedBox(width: 12),
              Text(
                'OCTOBER 24, 2023',
                style: TextStyle(
                  color: AppColors.secondaryColor,
                  fontSize: 13,
                  fontFamily: 'Plus Jakarta Sans',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.65,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
