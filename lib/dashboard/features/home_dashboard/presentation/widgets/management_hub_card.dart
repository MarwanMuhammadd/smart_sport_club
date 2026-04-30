import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class ManagementHubCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final IconData icon;
  final VoidCallback onViewDetails;

  const ManagementHubCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.icon,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: AppColors.cardBorder),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Container(
            height: 128,
            width: double.infinity,
            decoration: const BoxDecoration(color: AppColors.headerBorder),
            child: imageUrl.toLowerCase().endsWith('.svg')
                ? SvgPicture.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildErrorPlaceholder(),
                  )
                : Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _buildErrorPlaceholder(),
                  ),
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Floating Icon
                Transform.translate(
                  offset: const Offset(0, -48),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: ShapeDecoration(
                      color: AppColors.backgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 6,
                          offset: Offset(0, 4),
                          spreadRadius: -1,
                        ),
                      ],
                    ),
                    child: Icon(icon, color: AppColors.primaryColor, size: 24),
                  ),
                ),

                Transform.translate(
                  offset: const Offset(0, -32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 18,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: const TextStyle(
                          color: AppColors.secondaryColor,
                          fontSize: 14,
                          fontFamily: 'Plus Jakarta Sans',
                          fontWeight: FontWeight.w400,
                          height: 1.43,
                        ),
                      ),
                      const SizedBox(height: 16),
                      InkWell(
                        onTap: onViewDetails,
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'View Details',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 14,
                                fontFamily: 'Plus Jakarta Sans',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              size: 16,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Icon(Icons.image, color: Colors.grey),
    );
  }
}
