import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class MembershipDetailRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const MembershipDetailRow({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 12,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: ShapeDecoration(
                      color: AppColors.accentColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Icon(icon, size: 18, color: AppColors.primaryGreen),
                  ),
                  Text(
                    label.split(' ').join('\n'),
                    style: TextStyles.caption1.copyWith(
                      color: AppColors.accentGrey,
                    ),
                  ),
                ],
              ),
              Text(
                value,
                style: TextStyles.body.copyWith(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: const Color(0x4CC3C8C2),
        ),
      ],
    );
  }
}
