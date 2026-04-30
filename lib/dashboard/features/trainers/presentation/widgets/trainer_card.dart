import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class TrainerCard extends StatelessWidget {
  final String name;
  final String role;
  final String imageUrl;
  final Color tagColor;
  final Color tagTextColor;
  final Color avatarBorderColor;

  const TrainerCard({
    super.key,
    required this.name,
    required this.role,
    required this.imageUrl,
    this.tagColor = const Color(0xFFEFF6FF),
    this.tagTextColor = const Color(0xFF1D4ED8),
    this.avatarBorderColor = const Color(0x191AD55F),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: avatarBorderColor, width: 4),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Name
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyles.title.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            // Role Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: tagColor,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                role,
                textAlign: TextAlign.center,
                style: TextStyles.caption2.copyWith(
                  color: tagTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Divider
            const Divider(color: Color(0xFFF4F4F5), height: 1),
            const SizedBox(height: 16),
            // Actions/Stats Placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_buildActionButton(Icons.delete)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Icon(icon, size: 18, color: AppColors.errorColor),
    );
  }
}
