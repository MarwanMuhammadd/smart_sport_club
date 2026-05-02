import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class TrainerCard extends StatelessWidget {
  final String trainerId;
  final String name;
  final String academy;
  final String imageUrl;
  final VoidCallback? onDelete;

  const TrainerCard({
    super.key,
    required this.trainerId,
    required this.name,
    required this.academy,
    required this.imageUrl,
    this.onDelete,
  });

  Color get _tagColor {
    switch (academy.toLowerCase()) {
      case 'tennis':
        return const Color(0xFFEFF6FF);
      case 'football':
        return const Color(0xFFF0FDF4);
      case 'swimming':
        return const Color(0xFFF0F9FF);
      default:
        return const Color(0xFFF4F4F5);
    }
  }

  Color get _tagTextColor {
    switch (academy.toLowerCase()) {
      case 'tennis':
        return const Color(0xFF1D4ED8);
      case 'football':
        return const Color(0xFF15803D);
      case 'swimming':
        return const Color(0xFF0369A1);
      default:
        return const Color(0xFF71717A);
    }
  }

  Color get _borderColor {
    switch (academy.toLowerCase()) {
      case 'tennis':
        return const Color(0x191AD55F);
      case 'football':
        return const Color(0x1922C55E);
      case 'swimming':
        return const Color(0x190EA5E9);
      default:
        return const Color(0xFFE2E8F0);
    }
  }

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
                border: Border.all(color: _borderColor, width: 4),
              ),
              child: ClipOval(
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey[200],
                          child: const Icon(Icons.person,
                              size: 48, color: Colors.grey),
                        ),
                      )
                    : Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.person,
                            size: 48, color: Colors.grey),
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
            // Academy Tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: _tagColor,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                academy,
                textAlign: TextAlign.center,
                style: TextStyles.caption2.copyWith(
                  color: _tagTextColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Divider(color: Color(0xFFF4F4F5), height: 1),
            const SizedBox(height: 16),
            // Delete Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFFFCDD2)),
                    ),
                    child:
                        const Icon(Icons.delete, size: 18, color: AppColors.errorColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
