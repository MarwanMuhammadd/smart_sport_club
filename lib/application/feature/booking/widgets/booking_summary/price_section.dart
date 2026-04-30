import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/application/feature/booking/widgets/booking_summary/price_breakdown_row.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.blackColor,
        borderRadius: BorderRadius.circular(18.w),
      ),
      child: Column(
        children: [
          const PriceBreakdownRow(title: 'Session Fee', value: '\$45.00'),
          const PriceBreakdownRow(title: 'Service Fee', value: '\$5.00'),
          Divider(color: Colors.white24, height: 20.h),
          const PriceBreakdownRow(
            title: 'Total Amount',
            value: '\$50.00',
            isTotal: true,
          ),
        ],
      ),
    );
  }
}
