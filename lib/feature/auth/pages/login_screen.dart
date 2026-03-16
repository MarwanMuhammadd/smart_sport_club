import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/funcations/validators.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/core/widgets/text_with_different_color.dart';
import 'package:smart_sport_club/feature/auth/pages/register_screen.dart';
import 'package:smart_sport_club/feature/auth/pages/request_password_screen.dart';
import 'package:smart_sport_club/feature/auth/widgets/text_field_withlabel.dart';
import 'package:smart_sport_club/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Club Access",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigations.pop(context),
          icon: const Icon(Icons.chevron_left, size: 32, color: Colors.black),
        ),
      ),
      body: SafeArea(
        // عشان نضمن إن الـ UI ميتدخلش مع نوتش الموبايل
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. الجزء بتاع الكارت (يفضل تعمله ويدجت منفصلة بـ Gradient)
                      _buildMembershipCard(),

                      30.H,
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      20.H,

                      TextFieldWithlabel(
                        path: AppImages.idIconSvg,
                        label: "Membership ID",
                        hint: "Enter ID number",
                        validator: AppValidators.numeric,
                      ),
                      16.H,
                      TextFieldWithlabel(
                        validator: AppValidators.numeric,
                        path: AppImages.sequenceSvg,
                        label: "Sequence Number",
                        hint: "Enter Sequence Code",
                      ),
                      16.H,
                      TextFieldWithlabel(
                        obscureText: _obscurePassword,
                        suffixIcon: InkWell(
                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off_outlined,
                          ),
                          onTap: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),

                        validator: AppValidators.password,
                        path: AppImages.lockSvg,
                        label: "Password",
                        hint: "********",
                        //isPassword: true, // ضيفنا بروبرتي للباسورد
                      ),

                      10.H,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigations.pushTo(
                              context,
                              RequestPasswordScreen(),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyles.caption1.copyWith(
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      20.H,
                      MainButton(
                        text: "Sign In to Club",
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            Navigations.pushReplacement(context, MainAppScreen());
                          }
                        },
                      ),

                      25.H,
                      TextWithDifferentColor(
                        text1: "Don't have an account? ",
                        text2: 'Register Now',
                        widget: RegisterScreen(),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. زرار الـ Customer Service (مهم جداً يكون تحت خالص)
            ],
          ),
        ),
      ),
    );
  }

  // ويدجت الكارت عشان تطلع احترافية زي الصورة
  Widget _buildMembershipCard() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [AppColors.primaryGreen, AppColors.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Stack(
        children: [
          // حط هنا تفاصيل الكارت (Elite Sports Club, QR Code, etc.)
          Align(
            alignment: Alignment.topRight,
            child: Icon(Icons.qr_code_scanner, color: Colors.white, size: 40),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "PREMIUM MEMBER",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  letterSpacing: 2,
                ),
              ),
              Text(
                "Elite Sports Club",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "DIGITAL ACCESS KEY",
                style: TextStyle(color: Colors.white70, fontSize: 10),
              ),
              Text(
                "•••• •••• •••• 9842",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
