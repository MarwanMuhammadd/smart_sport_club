import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';

class AcademiesHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const AcademiesHeader({
    super.key,
    this.title = 'Academies',
    this.subtitle = 'Manage all sports academies in your club',
    this.buttonText = 'Add New Academy',
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Title
        Text(
          title,
          style: TextStyles.hugeHeadLine.copyWith(
            color: AppColors.primaryColor,
            fontSize: isSmallScreen ? 32 : 48,
            letterSpacing: -1.2,
          ),
        ),
        const SizedBox(height: 8),

        // Subtitle and Action Button
        if (isSmallScreen)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
                style: TextStyles.body.copyWith(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              if (onButtonPressed != null)
                SizedBox(
                  width: double.infinity,
                  child: _buildAddButton(context),
                ),
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  subtitle,
                  style: TextStyles.body.copyWith(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              if (onButtonPressed != null)
                SizedBox(
                  width: 240,
                  child: _buildAddButton(context),
                ),
            ],
          ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return MainButton(
      text: buttonText,
      onPressed: onButtonPressed!,
      height: 48,
      bgColor: AppColors.primaryGreen,
      textStyle: TextStyles.body.copyWith(
        color: AppColors.primaryColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
