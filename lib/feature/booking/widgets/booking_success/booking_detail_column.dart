import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class BookingDetailColumn extends StatelessWidget {
  final String title;
  final String value;
  final bool isHighlighted;
  final bool isAlignEnd;

  const BookingDetailColumn({
    super.key,
    required this.title,
    required this.value,
    this.isHighlighted = false,
    this.isAlignEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isAlignEnd
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 12.sp, color: AppColors.secondaryText),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: isHighlighted ? 20.sp : 14.sp,
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w500,
            color: isHighlighted ? AppColors.primaryGreen : Colors.white,
          ),
        ),
      ],
    );
  }
}
