import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

class TextWithDifferentColor extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onTap;

  const TextWithDifferentColor({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: text1,
              style: TextStyles.caption1.copyWith(
                color: const Color(0xff64748B),
              ),
            ),
            TextSpan(
              text: text2,
              style: TextStyles.caption1.copyWith(
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ],
        ),
      ),
    );
  }
}
