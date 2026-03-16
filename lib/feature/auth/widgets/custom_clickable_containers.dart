import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';

class CustomClickableContainer extends StatelessWidget {
  const CustomClickableContainer({
    super.key,
    this.text,
    this.prefixIcon,
    this.onTap,
    this.fillColor = AppColors.primaryColor,
    this.height = 65, // ارتفاع تقريبي يناسب الـ vertical padding اللي كان موجود
  });

  final String? text;
  final Widget? prefixIcon;
  final Function()? onTap;
  final Color fillColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // هنا الاكشن اللي هيحصل لما تدوس
      borderRadius: BorderRadius.circular(25), // عشان تأثير الضغطة (Ripple) ميتخطاش الحدود
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.primaryGreen,
            width: 2,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min, // عشان يخلي الأيقونة والنص في نص الـ Container بالظبط
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                const SizedBox(width: 10), // مسافة بين الأيقونة والنص
              ],
              Text(
                text ?? "",
                style: const TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: 18,
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