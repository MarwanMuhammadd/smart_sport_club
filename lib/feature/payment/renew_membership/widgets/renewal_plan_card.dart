import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class RenewalPlanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final bool isSelected;
  final bool isBestValue;
  final String? discountText;
  final VoidCallback onTap;

  const RenewalPlanCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isSelected,
    this.isBestValue = false,
    this.discountText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryGreen.withOpacity(0.05)
                  : AppColors.accentColor,
              borderRadius: BorderRadius.circular(12.w),
              border: Border.all(
                color: isSelected ? AppColors.primaryGreen : Colors.transparent,
                width: 2.w,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryGreen
                            : const Color(0xFFD4E4FA),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.workspace_premium_outlined,
                          color: isSelected
                              ? Colors.white
                              : AppColors.primaryColor,
                          size: 24.w,
                        ),
                      ),
                    ),
                    12.W,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: TextStyles.title),
                        4.H,
                        Text(
                          subtitle,
                          style: TextStyles.caption1.copyWith(
                            color: const Color(0xFF3C4A3C),
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      textAlign: TextAlign.right,
                      style: TextStyles.title.copyWith(fontSize: 20.sp),
                    ),
                    if (discountText != null) ...[
                      4.H,
                      Text(
                        discountText!,
                        style: TextStyles.caption1.copyWith(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: 10.sp,
                          letterSpacing: -0.50,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (isBestValue)
            Positioned(
              left: 200.w,
              top: -10.h,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(20.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  'BEST VALUE',
                  style: TextStyles.caption1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 10.sp,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
