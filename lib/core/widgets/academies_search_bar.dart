import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class AcademiesSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String hintText;

  const AcademiesSearchBar({
    super.key,
    this.onChanged,
    this.hintText = 'Search by academy name',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cardBorder.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.dashboardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.cardBorder.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyles.caption1.copyWith(
              color: const Color(0xFF6B7280),
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xFF6B7280),
              size: 20,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
