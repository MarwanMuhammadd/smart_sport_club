import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/validators.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/custom_text_form_fields.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/feature/auth/widgets/build_field_label.dart';

class CreateNewPassword extends StatefulWidget {
  const CreateNewPassword({super.key});

  @override
  State<CreateNewPassword> createState() => _CreateNewPasswordState();
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  bool isEightChar = false;
  bool passwordsMatch = false;
  bool hasSpecialChar = false;
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  final formKey = GlobalKey<FormState>();

  void checkPassword(String password) {
    setState(() {
      isEightChar = password.length >= 8;
      hasSpecialChar =
          password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) ||
          password.contains(RegExp(r'[0-9]'));
    });
    checkMatch();
  }

  void checkMatch() {
    setState(() {
      passwordsMatch =
          newPasswordController.text == confirmPasswordController.text &&
          confirmPasswordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.backgroundColor),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen.withOpacity(.09),
                          borderRadius: BorderRadius.circular(70.w),
                          border: Border.all(color: Colors.white12, width: 1.w),
                        ),
                        child: Icon(
                          Icons.lock_reset,
                          size: 80.w,
                          color: AppColors.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                20.H,
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "Secure Your \n Account",
                    style: TextStyles.title.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  textAlign: TextAlign.center,
                  "Enter a new password for your Smart Sports Club account. Make Sute it's strong and unique",
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.accentGrey,
                  ),
                ),
                20.H,
                const BuildFieldLabel(
                  label: "New Password",
                  color: AppColors.blackColor,
                ),
                CustomTextFormField(
                  validator: AppValidators.password,
                  hintText: "Min, 8 characters",
                  controller: newPasswordController,
                  obscureText: _obscureNewPassword,
                  onChanged: checkPassword,
                  prefixIcon: Icon(Icons.key, color: const Color(0xff5C6D65), size: 20.w),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xff5C6D65),
                      size: 20.w,
                    ),
                    onPressed: () => setState(
                      () => _obscureNewPassword = !_obscureNewPassword,
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                const BuildFieldLabel(
                  label: "Confirm Password",
                  color: AppColors.blackColor,
                ),
                CustomTextFormField(
                  validator: (value) => AppValidators.confirmPassword(
                    value,
                    confirmPasswordController.text,
                  ),
                  hintText: "Repeat your password",
                  controller: confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  onChanged: (value) => checkMatch(),
                  prefixIcon: Icon(Icons.check, color: const Color(0xff5C6D65), size: 20.w),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xff5C6D65),
                      size: 20.w,
                    ),
                    onPressed: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                buildValidator(),
                SizedBox(height: 16.h),
                MainButton(
                  text: "Reset Password",
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      context.go(AppRoutes.login);
                    }
                  },
                ),
                32.H,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildValidator() {
    return Column(
      children: [
        Row(
          children: [
            buildIndicator(isActive: isEightChar),
            8.W,
            buildIndicator(isActive: hasSpecialChar),
            8.W,
            buildIndicator(isActive: passwordsMatch),
          ],
        ),
        16.H,
        requirementValidator("At least 8 characters", isEightChar),
        4.H,
        requirementValidator(
          "Include a number or special character",
          hasSpecialChar,
        ),
        4.H,
        requirementValidator("Passwords match", passwordsMatch),
      ],
    );
  }

  Widget buildIndicator({required bool isActive}) {
    return Expanded(
      child: Container(
        height: 5.h,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryGreen : AppColors.accentGrey,
          borderRadius: BorderRadius.circular(10.w),
        ),
      ),
    );
  }

  Widget requirementValidator(String text, bool isMatch) {
    return Row(
      children: [
        Icon(
          isMatch ? Icons.check_circle : Icons.circle,
          color: isMatch ? AppColors.primaryGreen : AppColors.accentGrey,
          size: 20.w,
        ),
        12.W,
        Text(
          text,
          style: TextStyles.caption1.copyWith(
            color: isMatch ? AppColors.primaryGreen : AppColors.accentGrey,
          ),
        ),
      ],
    );
  }
}
