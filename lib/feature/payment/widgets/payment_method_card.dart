import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class PaymentMethodCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isSelected;

  const PaymentMethodCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: ShapeDecoration(
        color: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            width: isSelected ? 2 : 1,
            color: isSelected
                ? AppColors.primaryGreen
                : const Color(0xFFBBCBB8),
          ),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x0C0D1C2D),
            blurRadius: 12,
            offset: const Offset(0, 4),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon container
          Container(
            width: 48,
            height: 48,
            decoration: ShapeDecoration(
              color: const Color(0xFFE5EFFF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Icon(
              Icons.payment,
              size: 24,
              color: Color(0xFF3B82F6),
            ),
          ),
          const SizedBox(width: 16),
          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  title,
                  style: TextStyles.title.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: TextStyles.caption2.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
              ],
            ),
          ),
          // Selection indicator
          Container(
            width: 24,
            height: 24,
            decoration: ShapeDecoration(
              color: isSelected ? AppColors.primaryGreen : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  width: 2,
                  color: isSelected
                      ? AppColors.primaryGreen
                      : const Color(0xFFBBCBB8),
                ),
              ),
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white, size: 14)
                : null,
          ),
        ],
      ),
    );
  }
}
