import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/application/feature/auth/widgets/header_part.dart';
import 'package:smart_sport_club/application/feature/auth/widgets/upper_part.dart';

class RequestPasswordScreen extends StatelessWidget {
  const RequestPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : Colors.white,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
        leading: InkWell(
          onTap: () => context.pop(),
          child: Icon(Icons.chevron_left, size: 24.w, color: isDark ? AppColors.darkTextPrimary : null),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: const SingleChildScrollView(
          child: Column(children: [HeaderPart(), UpperPart()]),
        ),
      ),
    );
  }
}
