import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/theme/theme_cubit.dart';
import 'package:smart_sport_club/core/theme/theme_state.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.isDarkMode;
        final backgroundColor = isDark
            ? AppColors.darkBackground
            : AppColors.backgroundColor;
        final cardColor = isDark ? AppColors.darkCard : Colors.white;
        final textColor = isDark
            ? AppColors.darkTextPrimary
            : AppColors.primaryColor;
        final subtitleColor = isDark
            ? AppColors.darkTextSecondary
            : AppColors.secondaryColor;
        final borderColor = isDark
            ? AppColors.darkBorder
            : AppColors.cardBorder;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: state.isDarkMode
                ? AppColors.darkCard
                : AppColors.primaryGreen,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16.w),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
                    blurRadius: 24,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14.w),
                    ),
                    child: Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      color: AppColors.primaryGreen,
                      size: 24.w,
                    ),
                  ),
                  14.W,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Dark Mode',
                          style: TextStyles.body.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        4.H,
                        Text(
                          isDark ? 'Enabled' : 'Disabled',
                          style: TextStyles.caption1.copyWith(
                            color: subtitleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  CupertinoSwitch(
                    value: isDark,
                    activeColor: AppColors.primaryGreen,
                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme(value);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
