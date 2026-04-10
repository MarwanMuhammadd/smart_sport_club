import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/feature/auth/widgets/custom_clickable_containers.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(
          "Smart Club",
          style: TextStyles.title.copyWith(color: AppColors.accentColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: height * 0.38,
                    width: double.infinity,
                    child: Image.asset(
                      AppImages.heroImage,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Positioned(
                    bottom: 20.h,
                    left: 20.w,
                    right: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Elevate Your Game",
                          style: TextStyles.hugeHeadLine.copyWith(
                            color: AppColors.accentColor,
                          ),
                        ),
                        8.H,
                        Text(
                          "The premier destination for football enthusiasts and professional bookings.",
                          style: TextStyles.caption1.copyWith(
                            color: AppColors.accentColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              32.H,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    CustomClickableContainer(
                      prefixIcon: Icon(Icons.person, size: 24.w),
                      text: "Login as Member",
                      onTap: () {
                        context.push(AppRoutes.login);
                      },
                    ),
                    16.H,
                    CustomClickableContainer(
                      prefixIcon: Icon(Icons.person_add, size: 24.w),
                      text: "Register Account",
                      onTap: () {
                        context.push(AppRoutes.register);
                      },
                    ),
                    16.H,
                    CustomClickableContainer(
                      prefixIcon: Icon(Icons.security, size: 24.w),
                      text: "Admin Portal",
                      onTap: () {
                        context.push(AppRoutes.adminLogin);
                      },
                    ),
                    40.H,
                    Text(
                      "POWERED BY SMARTCLUB TECH",
                      style: TextStyles.body.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    20.H,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
