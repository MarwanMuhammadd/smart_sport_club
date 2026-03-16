import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/funcations/validators.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/core/widgets/text_with_different_color.dart';
import 'package:smart_sport_club/feature/auth/pages/create_new_screen.dart';
import 'package:smart_sport_club/feature/auth/pages/login_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final keyForm = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.backgroundColor),
      body: Padding(
        padding: const EdgeInsets.all(20.0),

        child: SingleChildScrollView(
          child: Form(
            key: keyForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 1),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryGreen.withOpacity(.09),
                        borderRadius: BorderRadius.circular(70),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Icon(
                        Icons.security,
                        size: 80,
                        color: AppColors.primaryGreen,
                      ),
                    ),
                  ],
                ),
                20.H,

                Text(
                  "OTP Verification",
                  style: TextStyles.title.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "We have sent SMS to: 01xxxxxxxxx",
                  style: TextStyles.caption1,
                ),
                SizedBox(height: 32),
                Center(
                  child: Pinput(
                    controller: controller,
                    validator: (value) => AppValidators.otp(value, length: 5),
                    keyboardType: TextInputType.number,
                    length: 5,
                    autofocus: true,
                    
                  ),
                ),
                SizedBox(height: 32),

                MainButton(
                  text: "Verify Identity",
                  onPressed: () {
                    if (keyForm.currentState?.validate() ?? false) {
                      Navigations.pushTo(context, CreateNewPassword());
                    }
                  },
                ),
                32.H,
                TextWithDifferentColor(
                  text1: "Didn't receive the code? ",
                  text2: "Resend Code",
                  widget: LoginScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
