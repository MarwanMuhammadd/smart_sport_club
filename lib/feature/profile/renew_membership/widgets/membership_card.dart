import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class MembershipCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color baseColor;

  const MembershipCard({
    super.key,
    required this.title,
    required this.icon,
    required this.baseColor,
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
                    children: [_buildHeaderRow(), 16.H, _buildActionRow()],
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
      ],
    );
  }

  Widget _buildActionRow() {
    return Row(
      children: [
        Icon(
          Icons.calendar_month_outlined,
          color: AppColors.primaryColor,
          size: 20.w,
        ),
        8.W,
        Text(
          maxLines: 2,
          'Your membership will expire \n on 25 Dec 2024',
          style: TextStyles.caption1.copyWith(color: const Color(0xFF3C4A3C)),
        ),
      ],
    );
  }
}
