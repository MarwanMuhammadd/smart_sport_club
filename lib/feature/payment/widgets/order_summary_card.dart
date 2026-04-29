import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/feature/payment/data/renewal_plan_model.dart';

class OrderSummaryCard extends StatelessWidget {
  final RenewalPlan? plan;

  const OrderSummaryCard({super.key, this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadows: [
          BoxShadow(
            color: const Color(0x140D1C2D),
            blurRadius: 32,
            offset: const Offset(0, 12),
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            'ORDER SUMMARY',
            style: TextStyles.caption1.copyWith(
              color: AppColors.secondaryText,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.4,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      plan?.title ?? '1 Year Membership',
                      style: TextStyles.headline.copyWith(),
                    ),
                    Text(
                      plan?.description ?? 'Full Club Access',
                      style: TextStyles.caption1.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                plan?.price ?? '2,000 EGP',
                textAlign: TextAlign.right,
                style: TextStyles.headline.copyWith(
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.w800,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
