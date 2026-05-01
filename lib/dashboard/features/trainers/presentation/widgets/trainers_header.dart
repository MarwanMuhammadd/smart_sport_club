import 'package:flutter/material.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/add_trainer_sheet.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';

class TrainersHeader extends StatelessWidget {
  final Function(String) onSearchChanged;
  const TrainersHeader({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Row: Title & Action Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trainers',
                    style: TextStyles.headline.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Manage all club trainers and their profiles',
                    style: TextStyles.body.copyWith(
                      color: const Color(0xFF434844),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            if (!isMobile) _buildAddButton(context),
          ],
        ),
        if (isMobile) ...[const SizedBox(height: 16), _buildAddButton(context)],
        const SizedBox(height: 32),
        // Search Bar
        _buildSearchBar(context),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const AddTrainerSheet(),
        );
      },

      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.primaryGreen,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, color: AppColors.primaryColor, size: 20),
            const SizedBox(width: 8),
            Text(
              'Add New Trainer',
              style: TextStyles.body.copyWith(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 500),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),

      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFF6B7280), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search by trainer name',
                hintStyle: TextStyles.caption1.copyWith(
                  color: const Color(0xFF6B7280),
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
