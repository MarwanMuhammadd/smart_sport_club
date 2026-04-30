import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/validators.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/custom_text_form_fields.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';

import 'package:smart_sport_club/core/widgets/responsive_center_wrapper.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  bool isEightCharacters = false;
  bool hasSpecialChar = false;
  bool _obscurePassword = true;
  final formKey = GlobalKey<FormState>();

  void onPasswordChanged(String password) {
    setState(() {
      isEightCharacters = password.length >= 8;
      hasSpecialChar =
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ||
          password.contains(RegExp(r'[0-9]'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);

    return ResponsiveCenterWrapper(
      backgroundColor: AppColors.blueColor,
      maxWidth: 500,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40 : 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          // Header Section with FittedBox for zoom stability
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.darkBlue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings,
                    size: 50,
                    color: AppColors.lightBlue,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Admin Login",
                  style: TextStyles.hugeHeadLine.copyWith(
                    color: Colors.white,
                    fontSize: isDesktop ? 42 : 34,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Secure access for smart sports club management",
                  style: TextStyles.caption1.copyWith(
                    color: Colors.white60,
                    fontSize: isDesktop ? 16 : 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          // Form Section
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel("Admin Email"),
                CustomTextFormField(
                  validator: AppValidators.email,
                  hintText: "admin@sportsclub.com",
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 20),
                _buildLabel("Admin Password"),
                CustomTextFormField(
                  validator: AppValidators.password,
                  hintText: "••••••••",
                  onChanged: onPasswordChanged,
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.black,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: 15),
                _buildValidationSection(),
                const SizedBox(height: 25),
                _buildLabel("Club Code or Admin Key"),
                CustomTextFormField(
                  validator: AppValidators.clubCode,
                  hintText: "XXXX-XXXX-XXXX",
                  prefixIcon: const Icon(
                    Icons.vpn_key_outlined,
                    color: Colors.white30,
                    size: 20,
                  ),
                  suffixIcon: const Icon(
                    Icons.qr_code_scanner,
                    color: Colors.white30,
                    size: 20,
                  ),
                ),
                const SizedBox(height: 40),
                MainButton(
                  text: "Login as Administrator",
                  bgColor: const Color(0xff2563EB),
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      context.go(AppRoutes.homeDashboard);
                    }
                  },
                  textStyle: TextStyles.title.copyWith(
                    color: Colors.white,
                    fontSize: isDesktop ? 20 : 18,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
      child: Text(
        label,
        style: TextStyles.caption1.copyWith(color: Colors.white70),
      ),
    );
  }

  Widget _buildValidationSection() {
    return Column(
      children: [
        Row(
          children: [
            _buildIndicator(isActive: isEightCharacters),
            SizedBox(width: 8.w),
            _buildIndicator(isActive: hasSpecialChar),
            SizedBox(width: 8.w),
            _buildIndicator(isActive: false),
          ],
        ),
        SizedBox(height: 15.h),
        _buildRequirement("At least 8 characters", isEightCharacters),
        SizedBox(height: 12.h),
        _buildRequirement(
          "Include a number or special character",
          hasSpecialChar,
        ),
      ],
    );
  }

  Widget _buildIndicator({required bool isActive}) {
    return Expanded(
      child: Container(
        height: 4.h,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryGreen : AppColors.accentGrey,
          borderRadius: BorderRadius.circular(10.w),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle,
          size: 16.w,
          color: isMet ? AppColors.primaryGreen : Colors.white24,
        ),
        SizedBox(width: 10.w),
        Text(
          text,
          style: TextStyles.caption2.copyWith(
            color: isMet ? AppColors.primaryGreen : Colors.white30,
          ),
        ),
      ],
    );
  }
}
