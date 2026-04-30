import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class PaymentMethodChip extends StatelessWidget {
  final String text;
  final bool isSelected;
  final IconData? icon;

  const PaymentMethodChip({
    super.key,
    required this.text,
    this.isSelected = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryGreen.withOpacity(0.15)
            : Colors.black26,
        borderRadius: BorderRadius.circular(30.w),
        border: Border.all(
          color: isSelected ? AppColors.primaryGreen : Colors.white24,
          width: 2.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(icon, size: 16.w, color: AppColors.primaryGreen),
          if (icon != null) SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? AppColors.primaryGreen
                  : AppColors.secondaryText,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
