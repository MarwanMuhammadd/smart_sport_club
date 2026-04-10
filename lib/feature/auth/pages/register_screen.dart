import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/validators.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/custom_text_form_fields.dart';
import 'package:smart_sport_club/core/widgets/text_with_different_color.dart';
import 'package:smart_sport_club/feature/auth/widgets/build_field_label.dart';
import 'package:smart_sport_club/feature/auth/widgets/custom_clickable_containers.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.white, size: 32.w),
          onPressed: () => context.pop(),
        ),
        title: Text(
          "Member Registration",
          style: TextStyles.title.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Container(
                  padding: EdgeInsets.all(35.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40.w),
                    border: Border.all(color: Colors.white12, width: 1.w),
                  ),
                  child: Icon(
                    Icons.sports_soccer,
                    size: 80.w,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              Text(
                "Join the Club",
                style: TextStyles.hugeHeadLine.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                "Create your account to start booking football fields and join local tournaments.",
                style: TextStyles.body.copyWith(color: AppColors.secondaryText),
              ),
              SizedBox(height: 30.h),
              const BuildFieldLabel(label: "Full Name"),
              CustomTextFormField(
                hintText: "John Doe",
                validator: AppValidators.name,
                prefixIcon: Icon(Icons.person, color: const Color(0xff5C6D65), size: 20.w),
              ),
              SizedBox(height: 20.h),
              const BuildFieldLabel(label: "Email Address"),
              CustomTextFormField(
                hintText: "example@club.com",
                validator: AppValidators.email,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: const Color(0xff5C6D65),
                  size: 20.w,
                ),
              ),
              SizedBox(height: 20.h),
              const BuildFieldLabel(label: "Phone Number"),
              CustomTextFormField(
                validator: AppValidators.phone,
                hintText: "+1 234 567 890",
                prefixIcon: Icon(
                  Icons.phone_outlined,
                  color: const Color(0xff5C6D65),
                  size: 20.w,
                ),
              ),
              SizedBox(height: 30.h),
              const BuildFieldLabel(label: "National ID"),
              CustomTextFormField(
                validator: AppValidators.requiredField,
                hintText: "ID number",
                prefixIcon: Icon(Icons.perm_identity, color: const Color(0xff5C6D65), size: 20.w),
              ),
              SizedBox(height: 30.h),
              const BuildFieldLabel(label: "Create Password"),
              CustomTextFormField(
                controller: passwordController,
                validator: AppValidators.password,
                hintText: "**********",
                prefixIcon: Icon(Icons.lock, color: const Color(0xff5C6D65), size: 20.w),
                obscureText: _obscureText,
                suffixIcon: InkWell(
                  child: Icon(
                    _obscureText
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                    size: 20.w,
                  ),
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              SizedBox(height: 30.h),
              const BuildFieldLabel(label: "Confirm Password"),
              CustomTextFormField(
                validator: (value) => AppValidators.confirmPassword(
                  value,
                  passwordController.text,
                ),
                hintText: "**********",
                prefixIcon: Icon(Icons.lock_reset, color: const Color(0xff5C6D65), size: 20.w),
                obscureText: _obscureConfirmPassword,
                suffixIcon: InkWell(
                  child: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                    size: 20.w,
                  ),
                  onTap: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
              SizedBox(height: 30.h),
              CustomClickableContainer(
                text: "Register Account",
                prefixIcon: Icon(
                  Icons.person_add_alt_1_outlined,
                  color: AppColors.primaryGreen,
                  size: 24.w,
                ),
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.go(AppRoutes.mainApp);
                  }
                },
              ),
              SizedBox(height: 20.h),
              TextWithDifferentColor(
                text1: "Already have an account? ",
                text2: 'Log in',
                onTap: () {
                  context.push(AppRoutes.login);
                },
              ),
              32.H,
            ],
          ),
        ),
      ),
    );
  }
}
