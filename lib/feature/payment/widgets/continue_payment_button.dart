import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_sport_club/core/funcations/navigations.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'confirm_subscription_bottom_sheet.dart';

class ContinuePaymentButton extends StatelessWidget {
  final String plan;
  final String paymentMethod;

  const ContinuePaymentButton({
    super.key,
    required this.plan,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: MainButton(
        text: 'Continue to Payment',
        onPressed: () {
          showConfirmSubscriptionBottomSheet(
            context: context,
            plan: plan,
            paymentMethod: paymentMethod,
            onConfirm: () {
              final now = DateTime.now();
              final startDate = DateFormat('dd MMM yyyy').format(now);
              
              DateTime expiryDateTime;
               if (plan.contains('Gold')) {
                expiryDateTime = DateTime(now.year, now.month + 6, now.day);
              } else {
                expiryDateTime = DateTime(now.year + 1, now.month, now.day);
              }
              
              final expiryDate = DateFormat('dd MMM yyyy').format(expiryDateTime);

              Navigations.pushTo(
                context, 
                AppRoutes.paymentSuccessful, 
                extra: {
                  'membershipType': plan,
                  'paymentMethod': paymentMethod,
                  'startDate': startDate,
                  'expiryDate': expiryDate,
                },
              );
            },
          );
        },
        bgColor: AppColors.primaryGreen,
        height: 55,
        width: double.infinity,
      ),
    );
  }
}
