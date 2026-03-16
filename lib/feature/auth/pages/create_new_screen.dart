import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/funcations/validators.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/custom_text_form_fields.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/feature/auth/pages/login_screen.dart';
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
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.backgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(20.0),

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
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen.withOpacity(.09),
                          borderRadius: BorderRadius.circular(70),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Icon(
                          Icons.lock_reset,
                          size: 80,
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
                SizedBox(height: 8),
                Text(
                  textAlign: TextAlign.center,
                  "Enter a new password for your Smart Sports Club account. Make Sute it's strong and unique",
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.accentGrey,
                  ),
                ),
                20.H,
                BuildFieldLabel(
                  label: "New Password",
                  color: AppColors.blackColor,
                ),
                CustomTextFormField(
                  validator: AppValidators.password,
                  hintText: "Min, 8 characters",
                  controller: newPasswordController,
                  obscureText: _obscureNewPassword,
                  onChanged: checkPassword,
                  prefixIcon: const Icon(Icons.key, color: Color(0xff5C6D65)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureNewPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Color(0xff5C6D65),
                    ),
                    onPressed: () => setState(
                      () => _obscureNewPassword = !_obscureNewPassword,
                    ),
                  ),
                ),
                SizedBox(height: 32),
                BuildFieldLabel(
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
                  prefixIcon: const Icon(Icons.check, color: Color(0xff5C6D65)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Color(0xff5C6D65),
                    ),
                    onPressed: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                builValidator(),

                SizedBox(height: 16),
                MainButton(
                  text: "Reset Password",
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      Navigations.pushTo(context, LoginScreen());
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

  Widget builValidator() {
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
        requirmentVaildator("At least 8 characters", isEightChar),
        4.H,
        requirmentVaildator(
          "Include a number or special character",
          hasSpecialChar,
        ),
        4.H,
        requirmentVaildator("Passwords match", passwordsMatch),
      ],
    );
  }

  Widget buildIndicator({required bool isActive}) {
    return Expanded(
      child: Container(
        height: 5,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryGreen : AppColors.accentGrey,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget requirmentVaildator(String text, bool isMatch) {
    return Row(
      children: [
        Icon(
          isMatch ? Icons.check_circle : Icons.circle,
          color: isMatch ? AppColors.primaryGreen : AppColors.accentGrey,
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
