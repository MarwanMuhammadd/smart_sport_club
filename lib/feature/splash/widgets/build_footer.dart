import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

Widget buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.security, color: AppColors.secondaryText, size: 14),
        SizedBox(width: 8),
        Text(
          'PRO LEAGUE STANDARD',
          style: TextStyle(color: AppColors.secondaryText, fontSize: 10, letterSpacing: 2),
        ),
      ],
    );
  }