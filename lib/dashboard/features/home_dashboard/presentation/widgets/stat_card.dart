import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  //final String trend;
  final IconData icon;
  final bool isPositive;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    // required this.trend,
    required this.icon,
    this.isPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.cardBorder),
          borderRadius: BorderRadius.circular(12),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  color: AppColors.primaryGreen.withValues(alpha: 0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Icon(icon, color: AppColors.primaryGreen, size: 20),
              ),
            
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: AppColors.secondaryColor,
              fontSize: 13,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w600,
              letterSpacing: 1.30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.primaryColor,
              fontSize: 32,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
