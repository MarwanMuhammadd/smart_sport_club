import 'package:flutter/material.dart';
import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/styles/text_styles.dart';

class OffersStatsSection extends StatelessWidget {
  final double maxWidth;
  final int activeCount;

  const OffersStatsSection({
    super.key, 
    required this.maxWidth,
    this.activeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSmall = maxWidth < 700;

    return isSmall
        ? Column(
            children: [
              _buildStatCard('ACTIVE OFFERS', '$activeCount', '+12%', AppColors.primaryGreen),
              const SizedBox(height: 16),
              _buildStatCard('EXPIRING SOON', '0', 'Stable', AppColors.accentGrey),
            ],
          )
        : Row(
            children: [
              Expanded(child: _buildStatCard('ACTIVE OFFERS', '$activeCount', '+12%', AppColors.primaryGreen)),
              const SizedBox(width: 24),
              Expanded(child: _buildStatCard('EXPIRING SOON', '0', 'Stable', AppColors.accentGrey)),
            ],
          );
  }

  Widget _buildStatCard(String label, String value, String trend, Color trendColor) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cardBorder.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: trendColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.local_offer_outlined, color: trendColor, size: 20),
              ),
              Text(
                trend,
                style: TextStyles.caption2.copyWith(
                  color: trendColor == AppColors.primaryGreen ? const Color(0xFF006E2C) : trendColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: TextStyles.caption2.copyWith(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.65,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyles.hugeHeadLine.copyWith(
              color: AppColors.primaryColor,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }
}
