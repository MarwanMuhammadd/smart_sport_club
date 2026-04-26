import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String timeAgo;
  final String description;
  final IconData icon;
  final Color baseColor;
  final void Function()? onViewDetails;

  const NotificationCard({
    super.key,
    required this.title,
    required this.timeAgo,
    required this.description,
    required this.icon,
    required this.baseColor,
    this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 12.h),
      decoration: _buildCardDecoration(),
      child: Stack(
        children: [
          _buildLeftBorderLine(),
          Padding(
            padding: EdgeInsets.all(24.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIconBox(),
                16.W,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderRow(),
                      4.H,
                      _buildDescriptionText(),
                      16.H,
                      _buildActionRow(),
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

  BoxDecoration _buildCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.w),
      boxShadow: [
        BoxShadow(
          color: AppColors.blueColor.withOpacity(0.06),
          blurRadius: 32,
          offset: const Offset(0, 12),
        ),
      ],
    );
  }

  Widget _buildLeftBorderLine() {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      child: Container(
        width: 4.w,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.w),
            bottomLeft: Radius.circular(16.w),
          ),
        ),
      ),
    );
  }

  Widget _buildIconBox() {
    return Container(
      width: 48.w,
      height: 48.w,
      decoration: BoxDecoration(
        color: baseColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12.w),
      ),
      child: Icon(icon, color: baseColor, size: 24.w),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyles.title.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
        ),
        Text(
          timeAgo,
          style: TextStyles.caption2.copyWith(
            color: AppColors.accentGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionText() {
    return Text(
      description,
      style: TextStyles.caption1.copyWith(
        color: AppColors.secondaryText,
        height: 1.5,
      ),
    );
  }

  Widget _buildActionRow() {
    return Row(
      children: [
        InkWell(
          onTap: onViewDetails,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [baseColor, baseColor.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30.w),
              boxShadow: [
                BoxShadow(
                  color: baseColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              "View Details",
              style: TextStyles.caption2.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const Spacer(),
        Container(
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(color: baseColor, shape: BoxShape.circle),
        ),
      ],
    );
  }
}
