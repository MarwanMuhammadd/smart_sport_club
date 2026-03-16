import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/funcations/validators.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/custom_text_form_fields.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/feature/auth/pages/login_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  // Logic للتحقق من كلمة السر
  bool isEightCharacters = false;
  bool hasSpecialChar = false;
  bool passwordsMatch = false; // دي بنحتاجها لو فيه field تاني للتأكيد
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
    return Scaffold(
      backgroundColor: AppColors.blueColor, // لون الخلفية الداكن من الصورة
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Admin Portal",
          style: TextStyles.body.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Container(
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
              ),
              const SizedBox(height: 24),
              Text(
                "Admin Login",
                style: TextStyles.hugeHeadLine.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                "Secure access for smart sports club management",
                style: TextStyles.caption1.copyWith(color: Colors.white60),
              ),
              const SizedBox(height: 40),

              // الحقول النصية (باستخدام الـ Widgets بتاعتك)
              _buildLabel("Admin Email"),
              CustomTextFormField(
                validator: AppValidators.email,
                hintText: "admin@sportsclub.com",
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),

              _buildLabel("Admin Password"),
              CustomTextFormField(
                validator: AppValidators.password,
                hintText: "••••••••",
                onChanged: onPasswordChanged,
                obscureText: _obscurePassword,
                prefixIcon: const Icon(Icons.lock_outline, color: Colors.black),
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

              // --- Password Validation UI (الصورة التانية) ---
              _buildValidationSection(),

              const SizedBox(height: 25),
              _buildLabel("Club Code or Admin Key"),
              CustomTextFormField(
                validator: AppValidators.clubCode,
                hintText: "XXXX-XXXX-XXXX",
                prefixIcon: const Icon(
                  Icons.vpn_key_outlined,
                  color: Colors.white30,
                ),
                suffixIcon: const Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white30,
                ),
              ),
              const SizedBox(height: 40),

              // زرار الدخول (MainButton بتاعك)
              MainButton(
                text: "Login as Administrator",
                bgColor: const Color(0xff2563EB), // اللون الأزرق من الصورة
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    Navigations.pushTo(context, LoginScreen());
                  }
                },
                textStyle: TextStyles.title.copyWith(color: Colors.white),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ميثود مساعدة للـ Label
  Widget _buildLabel(String label) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        label,
        style: TextStyles.caption1.copyWith(color: Colors.white70),
      ),
    );
  }

  // الـ Password Validation Widget
  Widget _buildValidationSection() {
    return Column(
      children: [
        // الخطوط الملونة (Indicators)
        Row(
          children: [
            _buildIndicator(isActive: isEightCharacters),
            const SizedBox(width: 8),
            _buildIndicator(isActive: hasSpecialChar),
            const SizedBox(width: 8),
            _buildIndicator(isActive: false), // للـ Passwords Match مثلاً
          ],
        ),
        const SizedBox(height: 15),
        // نصوص الشروط
        _buildRequirement("At least 8 characters", isEightCharacters),
        const SizedBox(height: 12),
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
        height: 4,
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryGreen : AppColors.accentGrey,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildRequirement(String text, bool isMet) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle,
          size: 16,
          color: isMet ? AppColors.primaryGreen : Colors.white24,
        ),
        const SizedBox(width: 10),
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
