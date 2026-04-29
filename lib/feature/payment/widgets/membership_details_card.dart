import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

import 'membership_detail_row.dart';

class MembershipDetailsCard extends StatelessWidget {
  final String membershipType;
  final String paymentMethod;
  final String startDate;
  final String expiryDate;

  const MembershipDetailsCard({
    super.key,
    required this.membershipType,
    required this.paymentMethod,
    required this.startDate,
    required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: AppColors.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadows: [
            BoxShadow(
              color: AppColors.accentGrey,
              blurRadius: 20,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            // Header with Details title and Active badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'DETAILS',
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.accentGrey,
                    letterSpacing: 1.6,
                  ),
                ),
              ],
            ),
            // Details rows
            Column(
              children: [
                MembershipDetailRow(
                  icon: Icons.card_membership,
                  label: 'Membership Type',
                  value: membershipType,
                ),
                MembershipDetailRow(
                  icon: Icons.payment,
                  label: 'Payment Method',
                  value: paymentMethod,
                ),
                MembershipDetailRow(
                  icon: Icons.calendar_today,
                  label: 'Start Date',
                  value: startDate,
                ),
                MembershipDetailRow(
                  icon: Icons.event_available,
                  label: 'Expiry Date',
                  value: expiryDate,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
