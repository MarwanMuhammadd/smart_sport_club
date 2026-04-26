import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';

import 'payment_method_card.dart';

class PaymentMethodsSection extends StatelessWidget {
  const PaymentMethodsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Text(
          'Select Payment Method',
          style: TextStyles.headline.copyWith(color: AppColors.primaryColor),
        ),
        const PaymentMethodCard(title: 'Credit / Debit Card', isSelected: true),
        const PaymentMethodCard(
          title: 'Mobile Wallet',
          subtitle: 'Vodafone Cash, Orange Money',
          isSelected: false,
        ),
        const PaymentMethodCard(
          title: 'Pay at Club',
          subtitle: 'Complete payment at the club',
          isSelected: false,
        ),
      ],
    );
  }
}
