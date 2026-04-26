import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class CustomClickableContainer extends StatelessWidget {
  const CustomClickableContainer({
    super.key,
    this.text,
    this.prefixIcon,
    this.onTap,
    this.fillColor = AppColors.primaryColor,
    this.height = 65,
  });

  final String? text;
  final Widget? prefixIcon;
  final Function()? onTap;
  final Color fillColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25.w),
      child: Container(
        height: height.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(25.w),
          border: Border.all(color: AppColors.primaryGreen, width: 2.w),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null) ...[prefixIcon!, SizedBox(width: 10.w)],
              Text(
                text ?? "",
                style: TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
