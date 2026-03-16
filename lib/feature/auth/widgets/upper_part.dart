import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/funcations/validators.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/custom_text_form_fields.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/core/widgets/text_with_different_color.dart';
import 'package:smart_sport_club/feature/auth/pages/login_screen.dart';
import 'package:smart_sport_club/feature/auth/pages/otp_screen.dart';
import 'package:smart_sport_club/feature/auth/widgets/build_field_label.dart';

class UpperPart extends StatefulWidget {
  const UpperPart({super.key});

  @override
  State<UpperPart> createState() => _UpperPartState();
}

class _UpperPartState extends State<UpperPart> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.chevron_left),
                  12.W,
                  Text(
                    "Back to login",
                    style: TextStyles.caption1.copyWith(
                      color: AppColors.secondaryColor,
                    ),
                  ),
                ],
              ),
              12.H,
              Text(
                "Forgot Password?",
                style: TextStyles.headline.copyWith(
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              12.H,
              Text(
                "No worries! Enter your registered email or phone number and we'll send you a 6-digit reset code to get you back in the game.",
                style: TextStyles.caption2.copyWith(
                  color: AppColors.secondaryColor,
                  // fontWeight: FontWeight.w700,
                ),
              ),
              12.H,
              BuildFieldLabel(
                label: "Phone Number",
                color: AppColors.blackColor,
              ),
              const CustomTextFormField(
                validator: AppValidators.phone,
                hintText: "0102324....",
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Color(0xff5C6D65),
                ),
              ),
              12.H,

              MainButton(
                text: "SEND RESET CODE",
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    Navigations.pushTo(context, OtpScreen());
                  }
                },
              ),
              12.H,

              Divider(color: AppColors.accentGrey),
              12.H,

              TextWithDifferentColor(
                text1: "Having trouble? ",
                text2: 'Contact Smart Sports Support',
                widget: LoginScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
