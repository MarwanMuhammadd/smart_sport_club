import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';


class PriceBreakdownRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const PriceBreakdownRow({
    super.key,
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isTotal ? Colors.white : AppColors.secondaryText,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: isTotal ? AppColors.primaryGreen : Colors.white,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 20.sp : 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
