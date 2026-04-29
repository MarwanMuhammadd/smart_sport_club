import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class SuccessHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const SuccessHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8,
        children: [
          Lottie.asset(
            AppImages.circleCheckJson,
            width: 250.w,
            height: 150.w,
            fit: BoxFit.contain,
          ),
          Text(title, textAlign: TextAlign.center, style: TextStyles.headline),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyles.body.copyWith(color: const Color(0xFF434844)),
          ),
        ],
      ),
    );
  }
}
