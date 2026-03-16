import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/funcations/validators.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart'; // تأكد من المسار الصحيح
import 'package:smart_sport_club/core/widgets/custom_text_form_fields.dart';
import 'package:smart_sport_club/core/widgets/text_with_different_color.dart';
import 'package:smart_sport_club/feature/auth/pages/login_screen.dart';
import 'package:smart_sport_club/feature/auth/widgets/build_field_label.dart';
import 'package:smart_sport_club/feature/auth/widgets/custom_clickable_containers.dart';
import 'package:smart_sport_club/main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController? newPasswordController = TextEditingController();
  TextEditingController? passwordController = TextEditingController();
  bool _obscureText = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // لجعل الخلفية متناسقة
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Member Registration",
          style: TextStyles.title.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // أيقونة النادي المميزة
              Center(
                child: Container(
                  padding: const EdgeInsets.all(35),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Icon(
                    Icons.sports_soccer,
                    size: 80,
                    color: AppColors.primaryGreen,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                "Join the Club",
                style: TextStyles.hugeHeadLine.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                "Create your account to start booking football fields and join local tournaments.",
                style: TextStyles.body.copyWith(color: AppColors.secondaryText),
              ),
              const SizedBox(height: 30),

              BuildFieldLabel(label: "Full Name"),
              const CustomTextFormField(
                hintText: "John Doe",
                validator: AppValidators.name,
                prefixIcon: Icon(Icons.person, color: Color(0xff5C6D65)),
              ),
              const SizedBox(height: 20),

              BuildFieldLabel(label: "Email Address"),
              const CustomTextFormField(
                hintText: "example@club.com",
                validator: AppValidators.email,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Color(0xff5C6D65),
                ),
              ),
              const SizedBox(height: 20),

              BuildFieldLabel(label: "Phone Number"),
              const CustomTextFormField(
                validator: AppValidators.phone,
                hintText: "+1 234 567 890",
                prefixIcon: Icon(
                  Icons.phone_outlined,
                  color: Color(0xff5C6D65),
                ),
              ),
              const SizedBox(height: 30),
              BuildFieldLabel(label: "National ID"),
              const CustomTextFormField(
                validator: AppValidators.requiredField,
                hintText: "ID number",
                prefixIcon: Icon(Icons.perm_identity, color: Color(0xff5C6D65)),
              ),
              const SizedBox(height: 30),
              BuildFieldLabel(label: "Create Password"),
              CustomTextFormField(
                controller: passwordController,
                validator: AppValidators.password,
                hintText: "**********",
                prefixIcon: Icon(Icons.lock, color: Color(0xff5C6D65)),
                obscureText: _obscureText,
                suffixIcon: InkWell(
                  child: Icon(
                    _obscureText
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                  ),
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              const SizedBox(height: 30),
              BuildFieldLabel(label: "Confirm Password"),
              CustomTextFormField(
                controller: newPasswordController,
                validator: (value) => AppValidators.confirmPassword(
                  value,
                  passwordController!.text,
                ),
                hintText: "**********",
                prefixIcon: Icon(Icons.lock_reset, color: Color(0xff5C6D65)),
                obscureText: _obscureConfirmPassword,
                suffixIcon: InkWell(
                  child: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                  ),
                  onTap: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
              ),
              const SizedBox(height: 30),

              // زرار التسجيل
              CustomClickableContainer(
                text: "Register Account",
                prefixIcon: Icon(
                  Icons.person_add_alt_1_outlined,
                  color: AppColors.primaryGreen,
                ),
                onTap: () {
                  // validate fields before proceeding
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigations.pushTo(context, MainAppScreen());
                  }
                },
              ),
              const SizedBox(height: 20),
              TextWithDifferentColor(
                text1: "Already have an account? ",
                text2: 'Log in',
                widget: LoginScreen(),
              ),
              32.H,
            ],
          ),
        ),
      ),
    );
  }
}
