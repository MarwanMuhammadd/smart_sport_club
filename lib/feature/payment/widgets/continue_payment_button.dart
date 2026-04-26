import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';

class ContinuePaymentButton extends StatelessWidget {
  const ContinuePaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: MainButton(
        text: 'Continue to Payment',
        onPressed: () {
          // Handle payment continuation
        },
        bgColor: AppColors.primaryGreen,
        height: 55,
        width: double.infinity,
      ),
    );
  }
}
