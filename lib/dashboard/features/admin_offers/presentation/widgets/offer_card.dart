import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/styles/text_styles.dart';
import '../../data/models/offer_model.dart';

class OfferCard extends StatelessWidget {
  final OfferModel offer;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const OfferCard({
    super.key,
    required this.offer,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSmall = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.all(isSmall ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cardBorder.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: isSmall ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(),
        const SizedBox(width: 20),
        Expanded(
          child: _buildDetails(),
        ),
        _buildActions(),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(size: 80),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusTag(),
                  const SizedBox(height: 8),
                  Text(
                    offer.title,
                    style: TextStyles.title.copyWith(
                      color: AppColors.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            _buildActions(isVertical: false),
          ],
        ),
        const SizedBox(height: 16),
        _buildDescription(),
        const SizedBox(height: 16),
        _buildInfoRow(),
      ],
    );
  }

  Widget _buildImage({double size = 100}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.dashboardBackground,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(offer.imageUrl),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) => const Icon(Icons.image),
        ),
      ),
    );
  }

  Widget _buildDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatusTag(),
        const SizedBox(height: 12),
        Text(
          offer.title,
          style: TextStyles.title.copyWith(
            color: AppColors.primaryColor,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        _buildDescription(),
        const SizedBox(height: 16),
        _buildInfoRow(),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      offer.description,
      style: TextStyles.caption1.copyWith(
        color: AppColors.secondaryColor,
        height: 1.5,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildInfoRow() {
    return Wrap(
      spacing: 24,
      runSpacing: 8,
      children: [
        if (offer.endDate != null)
          _buildInfoItem(
            Icons.calendar_today_outlined, 
            'Ends ${DateFormat('MMM d, yyyy').format(offer.endDate!)}'
          ),
        _buildInfoItem(Icons.people_outline, '${offer.usedCount} Used'),
        _buildInfoItem(Icons.category_outlined, offer.type[0].toUpperCase() + offer.type.substring(1)),
      ],
    );
  }

  Widget _buildStatusTag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: offer.isActive 
            ? AppColors.primaryGreen.withValues(alpha: 0.1)
            : AppColors.errorColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: offer.isActive ? AppColors.primaryGreen : AppColors.errorColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            offer.isActive ? 'ACTIVE' : 'INACTIVE',
            style: TextStyles.small.copyWith(
              color: offer.isActive ? const Color(0xFF006E2C) : AppColors.errorColor,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.secondaryColor),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyles.caption2.copyWith(
            color: AppColors.secondaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActions({bool isVertical = true}) {
    final children = [
      IconButton(
        onPressed: onEdit,
        icon: const Icon(Icons.edit_outlined, color: AppColors.secondaryColor, size: 20),
        tooltip: 'Edit',
      ),
      IconButton(
        onPressed: onDelete,
        icon: const Icon(Icons.delete_outline, color: AppColors.errorColor, size: 20),
        tooltip: 'Delete',
      ),
    ];

    return isVertical ? Column(children: children) : Row(children: children);
  }
}
