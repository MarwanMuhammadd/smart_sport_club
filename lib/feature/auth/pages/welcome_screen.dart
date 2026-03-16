import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/feature/auth/pages/admin_screen.dart';
import 'package:smart_sport_club/feature/auth/pages/login_screen.dart';
import 'package:smart_sport_club/feature/auth/pages/register_screen.dart';
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
              /// HERO IMAGE
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
                    bottom: 20,
                    left: 20,
                    right: 20,
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

              /// BUTTONS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomClickableContainer(
                      prefixIcon: const Icon(Icons.person),
                      text: "Login as Member",
                      onTap: () {
                        Navigations.pushTo(context, LoginScreen());
                      },
                    ),

                    16.H,

                    CustomClickableContainer(
                      prefixIcon: const Icon(Icons.person_add),
                      text: "Register Account",
                      onTap: () {
                        Navigations.pushTo(context, RegisterScreen());
                      },
                    ),

                    16.H,

                    CustomClickableContainer(
                      prefixIcon: const Icon(Icons.security),
                      text: "Admin Portal",
                      onTap: () {
                        Navigations.pushTo(context, AdminLoginScreen());
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
