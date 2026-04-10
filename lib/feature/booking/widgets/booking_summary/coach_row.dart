import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

import 'package:smart_sport_club/feature/sports/data/coach_data.dart';

class CoachRow extends StatelessWidget {
  const CoachRow({super.key, required this.coach});
  final CoachData coach;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24.w,
          backgroundImage: AssetImage(coach.imagePath),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Coach ${coach.name}',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, size: 14.w, color: AppColors.primaryGreen),
                SizedBox(width: 4.w),
                Text(
                  '5.0 (124 reviews)',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
